require "libs/class"

class "Gif" {
--private:
    tick = 0;
    frame = 1;
    sprites = nil;
    length = 0;

--public:
    constructor = function(self, sprites)
        self.sprites = sprites

        for k, v in pairs(sprites) do
            self.length = self.length + 1
        end
    end;

    draw = function(self)
        render.sprite(self.sprites[self.frame])
    end;

    update = function(self)
        self.tick = self.tick + 1

        if math.floor(self.tick) > 4 then
            self.tick = 0
            self.frame = self.frame + 1
        end

        if self.frame > self.length then
            self.frame = 1
        end
    end;
}