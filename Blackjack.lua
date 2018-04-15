local HIT = 1
local STICK = 2
local ACTIONS = { HIT, STICK }
local MIN_SCORE = 12
local EPSILON = 0.0001

local s_Cards = { "A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K" }
local s_CardScores = { "A", 2, 3, 4, 5, 6, 7, 8, 9, 10 }
local s_Score = { ["A"] = 1, ["J"] = 10, ["Q"] = 10, ["K"] = 10 }
local s_InitHit = 19
local s_DealerHit = 16
local s_NumStates = 2 * (21 - MIN_SCORE + 1) * 10

local function GetState(usable_ace, score, dealer_face)
	return (usable_ace and 0 or 100) + (score - MIN_SCORE) * 10 + (s_Score[dealer_face] - 1)
end

local function StateToUsableAceScoreDealerFace(state)
	local usable_ace = state < 100
	local dealer_face = s_Cards[(state % 10) + 1]
	local score = (state - GetState(usable_ace, MIN_SCORE, dealer_face)) / 10 + MIN_SCORE
	
	return usable_ace, score, dealer_face
end

local function GenerateInitQReturns()
	local Q, returns = {}, {}
	for s = 0, s_NumStates - 1 do
		Q[s] = { [HIT] = 0.0, [STICK] = 0.0 }
		returns[s] = { [HIT] = {sum = 0.0, count = 0}, [STICK] = {sum = 0.0, count = 0} }
	end
	
	return Q, returns
end

local function GeneratePlayerInitPolicy()
	local policy = {}
	for _, usable_ace in ipairs({true, false}) do
		for score = MIN_SCORE, 21 do
			for _, dealer_face in ipairs(s_CardScores) do
				local s = GetState(usable_ace, score, dealer_face)
				policy[s] = (score <= s_InitHit) and HIT or STICK
			end
		end
	end
	
	return policy
end

local function GenerateRandomPolicy()
	local policy = {}
	for s = 0, s_NumStates - 1 do
		policy[s] = table.copy(ACTIONS)
	end
	
	return policy
end

local function GenerateEpsilonSoftPolicy(epsilon)
	local policy = { epsilon_soft = epsilon }
	for s = 0, s_NumStates - 1 do
		policy[s] = ACTIONS[math.random(1, #ACTIONS)]
	end
	
	return policy
end

local function GenerateDealerPolicy()
	local policy = {}
	for _, usable_ace in ipairs({true, false}) do
		for score = MIN_SCORE, 21 do
			for _, dealer_face in ipairs(s_CardScores)do
				local s = GetState(usable_ace, score, dealer_face)
				policy[s] = score <= s_DealerHit and HIT or STICK
			end
		end
	end
	
	return policy
end

local function PrintPolicy(policy)
	local cards = ""
	for _, v in ipairs(s_CardScores) do
		cards = cards .. v
	end
	cards = cards .. "   "
	for _, v in ipairs(s_CardScores) do
		cards = cards .. v
	end

	print("Usable ace    NON-usable ace")
	print(cards)
	for score = 21, MIN_SCORE, -1 do
		local str = ""
		for _, dealer_face in ipairs(s_CardScores)do
			local s = GetState(true, score, dealer_face)
			str = str .. (policy[s] == STICK and "S" or (policy[s] == HIT and " " or "?"))
		end
		str = str .. " " .. tostring(score) .. " "
		for _, dealer_face in ipairs(s_CardScores)do
			local s = GetState(false, score, dealer_face)
			str = str .. (policy[s] == STICK and "S" or (policy[s] == HIT and " " or "?"))
		end
		print(str)
	end
	local str = ""
	for _, _ in ipairs(s_CardScores)do
		str = str .. " "
	end
	print(str .. " " .. tostring(11))
	print(cards)
end

local function PrintStateValueFunction(V)
	for _, usable_ace in ipairs({true, false}) do
		print("State-value function for " .. (usable_ace and "" or "NON-") .. "usable ace")
		for score = 21, MIN_SCORE, -1 do
			local str = "{ "
			for _, dealer_face in ipairs(s_CardScores) do
				local s = GetState(usable_ace, score, dealer_face)
				str = str .. string.format("%s%.2f ", V[s] > 0 and "+" or "", V[s])
			end
			str = str .. " }"
			print(str)
		end
	end
end

local function PrintStateActionValueFunction(Q)
	for _, usable_ace in ipairs({true, false}) do
		print("State-Action-value function for " .. (usable_ace and "" or "NON-") .. "usable ace")
		for score = 21, MIN_SCORE, -1 do
			local str = "{ "
			for _, dealer_face in ipairs(s_CardScores) do
				local s = GetState(usable_ace, score, dealer_face)
				str = str .. string.format("[%s%.2f %s%.2f]", Q[s][HIT] > 0 and "+" or "", Q[s][HIT], Q[s][STICK] > 0 and "+" or "", Q[s][STICK])
			end
			str = str .. " }"
			print(str)
		end
	end
end

local function GetCard()
	local card = s_Cards[math.random(#s_Cards)]
	return card, s_Score[card]
end

local function GetFirstCards(min_score, face_given)
	local face, score
	if face_given then
		face = face_given
		score = s_Score[face]
	else
		face, score = GetCard()
	end	
	local usable_ace = false
	if face == "A" then
		usable_ace = true
		score = score + 10
	end
	
	local at_least_once = true
	while at_least_once or (min_score and score < min_score) do
		at_least_once = false
		local card, card_score = GetCard()
		if card == "A" then
			if score + 11 <= 21 then
				usable_ace = true
				score = score + 11
			else
				score = score + 1
			end
		else
			score = score + card_score
		end
	end
	
	return face, score, usable_ace
end

local function GetPolicyAction(policy, usable_ace, score, dealer_face)
	return (score < MIN_SCORE) and HIT or policy[GetState(usable_ace, score, dealer_face)]
end

local function PlayPolicy(policy, score, usable_ace, dealer_face, action)
	local episode = dealer_face and {}
	while score <= 21 do
		if episode then
			local s = GetState(usable_ace, score, dealer_face)
			if policy.epsilon_soft then
				if math.random() < 1.0 - policy.epsilon_soft then
					action = policy[s]
				else
					action = ACTIONS[math.random(1, #ACTIONS)]
				end
			else
				action = action or policy[s]
				if type(action) == "table" then
					action = action[math.random(1, #action)]
				end
			end
			table.insert(episode, { s = s, a = action })
		else
			action = GetPolicyAction(policy, usable_ace, score, "A")  -- no face for dealer
		end
		if action == STICK then
			break
		end
		-- hit
		local card, card_score = GetCard()
    if card == "A" and score + 11 <= 21 then
        -- this can work only for dealer since player min score is 12
        score = score + 11
        usable_ace = true
    else
      score = score + card_score
    end
		if score > 21 and usable_ace then
			score = score - 10
			usable_ace = false
		end
		action = false
	end
	
	return score, episode
end

local function GenerateEpisode(score, action, usable_ace, policy, dealer_face, dealer_score, dealer_usable_ace, dealer_policy)
	-- player's turn
	local player_score, episode = PlayPolicy(policy, score, usable_ace, dealer_face, action)
	if player_score > 21 then
		-- player goes bust
		return episode, -1.0
	end
	
	-- dealer's turn
	dealer_score = PlayPolicy(dealer_policy, dealer_score, dealer_usable_ace)
	if dealer_score > 21 then
		-- dealer goes bust
		return episode, 1.0
	end
	
	local r = (dealer_score == player_score) and 0.0 or ((player_score > dealer_score) and 1.0 or -1.0)
	
	return episode, r
end

local function TestPolicy(policy, tests)
	local dealer_policy = GenerateDealerPolicy()
	
	local total_score = 0.0
	for i = 1, tests do
		local dealer_face, dealer_score, dealer_usable_ace = GetFirstCards()
		local _, score, ace = GetFirstCards(MIN_SCORE)
		local _, G = GenerateEpisode(score, nil, ace, policy, dealer_face, dealer_score, dealer_usable_ace, dealer_policy)
		total_score = total_score + G
	end
	
	return total_score / tests
end

local function EstimateValueFunction(policy, runs)
	local V, returns = {}, {}
	for s = 0, s_NumStates - 1 do
		V[s] = 0.0
		returns[s] = { sum = 0.0, count = 0 }
	end
	
	local dealer_policy = GenerateDealerPolicy()
	
	for r = 1, runs do
		local s = math.random(0, s_NumStates - 1)
		local action = math.random() < 0.5 and HIT or STICK
		local ace, score, face = StateToUsableAceScoreDealerFace(s)
		local dealer_face, dealer_score, dealer_usable_ace = GetFirstCards(nil, face)
		local episode, G = GenerateEpisode(score, action, ace, policy, dealer_face, dealer_score, dealer_usable_ace, dealer_policy)
		for idx = #episode, 1, -1 do
			local step = episode[idx]
      local ret = returns[step.s]
      ret.sum = ret.sum + G
      ret.count = ret.count + 1
			V[step.s] = ret.sum / ret.count
		end
	end
	
	return V	
end

local function MonteCarloES(max_steps, max_no_improv_steps)
	local policy = GeneratePlayerInitPolicy()
	local dealer_policy = GenerateDealerPolicy()
	local Q, returns = GenerateInitQReturns()
	
	local step, no_improv_steps = 0, 0
	while step < max_steps and no_improv_steps < max_no_improv_steps do
		-- random start
		local s = math.random(0, s_NumStates - 1)
		local action = math.random() < 0.5 and HIT or STICK
		local ace, score, face = StateToUsableAceScoreDealerFace(s)
		local dealer_face, dealer_score, dealer_usable_ace = GetFirstCards(nil, face)
		
		local episode, G = GenerateEpisode(score, action, ace, policy, dealer_face, dealer_score, dealer_usable_ace, dealer_policy)
		local changed = false
		for i = #episode, 1, -1 do
			local s, a = episode[i].s, episode[i].a
			local ret = returns[s][a]
			ret.count = ret.count + 1
			ret.sum = ret.sum + G
			Q[s][a] = ret.sum / ret.count
			if math.abs(Q[s][HIT] - Q[s][STICK]) < EPSILON then
				changed = type(policy[s] ~= "table")
				policy[s] = { HIT, STICK }
			else
				local old_a = policy[s]
				policy[s] = Q[s][HIT] > Q[s][STICK] and HIT or STICK
				changed = changed or (policy[s] ~= old_a)
			end
		end
		step = step + 1
		if changed then
			no_improv_steps = 0
		else
			no_improv_steps = no_improv_steps + 1
		end
		if step % 100000 == 0 then
			print(string.format("ES Policy at step %d, no improvement steps: %s", step, no_improv_steps))
			PrintPolicy(policy)
			PrintStateActionValueFunction(Q)
		end
	end
		
	return policy, step, Q
end

local function MonteCarloOnPolicy(eps_soft, max_steps, max_no_improv_steps)
	local policy = GenerateEpsilonSoftPolicy(eps_soft)
	local dealer_policy = GenerateDealerPolicy()
	local Q, returns = GenerateInitQReturns()
	
	local step, no_improv_steps = 0, 0
	while step < max_steps and no_improv_steps < max_no_improv_steps do
		-- random start
		local s = math.random(0, s_NumStates - 1)
		local ace, score, face = StateToUsableAceScoreDealerFace(s)
		local dealer_face, dealer_score, dealer_usable_ace = GetFirstCards(nil, face)
		
		local episode, G = GenerateEpisode(score, nil, ace, policy, dealer_face, dealer_score, dealer_usable_ace, dealer_policy)
		local changed = false
		for i = #episode, 1, -1 do
			local s, a = episode[i].s, episode[i].a
			local ret = returns[s][a]
			ret.count = ret.count + 1
			ret.sum = ret.sum + G
			Q[s][a] = ret.sum / ret.count
			local old_a = policy[s]
			policy[s] = Q[s][HIT] > Q[s][STICK] and HIT or STICK
			changed = changed or (policy[s] ~= old_a)
		end
		step = step + 1
		if changed then
			no_improv_steps = 0
		else
			no_improv_steps = no_improv_steps + 1
		end
		if step % 100000 == 0 then
			print(string.format("On-Policy(%f epsilon) at step %d, no improvement steps: %s", eps_soft,  step, no_improv_steps))
			PrintPolicy(policy)
			PrintStateActionValueFunction(Q)
		end
	end
		
	return policy, step, Q
end

local function MonteCarloOffPolicy(eps_soft, max_steps, max_no_improv_steps, weighted_sampling, init_state, behavior_policy, episode_callback)
	local dealer_policy = GenerateDealerPolicy()
	local Q, C, policy = {}, {}, {}
	for s = 0, s_NumStates - 1 do
		Q[s], C[s] = {}, {}
		for _, a in ipairs(ACTIONS) do
			Q[s][a] = math.random() * 2.0 - 1.0
			C[s][a] = 0.0
			policy[s] = (not policy[s] or Q[s][policy[s]] < Q[s][a]) and a or policy[s]
		end
	end
	
	local step, no_improv_steps = 0, 0
	while step < max_steps and no_improv_steps < max_no_improv_steps do
		-- random behavior policy
		local behavior = behavior_policy or GenerateEpsilonSoftPolicy(eps_soft)
		local prob = (not behavior_policy) and behavior.epsilon_soft / #ACTIONS
		
		-- random start
		local s = init_state or math.random(0, s_NumStates - 1)
		local ace, score, face = StateToUsableAceScoreDealerFace(s)
		local dealer_face, dealer_score, dealer_usable_ace = GetFirstCards(nil, face)
		
		local episode, G = GenerateEpisode(score, nil, ace, behavior, dealer_face, dealer_score, dealer_usable_ace, dealer_policy)
		local W = 1.0
		local changed = false
		for i = #episode, 1, -1 do
			local s, a = episode[i].s, episode[i].a
			C[s][a] = C[s][a] + (weighted_sampling and W or 1.0)
			Q[s][a] = Q[s][a] + W * (G - Q[s][a]) / C[s][a]
			local old_a = policy[s]
			policy[s] = Q[s][HIT] > Q[s][STICK] and HIT or STICK
			changed = changed or (policy[s] ~= old_a)
			if policy[s] ~= a then break end
			local b
			if behavior_policy then
				b = (1.0 / #behavior_policy[s])
			else
				b = (behavior[s] == a) and (1.0 - behavior.epsilon_soft + prob) or prob
			end
			W = W / b
		end
		step = step + 1
		if changed then
			no_improv_steps = 0
		else
			no_improv_steps = no_improv_steps + 1
		end
		if episode_callback then
			episode_callback(init_state, step, Q[init_state], weighted_sampling)
		end
		if step % 100000 == 0 then
			print(string.format("Off-Policy(%f epsilon) at step %d, no improvement steps: %s", eps_soft, step, no_improv_steps))
			PrintPolicy(policy)
			PrintStateActionValueFunction(Q)
		end
	end
	
	if init_state then
		return policy[init_state], step, Q[init_state]
	end
		
	return policy, step, Q
end

local function CalcVFromQ(Q)
    local V = {}
    for s = 0, s_NumStates - 1 do
        local hit, stick = Q[s][HIT], Q[s][STICK]
        V[s] = hit > stick and hit or stick
    end
    
    return V
end

local function OrdinaryVsWeightedSampling(state, averaging_episodes, learning_episodes, runs)
	local target = GeneratePlayerInitPolicy()
	local behavior = GenerateRandomPolicy()
	local dealer_policy = GenerateDealerPolicy()
	
	local usable_ace, score, face = StateToUsableAceScoreDealerFace(state)
	
	print(string.format("Calculating estimate during %d episodes for State %d[%s,%d,%s]...", averaging_episodes, state, usable_ace and "ACE" or "", score, face))
	local state_estimate = 0.0
	for i = 1, averaging_episodes do
		local dealer_face, dealer_score, dealer_usable_ace = GetFirstCards(nil, face)
		local _, G = PlayPolicy(target, score, usable_ace, dealer_face)
		local _, G = GenerateEpisode(score, nil, usable_ace, target, dealer_face, dealer_score, dealer_usable_ace, dealer_policy)
		state_estimate = state_estimate + G
	end
	state_estimate = state_estimate / averaging_episodes
	print(string.format("State %d[%s,%d,%s] estimate: %f", state, usable_ace and "ACE" or "", score, face, state_estimate))
	
	local err = { ["weighted"] = {}, ["ordinary"] = {}}
	for step = 1, learning_episodes do
		err["weighted"][step] = 0.0
    err["ordinary"][step] = 0.0
	end
	
	local function on_episode_terminate(state, step, Q_state, weighted_sampling)
		local estimate = table.max(Q_state)
		local diff = state_estimate - estimate
    local field = weighted_sampling and "weighted" or "ordinary"
		err[field][step] = err[field][step] + diff * diff
	end
	
	for i = 1, runs do
		local action, _, Q_state = MonteCarloOffPolicy(0.01, learning_episodes, learning_episodes, false, state, behavior, on_episode_terminate)
	end
	for i = 1, runs do
		local action, _, Q_state = MonteCarloOffPolicy(0.01, learning_episodes, learning_episodes, "weighted", state, behavior, on_episode_terminate)
	end
	
	for _, sampling in ipairs({"ordinary", "weighted"}) do
    local err = err[sampling]
    err[1] = err[1] / runs
    local min, max, avg = err[1], err[1], err[1]
    for step = 2, learning_episodes do
      local step_avg = err[step] / runs
      err[step] = step_avg
      if step_avg < min then
        min = step_avg
      elseif step_avg > max then
        max = step_avg
      end
      avg = avg + step_avg
    end
    avg = avg / learning_episodes
    print(string.format("%s Importance Sampling min/max/avg squared error: %f/%f/%f", sampling, min, max, avg))
  end
end

function RunBlackjack()
	-- fill all cards scores
	for _, card in ipairs(s_Cards) do
		s_Score[card] = s_Score[card] or tonumber(card)
	end
	
	OrdinaryVsWeightedSampling(GetState(true, 13, 2), 100000000, 10000, 100)

	local init_policy = GeneratePlayerInitPolicy()
	local V = EstimateValueFunction(init_policy, 5000000)
	print("State-value function for initial policy")
	PrintStateValueFunction(V)
  
  local max_steps =
  {
      ["off-policy"] =  { max_steps = 150000000, max_no_improv_steps = 70000000 },
      ["on-policy"] =   { max_steps = 200000000, max_no_improv_steps = 70000000 },
      ["es-starts"] =   { max_steps = 50000000, max_no_improv_steps = 20000000 }
  }
	
	local off_policy = {}
  local epsilon = 0.1
	for i = 1, 5 do
		local policy, steps, Q = MonteCarloOffPolicy(epsilon, max_steps["off-policy"].max_steps, max_steps["off-policy"].max_no_improv_steps)
		local V = CalcVFromQ(Q)
		local performance = TestPolicy(policy, 1000000)
		table.insert(off_policy, { epsilon = epsilon, policy = policy, steps = steps, Q = Q, V = V, performance = performance})
    epsilon = epsilon / 10
	end
  
	local on_policy = {}
  local epsilon = 0.1
	for i = 1, 5 do
		local policy, steps, Q = MonteCarloOnPolicy(epsilon, max_steps["on-policy"].max_steps, max_steps["on-policy"].max_no_improv_steps)
		local V = CalcVFromQ(Q)
		local performance = TestPolicy(policy, 1000000)
		table.insert(on_policy, { epsilon = epsilon, policy = policy, steps = steps, Q = Q, V = V, performance = performance})
    epsilon = epsilon / 10
	end
  
	local es_policy, es_steps, Q = MonteCarloES(max_steps["es-starts"].max_steps, max_steps["es-starts"].max_no_improv_steps)
  
	print("Player's Init policy")
	PrintPolicy(init_policy)
	print("Init Policy Performance: ", TestPolicy(init_policy, 1000000))
	print(string.format("Monte Carlo ES policy in %d steps", es_steps))
	PrintPolicy(es_policy)
	print("Monte Carlo ES Policy Performance: ", TestPolicy(es_policy, 1000000))
  
	local best_on_policy, best_on_policy_performance
	for _, descr in ipairs(on_policy) do
		print(string.format("Monte Carlo On-Policy: %f epsilon in %d steps", descr.epsilon, descr.steps))
		print("Monte Carlo On-Policy Performance: ", descr.performance) 
		if (not best_on_policy_performance) or (best_on_policy_performance < descr.performance) then
			best_on_policy_performance = descr.performance
			best_on_policy = descr.policy
		end
	end
	print("Best On-Policy")
	PrintPolicy(best_on_policy)
	print("Best Monte Carlo On-Policy Performance: ", best_on_policy_performance)
  
	local best_off_policy, best_off_policy_performance, off_Q
	for _, descr in ipairs(off_policy) do
		print(string.format("Monte Carlo Off-Policy: %f epsilon in %d steps", descr.epsilon, descr.steps))
		print("Monte Carlo Off-Policy Performance: ", descr.performance) 
		if (not best_off_policy_performance) or (best_off_policy_performance < descr.performance) then
			best_off_policy_performance = descr.performance
			best_off_policy = descr.policy
      off_Q = descr.Q
		end
	end
	print("Best Off-Policy")
	PrintPolicy(best_off_policy)
	print("Best Monte Carlo Off-Policy Performance: ", best_off_policy_performance) 
	
	print("State-value function for optimal policy")
	V = CalcVFromQ(off_Q)
	PrintStateValueFunction(V)
end

RunBlackjack()