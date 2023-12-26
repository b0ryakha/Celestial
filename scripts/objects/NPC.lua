require "libs/class"
require "objects/Entity"

class "NPC" extends(Entity) {
--private:
    dialogue = nil;
    use_distance = 150;

--public:
    constructor = function(self, name, x, y, animations, dialogue)
        self.name = name
        self.pos = Vector2:new(x, y)
        self.animations = animations
        self.sprite_size = animations[EntityState.stand][EntityOrigin.D]:get_size()
        self.dialogue = dialogue
        self.dialogue:connect_self(self)
    end;

    update = function(self)
        self:update_anim()
    end;

    update_dialogue = function(self)
        self.dialogue:update()
    end;

    draw_dialogue = function(self)
        self.dialogue:draw()
    end;

    is_dialogue_open = function(self)
        return self.dialogue:is_open()
    end;

    try_open_dialogue = function(self, target)
        local target_pos = target:get_pos()

        local x_div = (self.pos.x - target_pos.x) ^ 2
        local y_div = (self.pos.y - target_pos.y) ^ 2
        local distance = math.sqrt(x_div + y_div)

        if distance <= self.use_distance then
            self.dialogue:open()
        end
    end;
}