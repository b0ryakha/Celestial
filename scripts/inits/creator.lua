require "globals"
require "libs/render_addon"
require "objects/MapCreator"
require "inits/map_objects"

local creator_loop = function()
    sounds.menu_music:play()

    local creator = MapCreator()

    while true do
        creator:update()

        window.clear(colors.white)
        creator:draw()
        window.display()
    end
end

creator_init = function()
    render.loading(0)

    assets.redactor = {}
    assets.redactor.cursor = {
        [CursorState.draw] = Sprite:new("./../assets/redactor/cursor.png", 20, 20, 0, 0, 20, 20),
        [CursorState.erase] = Sprite:new("./../assets/redactor/cursor.png", 20, 20, 20, 0, 20, 20),
        [CursorState.move] = Sprite:new("./../assets/redactor/cursor.png", 20, 20, 40, 0, 20, 20)
    }

    render.loading(40)

    map_objects_init()

    render.loading(100)

    creator_loop()
end