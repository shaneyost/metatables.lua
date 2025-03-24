#!/usr/bin/env lua
local utils = require("utils.utils")

local function readOnly(t)
	local proxy = {}
	setmetatable(proxy, {
        __index = t,
		-- __index = function(_, k)
		--           if k == "ipairs" then
		--               return function () return ipairs(t) end
		--           end
		--           if k == "pairs" then
		--               return function () return pairs(t) end
		--           end
		--           return t[k]
		--       end,
		__newindex = function(_, k, v)
			error("error read only", 2)
		end,
        __metatable = false
	})
	return proxy
end
local days = readOnly({ "mon", "tue", "wed" })

table.insert(days, "uh oh")
utils.PT(days)
