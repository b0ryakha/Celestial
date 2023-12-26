require "globals"
require "objects/Player"
require "objects/NPC"
require "objects/World"
require "objects/Map"
require "objects/Dialogue"
require "objects/Message"
require "objects/GameMenu"
require "objects/Hud"

will_loaded = false
game_loop = function()
    local world = World(Map())
    local menu = GameMenu()
    local hud = Hud(1670, 960)

    local player = Player("Celly", 500, 600, {
        [EntityState.stand] = assets.players.raccoon.undressed.idle,
        [EntityState.move] = assets.players.raccoon.undressed.walk
    },
    {
        [EntityState.stand] = assets.players.raccoon.dressed.idle,
        [EntityState.move] = assets.players.raccoon.dressed.walk
    })

    local npc = NPC("Bot", 200, 400, {
        [EntityState.stand] = assets.players.raccoon.dressed.idle,
        [EntityState.move] = assets.players.raccoon.dressed.walk
    }, Dialogue(
        Message("Sometimes it seems that distance always plays against.\nEspecially when time is superimposed on it.\nThere is something absolutely right about giving another freedom. No tantrums.\nWithout torture like \"and where have you been? and who else was there?\"", { "Hi", "Good info..." }),
        Message("How are you?", { "хорошо", "bad", "test $%", "^button^" }),
        { "хорошо", Message("nice", { "thx" }) },
        { "bad", Message("oh so cringe...", { "f*** u" }) },
        { MessageType.final, "thx", Message("goodbye!", { "bye" }) },
        { MessageType.final, "f*** u", Message("bye mother fuc***r", { ":(" }) }
    ))

    world:add_entity(player)
    world:add_entity(npc)

    while menu:is_play() do
        menu:update()

        if not menu:is_open() then
            world:update()
            hud:update(player:get_health(), player:get_food(), player:get_water())
        end

        window.clear(colors.light_gray)
        world:draw()
        hud:draw()
        menu:draw()
        world:draw_dialogue()
        window.display()
    end

    will_loaded = true

    for _, music in pairs(sounds.game_music) do
        music:stop()
    end

    world:remove_entity(player)
    world:remove_entity(npc)

    start_menu()
end