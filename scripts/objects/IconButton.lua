require "libs/class"
require "globals"
require "objects/IClickable"

class "IconButton" extends(IClickable) {
--private:
    icon = nil;
    inactive_color = nil;
    active_color = nil;
    hover_color = nil;

--public:
    constructor = function(self, sprite, x, y, color1, color2, callback, active, hold_mode)
        self.icon = sprite:copy()
        self.icon:set_pos(x, y)

        self.inactive_color = color1
        self.active_color = color2
        self.hover_color = Color:new(color1.r - 30, color1.g - 30, color1.b - 30)
        
        local size = sprite:get_size()

        self:init(x, y, size.x, size.y, callback, hold_mode)
        self:set_sound(sounds.button_click)
        
        if active then
            self.active = true
            self.callback_played = true
        end
    end;

    update = function(self)
        self:update_event()
        
        switch (self:get_state()) {
            [ClickableState.active] = function()
                self.icon:set_color(self.active_color)
            end;

            [ClickableState.inactive] = function()
                self.icon:set_color(self.inactive_color)
            end;

            [ClickableState.hover] = function()
                self.icon:set_color(self.hover_color)
            end;
        }
    end;

    draw = function(self)
        render.sprite(self.icon)
    end;
}