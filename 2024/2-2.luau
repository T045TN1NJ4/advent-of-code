
--[[
  i took a bruteforce-based approach primarily because i'm too lazy to try to come up with anything else.
  i know a more performant alternative may be to do a better assessment of the levels in unsafe reports to determine if it's even recoverable, but again, i'm too lazy [to write that right now]
]]

local input = require(script.input)

local sum = 0

local function check(report: {number}): boolean
	
	local increasing: boolean
	
	for i, level in report do
		
		local next = report[i+1]
		if next == nil then
			break
		end
		
		local diff = math.abs(level - next) 
		if diff ~= math.clamp(diff, 1, 3) then -- also filters out no changes
			return false
		end
		
		local increases = level < next
		if i == 1 then
			increasing = increases
		elseif increases ~= increasing then
			return false
		end
		
	end
	
	return true
	
end




for line in input:gmatch("([^\n]+)") do
	
	local report = {}
	for level in line:gmatch("%S+") do
		table.insert(report, tonumber(level))
	end
	
	if check(report) == true then
		sum += 1
	else
		
		for i=1, #report do
			
			local report_copy = table.clone(report)
			table.remove(report_copy, i)
			
			if check(report_copy) == true then
				sum += 1
				break
			end
			
		end
		
	end
	
end

print(sum)
