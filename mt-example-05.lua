#!/usr/bin/env lua

--- We can use __metatable to prevent access to the mt but is it really worth
--- it? At what point do we say enough is enough?
---
--- If all I'm implementing is a readonly table for myself then this might be
--- going a bit too far. Accidents can still happen though.
---
--- Personally I don't feel this is needed. I would have to call getmetatable
--- which I have no plans in doing. Then I would have to explicitly call the
--- __index and then index appropriately. That's alot of explicit intentions.
---
--- If I was writing a library or public facing API then this would be worth
--- it. Good to know though from a defensive programming point of view that I
--- could do __metatable = false.
---
--- It's also worth noting that with the debug library someone could still
--- override this making __metatable pointless.
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
