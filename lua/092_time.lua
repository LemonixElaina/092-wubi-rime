--[[
@intro: 将 z 引导的编码转换为时间和日期
@author: Lemon1x
@version: v0.2_241213
--]]


local function getShortDate()
	-- 获取六位数的时间，如 241001
	local now = os.date("*t")
	local _year, month, day = now.year, now.month, now.day
	-- 截取最后两位
	local year = string.sub(tostring(_year), 3)

	-- 单位数需要开头补零，如 1 变为 01
	return string.format("%s%02d%02d", year, month, day)
end


local function getWorkday()
	-- 获取星期几
	local wday = os.date("*t").wday
	if wday == 1 then -- 星期日
		return "星期日"
	elseif wday == 2 then
		return "星期一"
	elseif wday == 3 then
		return "星期二"
	elseif wday == 4 then
		return "星期三"
	elseif wday == 5 then
		return "星期四"
	elseif wday == 6 then
		return "星期五"
	elseif wday == 7 then
		return "星期六"
	end
end


local function translator(input, seg)
	if input == "zjh" then
		-- 日期、星期
		yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "日期"))
		yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "日期"))
		yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "日期"))
		yield(Candidate("date", seg.start, seg._end, getWorkday(), "星期"))
	elseif input == "zcj" then
		-- 短日期、短时间
		yield(Candidate("date", seg.start, seg._end, getShortDate(), "短日期"))
		yield(Candidate("time", seg.start, seg._end, os.date("%H%M%S"), "短时间"))
	elseif input == "zju" then
		-- 时间
		yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "时间"))
		yield(Candidate("time", seg.start, seg._end, os.date("%H时%M分%S秒"), "时间"))
	elseif input == "zjun" then
		-- 时间戳
		yield(Candidate("timestamp", seg.start, seg._end, os.time(), "时间戳"))
	elseif input == "zgo" or input == "zlfo" then
		-- （已过）天数
		yield(Candidate("date", seg.start, seg._end, os.date("*t").yday, "已过天数"))
	end
end


return translator


