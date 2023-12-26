require "libs/class"

class "AnimSprite" {
--private:
    sprites = nil;
    ticks = 0;
    frame = 1;
    time = 0;

--public:
    constructor = function(self, image_path, frame_count, t_w, t_h, w, h, time)
        self.sprites = {}
        self.time = time

        if image_path ~= "" then
            for i = 0, frame_count - 1 do
                if file.exists(image_path) then
                    self.sprites[#self.sprites + 1] = Sprite:new(image_path, w, h, i * t_w, 0, t_w, t_h)
                else
                    self.sprites[#self.sprites + 1] = Sprite:new("./../assets/error.png", w, h)
                end
            end
        end
    end;

    update = function(self)
        self.ticks = self.ticks + 1

        if self.ticks > self.time then
            self.frame = self.frame + 1
            self.ticks = 0
            
            if self.frame > #self.sprites then
                self.frame = 1
            end
        end
    end;

    get_size = function(self)
        return self.sprites[1]:get_size()
    end;

    copy = function(self)
        local copy = AnimSprite("", 1, 0, 0, 0, 0, self.time)
        local copy_sprites = {}

        for i = 1, #self.sprites do
            copy_sprites[i] = self.sprites[i]:copy()
        end

        copy.sprites = copy_sprites

        return copy
    end;

    get_scale = function(self)
        return self.sprites[1]:get_scale()
    end;

    set_scale = function(self, x_factor, y_factor)
        for _, sprite in pairs(self.sprites) do
            sprite:set_scale(x_factor, y_factor)
        end
    end;

    get_pos = function(self)
        return self.sprites[1]:get_pos()
    end;

    set_pos = function(self, x, y)
        for _, sprite in pairs(self.sprites) do
            sprite:set_pos(x, y)
        end
    end;

    draw = function(self, x, y)
        if x and y then
            self.sprites[self.frame]:set_pos(x, y)
        end

        render.sprite(self.sprites[self.frame])
    end;
}