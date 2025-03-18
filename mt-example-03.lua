#!/usr/bin/env luajit
local utils = require("utils.utils")

--- This is a good example to understand the lookup process that Lua carries 
--- out when a key is not found in a table.
---
--- Step (1)
--- We define a table that has no metatable and only one key/value pair. We can
--- confirm this right now by printing it so lets do that.
---
--- Step (2)
--- We create a function using colon notation. Lua automatically stores
--- the function in Dog when using this notation. In addition, colon notation
--- will pass self (e.g. Dog.new(Dog))
--- after the function to confirm this.
---
--- The function creates an empty table and assigns a metatable to it with the
--- metamethod __index. Notice we assign the value self to it. Because 'self' 
--- is Dog in this case any accesses on obj where key does not exist will go to
--- Dog to lookup the key.
---
--- Step (3)
--- Same thing happens here. We create another function using colon notation
--- and Lua, again, automatically stores the function in Dog. 'self' is also 
--- passed to speak().
---
--- Step (4)
--- An empty table is returned to mydog. It has absolutely nothing in it other
--- that being assigned a metatable w/ one behavior being __index = self
---
--- Step (5)
--- mydog does not have a speak() function in it but it does have a metatable.
--- When an access occurs on a key that does not exist Lua goes to the 
--- metatable and looks for the metamethod __index. __index is assigned the 
--- value of 'self'. I know, from earlier, that 'self' is Dog so Lua goes to
--- Dog and finds the function speak.
---
--- Ok, almost done. Now mydog.speak redirects to Dog.speak(mydog). Very
--- important that I understand even though speak is stored in Dog, the self
--- argument is actually mydog (since I'm using colon syntax here and mydog is
--- calling speak())
---
--- Now what happens in speak? Remember what I just said, that self is actually
--- mydog not Dog (e.g. Dog.speak(mydog)). The self inside the function is 
--- whatever object called the function. Inside speak we now run self.sound but
--- wait ... mydog.sound does not exist. So what happens. The same steps occur
--- earlier where Lua goes to the metatable metamethod __index for missing keys
--- and gets redirected to Dog. It finds that Dog has a sound and so "Woof!"
--- says the dog. :)
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
local Dog = { sound = "Woof!" }
utils.PT(Dog)
print(getmetatable(Dog) or "has no metatable")
function Dog:new()
    local obj = {}
    setmetatable(obj, { __index = self })
    return obj
end
utils.PT(Dog)
function Dog:speak()
    print(self.sound)
end
utils.PT(Dog)
local mydog = Dog:new()
mydog:speak()
--minidoc_afterlines_end
