require "globals"

local slider_width = 0
render.loading = function(fullness)
    if fullness == 0 then
        sounds.loading_music:play()
    end

    local new_width = math.floor((1484 / 100) * math.max(math.min(fullness, 100), 0))

    while slider_width < new_width do
        render.sprite(assets.loading_screen)
        render.rectangle(225, 831, slider_width, 90, colors.accent)
        window.display()

        slider_width = slider_width + 15
    end

    if fullness == 100 then
        slider_width = 0
        sounds.loading_music:stop()
        window.clear()
        window.display()
    end
end