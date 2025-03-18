if not package.loaded["mini.doc"] then
    require("mini.doc").setup()
end
require("mini.doc").generate({
    "mt-example-01.lua",
    "mt-example-02.lua",
    "mt-example-03.lua",
})
