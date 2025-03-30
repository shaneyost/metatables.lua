#!/usr/bin/env lua

local function read_only(t)
    return setmetatable({},{
        __index = t,
        __newindex = function (_, k, v)
            local msg = string.format("Error (%s, %s), read onl table", k, v)
            error(msg, 2)
        end,
    })
end

local days = read_only({m="mon", t="tue", w="wed"})
print(days.m)
print(days.t)
print(days["w"])
