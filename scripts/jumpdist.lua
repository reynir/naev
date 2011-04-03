include("scripts/queue.lua")

--[[
-- @brief Fetches an array of systems from min to max jumps away from the given
--       system sys.
--
-- A following example to get closest system with shipyard (to max of 10):
--
-- @code
-- target = system.get( "Alteris" ) -- We'll target alteris in the example
-- local i, t
-- while i < 10 do
--    t = getsysatdistance( target, i, i,
--          function(s)
--             for _,p in ipairs(s:planets()) do
--                if p:hasShipyard()
--                   return true
--                end
--             end
--             return false
--          end )
--    i = i+1
-- end
-- local target_system = t[ rnd.rnd(1,#t) ]
-- @endcode
--
--    @param sys System to calculate distance from or nil to use current system
--    @param min Min distance to check for.
--    @param max Maximum distance to check for.
--    @param filter Optional filter function to use for more details.
--    @param data Data to pass to filter
--    @return The table of systems n jumps away from sys
--]]
function getsysatdistance( sys, min, max, filter, data )
    -- Get default parameters
    if sys == nil then
        sys = system.cur()
    end
    if max == nil then
        max = min
    end

    local res = {}
    local pending = 1
    local visited = 2
    
    local d = {}
    d[sys:name()] = 0
    local sysstate = {}
    sysstate[sys:name()] = pending
    local q = Queue.new()
    q:enqueue(sys)
    
    while not q:isEmpty() do
        local cur = q:dequeue()

        for _, i in pairs( cur:adjacentSystems() ) do
            if sysstate[i:name()] == nil then
                q:enqueue(i)
                d[i:name()] = d[cur:name()] + 1
                sysstate[i:name()] = pending
            end
        end
        if d[cur] ~= nil and d[cur] >= min and d[cur] <= max 
                and not filter(sys, data) then
            res[#res+1] = cur
        end
        sysstate[cur:name()] = visited
    end

    return res
end
