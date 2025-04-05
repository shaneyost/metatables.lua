#!/usr/bin/env lua
local MT_EXAMPLE_06 = {}
--- The __tostring method here is sufficient for most use cases. There are
--- limitations to this implementation but I'm quite happy with this.
---
---@usage >lua
---     local days = read_only({ "mon", "tue", "wed" })
---     print(days)
---     local blob = read_only({ boo = "boo", bar = "bar", foo = "foo" })
---     print(blob)
--- <
---
--@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
function MT_EXAMPLE_06.read_only(t)
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
        __metatable = false,
    })
end
--minidoc_afterlines_end
