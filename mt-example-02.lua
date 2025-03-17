#!/usr/bin/env luajit
local utils = require("utils.utils")

--- Now that I can define a table lets try defining a metatable in my own words
--- to question my understanding.
---
--- > If I want to change the behavior of a table, I must define a set of rules
--- that govern how it behaves in specific situations. By default, tables do 
--- not have predefined behaviors for operations like addition or concat. The
--- construct that allows us to define these rules is called a metatable, and
--- the rules themselves are called metamethods.
---
--- I think this is a good first start. However, like everything else, it's 
--- helpful to understand the why first before diving into the how. So lets 
--- answer the question "Why did Lua's creators choose metatables?".
---
--- ** Reason (1) **
--- Unlike classes, Lua does not enforce inheritance or class hierarchies. 
--- Instead metatables allow developers to define behavior only when needed and
--- they can choose different styles of object models ...
--- 
--- - Prototype-based
--- - Class-like if desired
--- - Ad-hoc behaviors without strict structure
---
--- An example of a prototype-based appoach where we 
---
--- - Didn't define a strict "class"
--- - Chose to use prototype-based inheritance (e.g. `__index`)
---
--- @usage >lua
---     Dog = { sound = "Woof!" }
---     function Dog:new()
---         local obj = {}
---         setmetatable(obj, { __index = self })
---         return obj
---     end
---     function Dog:speak()
---         print(self.sound)
---     end
---     mydog = Dog:new()
---     mydog:speak()
--- <
--- ** Reason (2) **
--- Lua is designed to be lighweight(small runtime, low memory usage), fast (
--- simple VM, no extra OOP overhead), easy to embed (games, embedded, etc). 
--- Adding a full-fledged class system would negate that. 
---
--- Lua optimizes performance by keeping tables and metatables as the core 
--- abstraction thus objects are just tables, metatables can handle special
--- behaviors, and method lookup is opitimized (e.g. via `__index`).
---
--- ** Reason (3) **
--- Lua's philosophy is data-first where tables act as the universal data 
--- structure, and metatables extend their behavior dynamically. This differs
--- from class-based languages where data 'and' behavior are enforced together.
---
--- So in Lua we can say tables may be pure data or objects with behavior.
--- Metatables allow dynamic rule creation instead of predefining everything.
--- An example to illustrate pure data vs behavior-driven objects ...
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
-- Data-Only Table!
local spaceship = { name = "Falcon", speed = 500 }
-- Behavior-Enhanced Table (using metatables)
setmetatable(spaceship, {
    __index = function(tbl, key)
        if key == 'boost' then
            return function() tbl.speed = tbl.speed + 100 end
        end
    end,
})
spaceship.boost()
print(spaceship.speed)
--minidoc_afterlines_end

--- A quick table on why Lua uses Metatables instead of classes
---
--- | Aspect      | Metatables              | Class-Based OOP     |
--- | ----------- | ----------------------- | ------------------- |
--- | Flexibility | Any object model        | Strict inheritance  |
--- | Performance | Lightweight             | More memory         | 
--- | Data-Driven | data + dynamic behavior | predefined behavior |
