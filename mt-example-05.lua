#!/usr/bin/env lua

--- We can use __metatable to prevent access to the mt. This, to some extent,
--- would lock it down. The debug library (if available) could bypass this.
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
local function readOnly(t)
    local proxy = {}
    setmetatable(proxy, {
        __index = t,
        __newindex = function()
            error("error read only")
        end,
        __metatable = false,
    })
    return proxy
end
local days = readOnly({ "mon", "tue", "wed" })
print(days[1])
print(days[2])
print(days[3])
days[1] = "foo"
--minidoc_afterlines_end
