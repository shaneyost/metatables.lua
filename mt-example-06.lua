#!/usr/bin/env lua

--- Here's my final version that I feel happy about. I'm going to remove the
--- __metatable = false. I don't feel it's worth it as reasons discussed in
--- other file.
---
--- The __tostring method here is sufficient for most use cases. There are
--- limitations to this implementation but I'm quite happy with this.
local function read_only(t)
    return setmetatable({}, {
        __index = t,
        __newindex = function(_, k, v)
            error(string.format("Error (%s, %s), read only", k, v))
        end,
        __tostring = function()
            local output = {}
            for k, v in pairs(t) do
                table.insert(output, string.format("%s=%s", k, v))
            end
            return table.concat(output, ", ")
        end,
    })
end

local days = read_only({ "mon", "tue", "wed" })
print(days)

local blob = read_only({ boo = "boo", bar = "bar", foo = "foo" })
print(blob)
