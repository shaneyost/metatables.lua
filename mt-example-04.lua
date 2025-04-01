#!/usr/bin/env lua

--- Ok so here's an example of how we could implement a read only table. We
--- can utilize these metamethods __pairs, __ipairs.
---
--- A couple issues I don't like about this are ...
--- - These metamethods __pairs, __ipairs are not available in luajit
--- - Nothing is stopping someone from accessing mt to get access to t
--- - We could probably clean this up a bit
--- At what point do we say enough is enough though?
local function readOnly(t)
    local proxy = {}
    local mt = {
        __index = t,
        __newindex = function(t, k, v)
            error("attempt to update a read-only table", 2)
        end,
        __pairs = function()
            return pairs(t)
        end,
        __ipairs = function()
            return ipairs(t)
        end,
    }
    setmetatable(proxy, mt)
    return proxy
end
local days = readOnly({ "monday", "tuesday", "friday" })
for k, v in pairs(days) do
    print(k, v)
end
