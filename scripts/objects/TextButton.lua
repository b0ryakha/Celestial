require "libs/class"
require "globals"
require "objects/IClickable"

class "TextButton" extends(IClickable) {
--private:
    text = "";
    font = nil;
    color = nil;
    hover_color = nil;
    current_color = nil;

--public:
    constructor = function(self, font, text, color, x, y, callback, hold_mode)
        self.text = text
        self.font = font
        self.color = color
        self.hover_color = Color:new(color.r - 30, color.g - 30, color.b - 30)
        self.current_color = color

        local size = render.measure_text(font, text)

        self:init(x, y, size.x, size.y, callback, hold_mode)
        self:set_sound(sounds.button_click)
    end;

    update = function(self)
        self:update_event()

        if self:get_state() == ClickableState.hover then
            self.current_color = self.hover_color
        else
            self.current_color = self.color
        end
    end;

    draw = function(self)
        render.text(self.pos.x, self.pos.y, self.font, self.text, self.current_color)
    end;

    get_text = function(self)
        return self.text
    end;
}