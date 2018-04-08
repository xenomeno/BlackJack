local HIT = 1
local STICK = 2
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

local function GeneratePlayerInitPolicy()
	local policy, Q, returns = {}, {}, {}
	for _, usable_ace in ipairs({true, false}) do
		for score = MIN_SCORE, 21 do
			for _, dealer_face in ipairs(s_CardScores) do
				local s = GetState(usable_ace, score, dealer_face)
				policy[s] = (score <= s_InitHit) and HIT or STICK
				Q[s] = { [HIT] = 0.0, [STICK] = 0.0 }
				returns[s] = { [HIT] = {sum = 0.0, count = 0}, [STICK] = {sum = 0.0, count = 0} }
			end
		end
	end
	
	return policy, Q, returns
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
			action = action or policy[s]
			if type(action) == "table" then
				action = action[math.random(1, #action)]
			end
			table.insert(episode, { s = s, a = action })
		else
			action = action or GetPolicyAction(policy, usable_ace, score, "A")  -- no face for dealer
		end
		if action == STICK then
			break
		end
		-- hit
		local card, card_score = GetCard()
		score = score + card_score
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

local function Blackjack(max_steps, max_no_improv_steps)
	local policy, Q, returns = GeneratePlayerInitPolicy()
	local dealer_policy = GenerateDealerPolicy()
	
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
			local old_a = policy[s]
			if math.abs(Q[s][HIT] - Q[s][STICK]) < EPSILON then
				changed = type(policy[s] ~= "table")
				policy[s] = { HIT, STICK }
			else
				policy[s] = Q[s][HIT] > Q[s][STICK] and HIT or STICK
				if policy[s] ~= old_a then
					changed = true
				end
			end
		end
		step = step + 1
		if changed then
			no_improv_steps = 0
		else
			no_improv_steps = no_improv_steps + 1
		end
		if step % 100000 == 0 then
			print(string.format("Policy at step %d, no improvement steps: %s", step, no_improv_steps))
			PrintPolicy(policy)
			PrintStateActionValueFunction(Q)
		end
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

function RunBlackjack()
	-- fill all cards scores
	for _, card in ipairs(s_Cards) do
		s_Score[card] = s_Score[card] or tonumber(card)
	end

	local init_policy = GeneratePlayerInitPolicy()
	print("Player's Init policy")
	PrintPolicy(init_policy)
	local V = EstimateValueFunction(init_policy, 5000000)
	print("State-value function for initial policy")
	PrintStateValueFunction(V)
  
	local policy, steps, Q = Blackjack(50000000, 20000000)
	print(string.format("Generated policy in %d steps", steps))
	PrintPolicy(policy)
	print("Init Policy Performance: ", TestPolicy(init_policy, 1000000))
	print("Generated Policy Performance: ", TestPolicy(policy, 1000000))
	
	local V = CalcVFromQ(Q)
	print("State-value function for optimal policy")
	PrintStateValueFunction(V)
end

RunBlackjack()