require "libs/class"

namespace "ClickableState" {
    active = 1, inactive = 2, hover = 3
}

class "IClickable" {
--private:
    pos = nil;
    size = nil;
    bound = nil;
    click_sound = nil;
    state = ClickableState.inactive;
    callback = nil;
    callback_played = false;

    lock_press = false;
    active = false;
    is_init = false;
    is_hold_mode = false;

    check_valid = function(self)
        if not self.is_init then
            error("Using uninitialized memory, type 'IClickable'")
        end
    end;

--public:
    constructor = function(self)
        error("Use of deleted function 'IClickable::constructor()'")
    end;

    init = function(self, x, y, w, h, callback, hold_mode)
        self.pos = Vector2:new(x, y)
        self.size = Vector2:new(w, h)
        self.callback = callback
        self.is_init = true
        self.bound = { x = x, y = y, w = w, h = h }
        if hold_mode == true then self.is_hold_mode = true end
    end;

    update_event = function(self)
        if not cursor.in_window() then return end
        self:check_valid()

        if cursor.is_bound(self.bound.x, self.bound.y, self.bound.w, self.bound.h) then
            if not self.active then
                self.state = ClickableState.hover
            end

            if self.is_hold_mode then
                self.active = mouse.is_pressed(button.Left)
            else
                if mouse.is_pressed(button.Left) then
                    self.state = ClickableState.active
    
                    if not self.lock_press then
                        self.active = not self.active
                        self.lock_press = true
                    end
                else
                    self.lock_press = false
                end
            end
        else
            self.state = (self.active and ClickableState.active or ClickableState.inactive)
        end

        if self.active then
            if not self.callback_played then
                if type(self.click_sound) == "userdata" then
                    self.click_sound:play()
                end

                if type(self.callback) == "function" then
                    self.callback()
                end

                self.callback_played = true
            end
        else
            self.callback_played = false
        end
    end;

    set_active = function(self, state)
        self:check_valid()
        self.active = state
    end;

    set_sound = function(self, sound)
        self:check_valid()
        self.click_sound = sound
    end;

    set_bound = function(self, x, y, w, h)
        self.bound = { x = x, y = y, w = w, h = h }
    end;

    is_active = function(self)
        self:check_valid()
        return self.active
    end;

    get_state = function(self)
        self:check_valid()
        return self.state
    end;

    get_pos = function(self)
        return self.pos
    end;
}