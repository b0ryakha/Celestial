require "libs/class"
require "objects/Entity"

class "Player" extends(Entity) {
--private:
    food = 30;
    water = 50;
    ticks = 0;
    is_dressed = false;

--public:
    constructor = function(self, name, x, y, undressed, dressed)
        self.name = name
        self.pos = Vector2:new(x, y)
        self.undressed_animations = undressed
        self.dressed_animations = dressed
        self.sprite_size = undressed[EntityState.stand][EntityOrigin.D]:get_size()
    end;

    get_food = function(self)
        return self.food
    end;

    set_food = function(self, value)
        self.food = math.max(math.min(value, 0), 100)
    end;

    get_water = function(self)
        return self.water
    end;

    set_water = function(self, value)
        self.water = math.max(math.min(value, 0), 100)
    end;

    update = function(self)
        self.animations = self.is_dressed and self.dressed_animations or self.undressed_animations
        self:update_anim()

        self.ticks = self.ticks + 1

        local old_key = nil
        local speed = self.speed

        if keyboard.is_pressed(key.LShift) then
            speed = self.speed + 0.8
        end

        self.state = EntityState.stand

        if keyboard.is_pressed(key.W) then
            self.origin = EntityOrigin.T
            self.pos.y = self.pos.y - speed
            old_key = key.W
        end

        if keyboard.is_pressed(key.A) then
            if old_key == key.W then
                self.origin = EntityOrigin.TL
            else
                self.origin = EntityOrigin.L
            end

            self.pos.x = self.pos.x - speed
            old_key = key.A
        end

        if keyboard.is_pressed(key.S) then
            if old_key == key.A then
                self.origin = EntityOrigin.DL
            else
                self.origin = EntityOrigin.D
            end

            self.pos.y = self.pos.y + speed
            old_key = key.S
        end

        if keyboard.is_pressed(key.D) then
            if old_key == key.W then
                self.origin = EntityOrigin.TR
            elseif old_key == key.S then
                self.origin = EntityOrigin.DR
            else
                self.origin = EntityOrigin.R
            end

            self.pos.x = self.pos.x + speed
            old_key = key.D
        end

        if old_key ~= nil then
            self.state = EntityState.move

            if self.ticks > 30 - math.floor(speed) * 3 then
                self.ticks = 0
                sounds.steps[cmath.rand_int(1, #sounds.steps)]:play(true)
            end
        end
    end;
}