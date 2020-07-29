local _, ns = ...
local B, C, L, DB = unpack(ns)
local M = B:GetModule("Misc")

local debugMode = false
local completedQuest, initComplete = {}
local strmatch, strfind, gsub, format = string.match, string.find, string.gsub, string.format
local mod, tonumber, pairs, floor = mod, tonumber, pairs, math.floor
local soundKitID = SOUNDKIT.ALARM_CLOCK_WARNING_3
local QUEST_COMPLETE = QUEST_COMPLETE
local LE_QUEST_TAG_TYPE_PROFESSION = Enum.QuestTagType.Profession
local LE_QUEST_FREQUENCY_DAILY = Enum.QuestFrequency.Daily

local function acceptText(link, daily)
	if daily then
		return format("%s [%s]%s", L["AcceptQuest"], DAILY, link)
	else
		return format("%s %s", L["AcceptQuest"], link)
	end
end

local function completeText(link)
	PlaySound(soundKitID, "Master")
	return format("%s %s", link, QUEST_COMPLETE)
end

local function sendQuestMsg(msg)
	if NDuiDB["Misc"]["OnlyCompleteRing"] then return end

	if debugMode and DB.isDeveloper then
		print(msg)
	elseif IsPartyLFG() then
		SendChatMessage(msg, "INSTANCE_CHAT")
	elseif IsInRaid() then
		SendChatMessage(msg, "RAID")
	elseif IsInGroup() and not IsInRaid() then
		SendChatMessage(msg, "PARTY")
	end
end

local function getPattern(pattern)
	pattern = gsub(pattern, "%(", "%%%1")
	pattern = gsub(pattern, "%)", "%%%1")
	pattern = gsub(pattern, "%%%d?$?.", "(.+)")
	return format("^%s$", pattern)
end

local questMatches = {
	["Found"] = getPattern(ERR_QUEST_ADD_FOUND_SII),
	["Item"] = getPattern(ERR_QUEST_ADD_ITEM_SII),
	["Kill"] = getPattern(ERR_QUEST_ADD_KILL_SII),
	["PKill"] = getPattern(ERR_QUEST_ADD_PLAYER_KILL_SII),
	["ObjectiveComplete"] = getPattern(ERR_QUEST_OBJECTIVE_COMPLETE_S),
	["QuestComplete"] = getPattern(ERR_QUEST_COMPLETE_S),
	["QuestFailed"] = getPattern(ERR_QUEST_FAILED_S),
}

function M:FindQuestProgress(_, msg)
	if not NDuiDB["Misc"]["QuestProgress"] then return end
	if NDuiDB["Misc"]["OnlyCompleteRing"] then return end

	for _, pattern in pairs(questMatches) do
		if strmatch(msg, pattern) then
			local _, _, _, cur, max = strfind(msg, "(.*)[:：]%s*([-%d]+)%s*/%s*([-%d]+)%s*$")
			cur, max = tonumber(cur), tonumber(max)
			if cur and max and max >= 10 then
				if mod(cur, floor(max/5)) == 0 then
					sendQuestMsg(msg)
				end
			else
				sendQuestMsg(msg)
			end
			break
		end
	end
end

function M:FindQuestAccept(questID)
	local link = GetQuestLink(questID)
	local questLogIndex = C_QuestLog.GetLogIndexForQuestID(questID)
	if link and questLogIndex then
		local info = C_QuestLog.GetInfo(questLogIndex)
		local frequency = info.frequency
		local tagID, _, worldQuestType = C_QuestLog.GetQuestTagInfo(questID)
		if tagID == 109 or worldQuestType == LE_QUEST_TAG_TYPE_PROFESSION then return end
		sendQuestMsg(acceptText(link, frequency == LE_QUEST_FREQUENCY_DAILY))
	end
end

function M:FindQuestComplete()
	for i = 1, C_QuestLog.GetNumQuestLogEntries() do
		local info = C_QuestLog.GetInfo(i)
		local questID = info.questID
		local isComplete = C_QuestLog.IsComplete(questID)
		local link = GetQuestLink(questID)
		local worldQuest = select(3, C_QuestLog.GetQuestTagInfo(questID))
		if link and isComplete and not completedQuest[questID] and not worldQuest then
			if initComplete then
				sendQuestMsg(completeText(link))
			end
			completedQuest[questID] = true
		end
	end
	initComplete = true
end

function M:FindWorldQuestComplete(questID)
	if QuestUtils_IsQuestWorldQuest(questID) then
		local link = GetQuestLink(questID)
		if link and not completedQuest[questID] then
			sendQuestMsg(completeText(link))
			completedQuest[questID] = true
		end
	end
end

function M:QuestNotifier()
	if NDuiDB["Misc"]["QuestNotifier"] then
		M:FindQuestComplete()
		B:RegisterEvent("QUEST_ACCEPTED", M.FindQuestAccept)
		B:RegisterEvent("QUEST_LOG_UPDATE", M.FindQuestComplete)
		B:RegisterEvent("QUEST_TURNED_IN", M.FindWorldQuestComplete)
		B:RegisterEvent("UI_INFO_MESSAGE", M.FindQuestProgress)
	else
		wipe(completedQuest)
		B:UnregisterEvent("QUEST_ACCEPTED", M.FindQuestAccept)
		B:UnregisterEvent("QUEST_LOG_UPDATE", M.FindQuestComplete)
		B:UnregisterEvent("QUEST_TURNED_IN", M.FindWorldQuestComplete)
		B:UnregisterEvent("UI_INFO_MESSAGE", M.FindQuestProgress)
	end
end
M:RegisterMisc("QuestNotifier", M.QuestNotifier)