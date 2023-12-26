require "libs/class"
require "globals"
require "objects/Message"
require "objects/TextButton"
require "objects/AnimSprite"

namespace "MessageType" {
    default = "DEFAULT:" .. tostring(cmath.rand_int(11111, 99999)),
    final = "FINAL:" .. tostring(cmath.rand_int(11111, 99999))
}

class "Dialogue" {
--private:
    messages = nil;
    current = 1;
    is_open_f = false;
    old_answer = "";
    buttons = nil;
    ticks = 0;

    anim_index = 1;
    person_name = "";
    portrait = nil;

--public:
    constructor = function(self, ...)
        local args = { ... }

        self.buttons = {
            leave = TextButton(fonts.ru_text, "leave", colors.white, 1920 / 2 - render.measure_text(fonts.ru_text, "leave").x - 70, 1080 - 50, function()
                self:close()
            end, true),

            back = TextButton(fonts.ru_text, "back", colors.white, 1920 / 2 + 70, 1080 - 50, function()
                if self.current > 1 then
                    self.current = self.current - 1
                    self.anim_index = 1
                end
            end, true)
        }

        for _, button in pairs(self.buttons) do
            local text_size = render.measure_text(fonts.ru_text, button:get_text())
            button:set_bound(button:get_pos().x - 90 + text_size.x / 2, button:get_pos().y - 25 + text_size.y / 2, 180, 50)
        end

        self.messages = {}
        local max_symbols = math.floor((1920 - 200) / (fonts.ru_text:get_size() / 1.2))

        for i = 1, #args do
            local req_answer = nil
            local mes_type = nil

            if #args[i] >= 2 and args[i][#args[i]]:instanceof("Message") then
                mes_type = #args == 2 and MessageType.default or args[i][1]
                req_answer = args[i][#args[i] - 1]
                args[i] = args[i][#args[i]]
            end

            if not args[i]:instanceof("Message") then
                error("Dialogue(): Expected object type 'Message'.")
            end

            local text = args[i]:get_text()

            local j, sliced = 1, ""
            for ch in text:gmatch"." do
                sliced = sliced .. ch

                if j % max_symbols == 0 then
                    sliced = sliced .. "\n"
                end

                j = (ch == "\n") and 1 or j + 1
            end

            local mes_buttons = {}
            local answers = args[i]:get_answers()

            for k = 1, #answers do
                local text_size = render.measure_text(fonts.ru_text, answers[k])

                mes_buttons[k] = TextButton(fonts.ru_text, answers[k], colors.white, 1920 / 2 - text_size.x / 2, 725 + (k - 1) * 65, function()
                    self.old_answer = answers[k]
                end, true)

                mes_buttons[k]:set_bound(mes_buttons[k]:get_pos().x - 200 + text_size.x / 2, mes_buttons[k]:get_pos().y - 25 + text_size.y / 2, 400, 50)
            end

            self.messages[i] = { type = mes_type, text = sliced, buttons = mes_buttons, req_answer = req_answer }
        end
    end;
    
    connect_self = function(self, entity)
        self.portrait = entity:get_portrait()
        self.portrait:set_scale(10, 10)
        self.portrait:set_pos(1920 / 2 - self.portrait:get_size().x / 1.5, 1080 / 2 - self.portrait:get_size().y / 1.5 - 300)

        self.person_name = entity:get_name()

        local max_symbols = math.floor(((1920 - 200) / 2) / (fonts.ru_text:get_size() / 1.2))

        if render.measure_text(fonts.ru_text, self.person_name).x > (1920 - 200) / 2 then
            self.person_name = self.person_name:sub(1, max_symbols - 1) .. "..."
        end
    end;

    open = function(self)
        if self.is_open_f then return end

        self.current = 1
        self.is_open_f = true
        self.anim_index = 1
    end;

    is_open = function(self)
        return self.is_open_f
    end;

    close = function(self)
        if not self.is_open_f then return end

        self.is_open_f = false
        self.old_answer = ""
    end;

    draw = function(self)
        if not self.is_open_f then return end

        render.rectangle(0, 0, 1920, 1080, colors.darkening)
        self.portrait:draw()

        render.rectangle(100, 1080 - 400 - 400, (1920 - 200) / 2, 50, colors.darkening, 50)
        render.text(112, 1080 - 400 - 400 + 12, fonts.ru_text, self.person_name, colors.accent)

        render.rectangle(100, 1080 - 340 - 400, 1920 - 200, 300, colors.darkening, 10)

        local text = self.messages[self.current].text
        render.text(112, 1080 - 340 - 400 + 12, fonts.ru_text, text:sub(1, self.anim_index), colors.white)

        if self.ticks > 3 then
            if self.anim_index < #text then
                self.anim_index = self.anim_index + 1
                sounds.printing:play(true)
            end

            self.ticks = 0
        end

        render.rectangle(100, 1080 - 320 - 100, 1920 - 200, 10, colors.accent, 100)
        render.rectangle(100, 1080 - 90, 1920 - 200, 10, colors.accent, 100)

        for _, button in pairs(self.buttons) do
            local text_size = render.measure_text(fonts.ru_text, button:get_text())

            if button:get_state() == ClickableState.hover then
                render.rectangle(button:get_pos().x - 90 + text_size.x / 2 - 5, button:get_pos().y - 25 + text_size.y / 2 - 5, 190, 60, colors.accent, 50)
            end

            render.rectangle(button:get_pos().x - 90 + text_size.x / 2, button:get_pos().y - 25 + text_size.y / 2, 180, 50, colors.darkening, 50)

            button:draw()
        end

        if self.anim_index < #text then return end

        for _, button in pairs(self.messages[self.current].buttons) do
            local text_size = render.measure_text(fonts.ru_text, button:get_text())

            if button:get_state() == ClickableState.hover then
                render.rectangle(button:get_pos().x - 200 + text_size.x / 2 - 5, button:get_pos().y - 25 + text_size.y / 2 - 5, 410, 60, colors.accent, 50)
            end

            render.rectangle(button:get_pos().x - 200 + text_size.x / 2, button:get_pos().y - 25 + text_size.y / 2, 400, 50, colors.darkening, 50)
            
            button:draw()
        end
    end;

    update = function(self)
        if not self.is_open_f then return end

        self.ticks = self.ticks + 1

        self.portrait:update()

        for _, button in pairs(self.buttons) do
            button:update()
        end

        if mouse.is_pressed(button.Left) or keyboard.is_pressed(key.Enter) then
            self.anim_index = #self.messages[self.current].text
        end

        for _, button in pairs(self.messages[self.current].buttons) do
            button:update()
        end

        if self.old_answer ~= "" and not mouse.is_pressed(button.Left) then
            for i = 1, #self.messages do
                if self.messages[i].req_answer == self.old_answer then
                    self.old_answer = ""
                    self.current = i
                    self.anim_index = 1
                    break
                end
            end

            if self.old_answer ~= "" then
                if self.messages[self.current].type == MessageType.final then
                    self:close()
                end

                if self.current + 1 > #self.messages then
                    self:close()
                else
                    self.current = self.current + 1
                end

                self.old_answer = ""
            end
        end
    end;
}