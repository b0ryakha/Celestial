require "libs/class"
require "globals"

class "ListElement" {
--private:
    sprite = nil;
    size = nil;
    pos = nil;
    info = nil;

--public:
    constructor = function(self, sprite, info)
        self.sprite = sprite:copy()
        self.info = info
    end;

    get_measure_info = function(self)
        return (self.info and render.measure_text(fonts.text, self.info) or Vector2:new(0, 0))
    end;

    set_size = function(self, w, h)
        self.size = Vector2:new(w, h)
        self.sprite:set_size(w, h)
    end;

    set_pos = function(self, x, y)
        self.pos = Vector2:new(x, y)
        self.sprite:set_position(x, y)
    end;

    update = function(self)
        
    end;

    draw = function(self)
        render.rectangle(self.pos.x, self.pos.y, self.size.x, self.size.y, colors.gray)
        render.sprite(self.sprite)

        if self.info then
            render.text(self.pos.x + self.sprite:get_size().x + 5, self.pos.y, fonts.text, self.info, colors.gray)
        end
    end;
}