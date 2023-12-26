require "libs/class"
require "libs/xor"
require "globals"
require "objects/MapObject"

namespace "CursorState" {
    draw = 1, erase = 2, move = 3
}

class "MapCreator" {
--private:
    objects = nil;
    cursor = nil;
    lock_press0 = false; lock_press1 = false; lock_press2 = false; lock_press3 = false; lock_press4 = false;
    state = CursorState.draw;
    offset = nil;

--public:
    constructor = function(self)
        self.objects = {}
        self.cursor = assets.redactor.cursor;
        self.offset = Vector2:new(0, 0)
    end;

    save_to_file = function(self)
        window.clear()
        window.display()
        render.loading(0)

        local path = globalvars.get_executable_path() .. "/../saves/"
        local output = path .. "map"
        local KEY = "TYrbt62r5tB56opG6254GrtrtjjIORTY4HB5F4H65"

        while file.exists(output .. ".save") do
            local n = ""

            for ch in output:reverse():gmatch('.') do
                if ch:find("%D") then break end
                n = ch .. n
            end
            
            output = output:sub(1, #output - #n) .. tostring((tonumber(n) or 0) + 1)
        end

        render.loading(50)

        file.create(output .. ".save")

        local save = {}
        for pos, object in pairs(self.objects) do
            save[#save + 1] = xor(tostring(pos) .. " = \"" .. object:get_sprite_name() .. "\";", KEY)
        end

        file.write(output .. ".save", save, true)

        render.loading(100)
    end;

    update = function(self)
        for _, object in pairs(self.objects) do
            object:update()
        end

        if self.state == CursorState.draw then
            if mouse.is_pressed(button.Left) then
                local pos = cursor.get_pos()

                pos = Vector2:new(
                    math.floor(pos.x / 64) * 64,
                    math.floor(pos.y / 64) * 64
                ) - self.offset

                self.objects[pos] = MapObject("moon", pos.x, pos.y)
            end
        end

        if self.state == CursorState.erase then
            
        end

        if self.state == CursorState.move then
            
        end

        if keyboard.is_pressed(key.Space) then
            if not self.lock_press0 then
                self:save_to_file()
                self.lock_press0 = true
            end
        else
            self.lock_press0 = false
        end

        if keyboard.is_pressed(key.Left) then
            if not self.lock_press1 then
                self.offset.x = self.offset.x - 64
                self.lock_press1 = true
            end
        else
            self.lock_press1 = false
        end

        if keyboard.is_pressed(key.Right) then
            if not self.lock_press2 then
                self.offset.x = self.offset.x + 64
                self.lock_press2 = true
            end
        else
            self.lock_press2 = false
        end

        if keyboard.is_pressed(key.Up) then
            if not self.lock_press3 then
                self.offset.y = self.offset.y - 64
                self.lock_press3 = true
            end
        else
            self.lock_press3 = false
        end

        if keyboard.is_pressed(key.Down) then
            if not self.lock_press4 then
                self.offset.y = self.offset.y + 64
                self.lock_press4 = true
            end
        else
            self.lock_press4 = false
        end
    end;

    draw = function(self)
        for i = 0, 1080, 64 do
            for j = 0, 1920, 128 do
                render.rectangle(i % 128 == 0 and j + 64 or j, i, 64, 64, colors.light_gray)
            end
        end

        for _, object in pairs(self.objects) do
            object:draw(self.offset)
        end

        local pos = cursor.get_pos()

        self.cursor[self.state]:set_pos(pos.x - 10, pos.y - 10)
        render.sprite(self.cursor[self.state])
    end;
}