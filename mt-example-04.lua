#!/usr/bin/env lua
local MT_EXAMPLE_04 = {}
--- Ok so here's an example of how we could implement a read only table. We
--- can utilize these metamethods __pairs, __ipairs.
---
--- A couple issues I don't like about this are ...
--- - These metamethods __pairs, __ipairs are not available in luajit
--- - Nothing is stopping someone from accessing mt to get access to t
--- - We could probably clean this up a bit
---
--- At what point do we say enough is enough though? I think I'm right to 
--- express tension in going to extreme lengths. Afterall, Lua is meant to be
--- simple and adding layered protection negates that to some extent.
---
--- However, a part of me feels adding some protection is not unreasonable 
--- especially if what i'm building is a plugin or API. At the very least it
--- serves as a defensive programming measure in development. I am human after
--- all. Maybe explore a solution that would lock this down in next example.
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
function MT_EXAMPLE_04.readOnly(t)
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
local days = MT_EXAMPLE_04.readOnly({ "monday", "tuesday", "friday" })
for k, v in pairs(days) do
    print(k, v)
end
--minidoc_afterlines_end
