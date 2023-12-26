require "libs/class"

class "MapObject" {
--private:
    sprite = nil;
    name = "";
    pos = nil;

--public:
    constructor = function(self, sprite_name, x, y)
        self.sprite = assets.map_objects[sprite_name]
        self.name = sprite_name
        self.pos = Vector2:new(x, y)
    end;

    get_sprite_name = function(self)
        return self.name
    end;

    update = function(self)
        
    end;

    draw = function(self, offset)
        if offset == nil then
            offset = Vector2:new(0, 0)
        end

        self.sprite:set_pos(self.pos.x + offset.x, self.pos.y + offset.y)
        render.sprite(self.sprite)
    end;
}