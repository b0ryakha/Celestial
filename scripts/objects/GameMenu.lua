require "globals"
require "libs/class"
require "objects/IconButton"
require "objects/TextButton"

class "GameMenu" {
--private:
    open_flag = false;
    buuttons = nil;
    lock_press = false;
    last_active_button = "play";
    play_tab = nil;
    is_exit = false;

--public:
    constructor = function(self)
        self.buttons = {
            play = IconButton(assets.play_button, 60, 60, colors.gray, colors.white, function()
                self.last_active_button = "play"
            end, true),

            exit = IconButton(assets.exit_button, 480, 60, colors.red, colors.white, function()
                self.is_exit = true
            end),
        }

        self.play_tab = {}
        self.play_tab.save = TextButton(fonts.text, "SAVE", colors.gray, 440, 225, function()

        end)
    end;

    is_play = function(self)
        return not self.is_exit
    end;

    is_open = function(self)
        return self.open_flag
    end;

    update = function(self)
        if keyboard.is_pressed(key.Escape) then
            if not self.lock_press then
                self.open_flag = not self.open_flag
                self.lock_press = true
            end
        else
            self.lock_press = false
        end

        if not self.open_flag then return end

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
    end;

    draw = function(self)
        if not self.open_flag then return end

        render.rectangle(0, 0, 1920, 1080, colors.darkening)

        render.rectangle(50, 50, 485, 60, colors.white)
        render.rectangle(50, 110, 485, 15, colors.accent)
        render.rectangle(50, 125, 485, 200, colors.transparent_white)

        if self.buttons.play:is_active() then
            for _, element in pairs(self.play_tab) do
                element:draw()
            end

            render.rectangle(50, 50, 60, 60, colors.accent)
            render.text(55, 130, fonts.title, "SURVIVAL", colors.accent)

            render.text(55, 185, fonts.subtitle, "SAVED GAMES _________________", colors.gray)
            render.text(65, 225, fonts.text, "SAVE_1 ..............................................", colors.light_gray)
        end

        for _, btn in pairs(self.buttons) do
            btn:draw()
        end
    end;
}