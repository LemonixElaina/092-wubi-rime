--[[
*** 已废弃 ***

@intro: 若出现 Emoji 候选，则放至最后
@author: Lemon1x
@state: 有 Bug，启用 Emoji 后此脚本没反应
--]]

function contains_emoji(str)
    -- Emoji通常位于这些Unicode范围内
    local emoji_pattern = "[\xF0-\xF7][\x90-\xBF][\x80-\xBF][\x80-\xBF]"
    return string.find(str, emoji_pattern) ~= nil
end


local function filter(input)
	local cands = {}
	for cand in input:iter() do
		if (contains_emoji(cand.text)) then
			if (utf8.len(input) == 1) then
				goto continue
			else
				table.insert(cands, cand)
			end
		else
			yield(cand)
		end
		::continue::
	end
	
	for _, cand in ipairs(cands) do
		yield(cand)
	end
end


return filter
