require "globals"

map_objects_init = function()
    local path = "./../assets/world/"
    assets.map_objects = {}

    assets.map_objects["box"] = Sprite:new(path .. "box.png", 64, 64)
    assets.map_objects["moon"] = Sprite:new(path .. "moon.png", 64, 64)
end