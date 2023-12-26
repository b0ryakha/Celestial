require "libs/class"
require "globals"

class "Hud" {
--private:
    pos = nil;
    hp = 0;
    fp = 0;
    wp = 0;
    hp_icon = nil;
    wp_icon = nil;
    fp_icon = nil;

--public:
    constructor = function(self, x, y)
        self.pos = Vector2:new(x, y)

        self.hp_icon = assets.hud.hp:copy()
        self.hp_icon:set_pos(x + 9, y + 5)
        self.hp_icon:set_color(colors.light_gray2)

        self.wp_icon = assets.hud.wp:copy()
        self.wp_icon:set_pos(x + 9, y + 40)
        self.wp_icon:set_color(colors.light_gray2)

        self.fp_icon = assets.hud.fp:copy()
        self.fp_icon:set_pos(x + 9, y + 75)
        self.fp_icon:set_color(colors.light_gray2)
    end;

    update = function(self, health, food, water)
        self.hp = health
        self.fp = food
        self.wp = water
    end;

    draw = function(self)
        render.rectangle(self.pos.x, self.pos.y, 235, 30, colors.gray2)
        render.rectangle(self.pos.x + 40, self.pos.y + 5, (190 / 100) * self.hp, 20, colors.green)
        render.sprite(self.hp_icon)

        render.rectangle(self.pos.x, self.pos.y + 35, 235, 30, colors.gray2)
        render.rectangle(self.pos.x + 40, self.pos.y + 40, (190 / 100) * self.wp, 20, colors.blue)
        render.sprite(self.wp_icon)

        render.rectangle(self.pos.x, self.pos.y + 70, 235, 30, colors.gray2)
        render.rectangle(self.pos.x + 40, self.pos.y + 75, (190 / 100) * self.fp, 20, colors.orange)
        render.sprite(self.fp_icon)
    end;
}