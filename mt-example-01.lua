#!/usr/bin/env luajit
local utils = require("utils.utils")

--- Before I can describe, in my own words, what a metatable is I should first
--- understand the core significance of a Table in Lua. Only then can I move
--- confidently into the subject of metatables. 

--- A table in Lua is the only built-in complex data structure. It serves as
--- arrays, dictionaries, objects and even class-like structures. Unlike many
--- other languages that have distinct types, previously mentioned, Lua unifies
--- them under a single construct (a table).
---
---@usage >lua
---     -- array like
---     MtExample.mytable01 = { "1", "hi", "2" }
---     print(MtExample.mytable01[1])
---     print(MtExample.mytable01[2])
---     print(MtExample.mytable01[3])
---     -- dictionary like
---     MtExample.mytable02 = { y={color1="green", color2="red"}, x="foo" }
---     print(MtExample.mytable02["y"].color1)
---     print(MtExample.mytable02.y.color2)
---     print(MtExample.mytable02.x)
--- <

--- Tables allow Lua to be expressive but lightweight. They can grow and shrink
--- as needed. When assigning a table to a variable I'm assigning a reference 
--- "not a copy"
---
---@usage >lua
---     local a = { x = 10 }
---     local b = a
---     b.x = 20
---     print(a.x) -- 20 (b and a are references to same table)
--- <
---
--- After awhile I realized modules, environments (e.g. _G), metatables and so
--- much more are just tables. So, in a few more words, 'why' was this design
--- choosen?
---
--- Lua was designed to be simple, efficient and embeddable. Instead of having
--- multiple data structures, a single, well-designed construct (the table)
--- handles everything. This makes ...
---
--- - The language simpler (fewer constructs)
--- - The runtime faster (optimized for a single data structure)
--- - Memory usage more efficient (no need for separate containers per type)
---
--- Tables are the heart of Lua providing the building blocks needed for
--- advanced behavior while still remaining flexible, lightweight and powerful.
---
--- A 'very simple' example for me to think about before diving into the 
--- subject of metatables.
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
sometable = { "1", "2", "4" }
utils.PT(getmetatable(sometable) or {"no metatable found"})
setmetatable(sometable, {
    __index = function(table, key)
        print("Access on missing key '" .. key .. "'")
        return nil
    end,
})
utils.PT(getmetatable(sometable) or {"no metatable found"})

for i = 1, 5 do
    print(sometable[i])
end
--minidoc_afterlines_end
