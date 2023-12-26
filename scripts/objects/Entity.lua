require "libs/class"
require "globals"

namespace "EntityState" {
    stand = 1, move = 2
}

namespace "EntityOrigin" {
    D = 1, DL = 2, DR = 3, L = 4, R = 5, T = 6, TL = 7, TR = 8
}

class "Entity" {
--private:
    sprite_size = nil;
    state = EntityState.stand;
    origin = EntityOrigin.D;
    animations = nil;
    pos = nil;

    name = "";
    speed = 1.2;
    health = 100;

    update_anim = function(self)
        if self.animations[self.state] == nil then return end
        if self.animations[self.state][self.origin] == nil then return end
        self.animations[self.state][self.origin]:update()
    end;

--public:
    constructor = function(self, name, x, y, animations)
        self.name = name
        self.pos = Vector2:new(x, y)
        self.animations = animations
        self.sprite_size = animations[EntityState.stand][EntityOrigin.D]:get_size()
    end;

    get_portrait = function(self)
        if self.animations[self.state] == nil then return end
        if self.animations[self.state][self.origin] == nil then return end

        return self.animations[EntityState.stand][EntityOrigin.D]:copy()
    end;

    get_health = function(self)
        return self.health
    end;

    set_health = function(self, value)
        self.health = math.max(math.min(value, 0), 100)
    end;

    get_pos = function(self)
        return self.pos
    end;

    set_pos = function(self, x, y)
        self.pos = Vector2:new(x, y)
    end;

    get_name = function(self)
        return self.name
    end;

    set_name = function(self, name)
        self.name = name
    end;

    draw = function(self)
        if self.animations[self.state] == nil then return end
        if self.animations[self.state][self.origin] == nil then return end

        local offset = (self.origin == EntityOrigin.left and 128 or 0)
        self.animations[self.state][self.origin]:draw(self.pos.x + offset - self.sprite_size.x / 2, self.pos.y - self.sprite_size.y / 2)

        render.text(
            self.pos.x - render.measure_text(fonts.text, self.name).x / 3,
            self.pos.y - self.sprite_size.y / 2 - 25,
            fonts.text,
            self.name,
            colors.gray
        )
    end;

    update = function(self)
        self:update_anim()
    end;
}