#!/usr/bin/env lua
local utils = require("utils.utils")

-- local _workdays = { "monday", "tuesday", "wednesday", "thursday" }
-- local workdays = setmetatable({}, {
--     __index = _workdays,
--     __newindex = function(t, k, v)
--         error("table read only")
--     end,
--     __metatable = false
-- })
-- table.insert(workdays, "friday")
-- utils.PT(workdays)


local function readOnly (t)
    local proxy = {}
    local mt = { -- create metatable
        __index = t,
        __newindex = function (t, k, v)
            error("attempt to update a read-only table", 2)
        end,
        __pairs = function() return pairs(t) end,
        __ipairs = function() return ipairs(t) end,
        __metatable = false
    }
    setmetatable(proxy, mt)
    return proxy
end
local days = readOnly({ "monday", "tuesday", "friday" })
for k, v in pairs(days) do print(k, v) end
