require "objects/Menu"

start_menu = function()
    local menu = Menu()

    while true do
        menu:update()

        window.clear()
        menu:draw()
        window.display()
    end
end