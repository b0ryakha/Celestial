require "globals"
require "libs/render_addon"

local is_fullscreen = true

init = function()
    window.set_title("Celestial")
    window.set_frame_limit(100)

    if is_fullscreen then
        window.set_size(1920, 1080)
        window.set_pos(-9, -38)
    end

    assets.loading_screen = Sprite:new("./../assets/render addon/loading_screen.png", 1920, 1080)
    colors.accent = Color:new(10, 160, 240)
    colors.darkening = Color:new(0, 0, 0, 180)

    sounds.loading_music = Sound:new("./../sounds/loading_music.wav", 10, true)

    render.loading(0)

    assets.window_icon = Sprite:new("./../assets/window/icon.png", 256, 256)
    window.set_icon(assets.window_icon)

    render.loading(25)

    assets.menu_background = {}
    for i = 0, 50 do
        assets.menu_background[i + 1] = Sprite:new("./../assets/menu background/" .. tostring(i) .. ".png", 1920, 1080)
    end

    render.loading(50)

    colors.white = Color:new(255, 255, 255)
    colors.gray = Color:new(90, 90, 90)
    colors.light_gray = Color:new(140, 140, 140)
    colors.red = Color:new(255, 20, 20)
    colors.transparent_white = Color:new(255, 255, 255, 200)

    render.loading(70)

    fonts.header = Font:new("./../fonts/SpeedyRegular.ttf", 110)
    fonts.title = Font:new("./../fonts/SpeedyRegular.ttf", 50)
    fonts.subtitle = Font:new("./../fonts/SpeedyRegular.ttf", 35)
    fonts.text = Font:new("./../fonts/SpeedyRegular.ttf", 25)
    fonts.ru_text = Font:new("./../fonts/Inter.ttf", 25, "b")

    assets.play_button = Sprite:new("./../assets/menu icons/offline.png", 55, 55)
    assets.play_online_button = Sprite:new("./../assets/menu icons/online.png", 55, 55)
    assets.exit_button = Sprite:new("./../assets/menu icons/exit.png", 55, 55)
    assets.map_creator_button = Sprite:new("./../assets/menu icons/map_creator.png", 55, 55)
    assets.settings_button = Sprite:new("./../assets/menu icons/settings.png", 55, 55)

    sounds.menu_music = Sound:new("./../sounds/menu_music.wav", 5, true)
    sounds.button_click = Sound:new("./../sounds/button_click.wav", 5)

    render.loading(80)

    assets.star = Sprite:new("./../assets/menu icons/star.png", 24, 24)
    assets.star:set_pos(1270 - 12, 165 - 12)

    binds.forward = { key.W }
    binds.backward = { key.S }
    binds.left = { key.A }
    binds.right = { key.D }
    binds.inventory = { key.Tab }
    binds.select = { button.Left, key.Enter }
    binds.attack = { button.Left, key.Enter }
    binds.jump = { key.Space }

    render.loading(100)
end