require "libs/render_addon"
require "globals"
require "inits/map_objects"
require "game"

game_init = function()
    render.loading(0)

    if will_loaded then goto skip end

    assets.players = {
        raccoon = { dressed = {}, undressed = {} },
        fox = { dressed = {}, undressed = {} }
    }

    render.loading(5)

    assets.players.raccoon.dressed.idle = {
        [EntityOrigin.D] = AnimSprite("./../assets/players/raccoon/dressed/idle/D.png", 8, 32, 32, 128, 128, 30),
        [EntityOrigin.DL] = AnimSprite("./../assets/players/raccoon/dressed/idle/DL.png", 8, 32, 32, 128, 128, 30),
        [EntityOrigin.DR] = AnimSprite("./../assets/players/raccoon/dressed/idle/DR.png", 8, 32, 32, 128, 128, 30),
        [EntityOrigin.L] = AnimSprite("./../assets/players/raccoon/dressed/idle/L.png", 8, 32, 32, 128, 128, 30),
        [EntityOrigin.R] = AnimSprite("./../assets/players/raccoon/dressed/idle/R.png", 8, 32, 32, 128, 128, 30),
        [EntityOrigin.T] = AnimSprite("./../assets/players/raccoon/dressed/idle/T.png", 8, 32, 32, 128, 128, 30),
        [EntityOrigin.TL] = AnimSprite("./../assets/players/raccoon/dressed/idle/TL.png", 8, 32, 32, 128, 128, 30),
        [EntityOrigin.TR] = AnimSprite("./../assets/players/raccoon/dressed/idle/TR.png", 8, 32, 32, 128, 128, 30)
    }

    render.loading(20)

    assets.players.raccoon.dressed.walk = {
        [EntityOrigin.D] = AnimSprite("./../assets/players/raccoon/dressed/walk/D.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.DL] = AnimSprite("./../assets/players/raccoon/dressed/walk/DL.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.DR] = AnimSprite("./../assets/players/raccoon/dressed/walk/DR.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.L] = AnimSprite("./../assets/players/raccoon/dressed/walk/L.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.R] = AnimSprite("./../assets/players/raccoon/dressed/walk/R.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.T] = AnimSprite("./../assets/players/raccoon/dressed/walk/T.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.TL] = AnimSprite("./../assets/players/raccoon/dressed/walk/TL.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.TR] = AnimSprite("./../assets/players/raccoon/dressed/walk/TR.png", 6, 32, 32, 128, 128, 14)
    }

    render.loading(40)

    assets.players.raccoon.undressed.idle = {
        [EntityOrigin.D] = AnimSprite("./../assets/players/raccoon/undressed/idle/D.png", 8, 32, 32, 128, 128, 30),
        [EntityOrigin.DL] = AnimSprite("./../assets/players/raccoon/undressed/idle/DL.png", 14, 32, 32, 128, 128, 30),
        [EntityOrigin.DR] = AnimSprite("./../assets/players/raccoon/undressed/idle/DR.png", 14, 32, 32, 128, 128, 30),
        [EntityOrigin.L] = AnimSprite("./../assets/players/raccoon/undressed/idle/L.png", 14, 32, 32, 128, 128, 30),
        [EntityOrigin.R] = AnimSprite("./../assets/players/raccoon/undressed/idle/R.png", 14, 32, 32, 128, 128, 30),
        [EntityOrigin.T] = AnimSprite("./../assets/players/raccoon/undressed/idle/T.png", 14, 32, 32, 128, 128, 30),
        [EntityOrigin.TL] = AnimSprite("./../assets/players/raccoon/undressed/idle/TL.png", 14, 32, 32, 128, 128, 30),
        [EntityOrigin.TR] = AnimSprite("./../assets/players/raccoon/undressed/idle/TR.png", 14, 32, 32, 128, 128, 30)
    }

    render.loading(50)

    assets.players.raccoon.undressed.walk = {
        [EntityOrigin.D] = AnimSprite("./../assets/players/raccoon/undressed/walk/D.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.DL] = AnimSprite("./../assets/players/raccoon/undressed/walk/DL.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.DR] = AnimSprite("./../assets/players/raccoon/undressed/walk/DR.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.L] = AnimSprite("./../assets/players/raccoon/undressed/walk/L.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.R] = AnimSprite("./../assets/players/raccoon/undressed/walk/R.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.T] = AnimSprite("./../assets/players/raccoon/undressed/walk/T.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.TL] = AnimSprite("./../assets/players/raccoon/undressed/walk/TL.png", 6, 32, 32, 128, 128, 14),
        [EntityOrigin.TR] = AnimSprite("./../assets/players/raccoon/undressed/walk/TR.png", 6, 32, 32, 128, 128, 14)
    }

    render.loading(65)

    assets.map = {}
    assets.map.bg = nil

    sounds.steps = {}
    for i = 1, 3 do
        sounds.steps[i] = Sound:new("./../sounds/steps/" .. tostring(i) .. ".wav", 20)
    end

    sounds.game_music = {}
    for i = 1, 4 do
        sounds.game_music[i] = Sound:new("./../sounds/game music/" .. tostring(i) .. ".wav", 5, true)
    end

    sounds.printing = Sound:new("./../sounds/printing.wav", 20)

    colors.green = Color:new(110, 145, 50)
    colors.blue = Color:new(60, 110, 160)
    colors.orange = Color:new(145, 90, 50)
    colors.light_gray2 = Color:new(110, 110, 110)
    colors.gray2 = Color:new(35, 35, 35)

    assets.hud = {}
    assets.hud.hp = Sprite:new("./../assets/hud/health.png", 20, 20)
    assets.hud.wp = Sprite:new("./../assets/hud/water.png", 20, 20)
    assets.hud.fp = Sprite:new("./../assets/hud/food.png", 20, 20)

    render.loading(80)

    map_objects_init()

::skip::
    render.loading(100)

    sounds.game_music[cmath.rand_int(1, #sounds.game_music)]:play()
    game_loop()
end