require "globals"
require "libs/class"
require "objects/Gif"
require "objects/IconButton"
require "objects/TextButton"
require "objects/List"
require "objects/ListElement"
require "inits/game"
require "inits/creator"

class "Menu" {
--private:
    background = nil;
    buttons = nil;
    last_active_button = "play";

    play_tab = nil;
    settings_tab = nil;

--public:
    constructor = function(self)
        self.background = Gif(assets.menu_background);
        
        self.buttons = {
            play = IconButton(assets.play_button, 60, 60, colors.gray, colors.white, function()
                self.last_active_button = "play"
                self.buttons.settings:set_active(false);
                self.buttons.play_online:set_active(false);
                self.buttons.map_creator:set_active(false);
            end, true),

            play_online = IconButton(assets.play_online_button, 120, 60, colors.gray, colors.white, function()
                self.last_active_button = "play_online"
                self.buttons.settings:set_active(false);
                self.buttons.play:set_active(false);
                self.buttons.map_creator:set_active(false);
            end),

            map_creator = IconButton(assets.map_creator_button, 180, 60, colors.gray, colors.white, function()
                self.last_active_button = "map_creator"
                self.buttons.settings:set_active(false);
                self.buttons.play:set_active(false);
                self.buttons.play_online:set_active(false);
            end),

            settings = IconButton(assets.settings_button, 240, 60, colors.gray, colors.white, function()
                self.last_active_button = "settings"
                self.buttons.play:set_active(false);
                self.buttons.play_online:set_active(false);
                self.buttons.map_creator:set_active(false);
            end),

            exit = IconButton(assets.exit_button, 540, 60, colors.red, colors.white, function()
                window.sleep(500)
                window.close()
            end),
        }
        
        sounds.menu_music:play()

        self.play_tab = {}
        self.play_tab.start = TextButton(fonts.text, "LAUNCH", colors.gray, 460, 225, function()
            sounds.menu_music:stop()
            window.clear()
            window.display()
            game_init()
        end)
        --self.play_tab.maps = List(302, 250, 32, 32, 1, { ListElement(assets.star), ListElement(assets.star) })

        self.map_creator_tab = {}
        self.map_creator_tab.open = TextButton(fonts.text, "OPEN", colors.gray, 500, 225, function()
            sounds.menu_music:stop()
            window.clear()
            window.display()
            creator_init()
        end)
        
        self.settings_tab = {}
    end;

    update = function(self)
        self.background:update()

        local all_inactive = true
        for _, btn in pairs(self.buttons) do
            btn:update()
            all_inactive = all_inactive and not btn:is_active()
        end

        if all_inactive then
            self.buttons[self.last_active_button]:set_active(true)
        end

        if self.buttons.play:is_active() then
            for _, element in pairs(self.play_tab) do
                element:update()
            end
        end

        if self.buttons.map_creator:is_active() then
            for _, element in pairs(self.map_creator_tab) do
                element:update()
            end
        end

        --TODO: add settigns tab
    end;

    draw = function(self)
        self.background:draw()
        render.rectangle(0, 0, 1920, 1080, colors.darkening)

        render.rectangle(50, 50, 545, 60, colors.white)
        render.rectangle(50, 110, 545, 15, colors.accent)
        render.rectangle(50, 125, 545, 400, colors.transparent_white)

        render.text(930, 50, fonts.header, "CELESTIAL", colors.white)
        render.rectangle(930, 160, 680, 10, colors.accent, 100)
        render.circle(1270, 165, 20, colors.accent)
        render.sprite(assets.star)

        if self.buttons.play:is_active() then
            for _, element in pairs(self.play_tab) do
                element:draw()
            end

            render.rectangle(50, 50, 60, 60, colors.accent)
            render.text(55, 130, fonts.title, "SURVIVAL", colors.accent)

            render.text(55, 185, fonts.subtitle, "NEW GAME _________________________________", colors.gray)
            render.text(65, 225, fonts.text, "START A NEW GAME .............", colors.light_gray)

            render.text(55, 270, fonts.subtitle, "SAVED GAMES ________________________", colors.gray)
            render.text(65, 315, fonts.text, "       ............................... 25.09.23-13:00", colors.light_gray)
        end

        if self.buttons.play_online:is_active() then
            render.rectangle(110, 50, 60, 60, colors.accent)
            render.text(55, 130, fonts.title, "MULTIPLAYER", colors.accent)
        end

        if self.buttons.map_creator:is_active() then
            for _, element in pairs(self.map_creator_tab) do
                element:draw()
            end

            render.rectangle(170, 50, 60, 60, colors.accent)
            render.text(55, 130, fonts.title, "CREATOR", colors.accent)

            render.text(55, 185, fonts.subtitle, "CREATE MAP ____________________________", colors.gray)
            render.text(65, 225, fonts.text, "OPEN MAP REDACTOR .................", colors.light_gray)
        end

        if self.buttons.settings:is_active() then
            render.rectangle(230, 50, 60, 60, colors.accent)
            render.text(55, 130, fonts.title, "SETTINGS", colors.accent)

            render.text(55, 185, fonts.subtitle, "BINDS LIST __________________________________", colors.gray)

            local i = 0
            for bind, keys in pairs(binds) do
                local bind_name = string.upper(tostring(bind))
                local keys_name = ""

                for _, key_id in pairs(keys) do
                    local key_name = "NONE"
                    for name, id in pairs(key) do
                        if key_id == id then
                            key_name = tostring(name)
                            break
                        end
                    end

                    keys_name = keys_name .. key_name .. " | "
                end

                local text = bind_name .. ' '

                for _ = 1, 29 - #keys_name - #bind_name do
                    text = text .. '..'
                end

                text = text .. ' ' .. keys_name:sub(1, -4)

                render.text(65, 225 + i * 30, fonts.text, text, colors.light_gray)
                i = i + 1
            end
        end
        
        for _, btn in pairs(self.buttons) do
            btn:draw()
        end
    end;
}