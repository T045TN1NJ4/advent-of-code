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
	end
	
end

print(sum)
