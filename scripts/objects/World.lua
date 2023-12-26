require "libs/class"

class "World" {
--private:
    map = nil;
    entities = nil;
    structures = nil;

--public:
    constructor = function(self, map)
        self.map = map
        self.entities = {};
        self.structures = {};
    end;

    add_entity = function(self, entity)
        if self.entities[entity:get_name()] == nil then
            self.entities[entity:get_name()] = entity
        end
    end;

    remove_entity = function(self, entity)
        if self.entities[entity:get_name()] ~= nil then
            self.entities[entity:get_name()] = nil
        end
    end;

    update = function(self)
        local is_dialogue_open = false

        for _, entity in pairs(self.entities) do
            if entity:instanceof("NPC") then
                entity:update_dialogue()
                is_dialogue_open = entity:is_dialogue_open()

                local target = nil

                for _, player in pairs(self.entities) do
                    if player:instanceof("Player") then
                        target = player
                        break
                    end
                end

                if target ~= nil and keyboard.is_pressed(key.E) then
                    entity:try_open_dialogue(target)
                end 
            end
        end

        if not is_dialogue_open then
            for _, entity in pairs(self.entities) do
                entity:update()
            end
        end
    end;

    draw = function(self)
        for _, entity in pairs(self.entities) do
            entity:draw()
        end
    end;

    draw_dialogue = function(self)
        for _, entity in pairs(self.entities) do
            if entity:instanceof("NPC") then
                entity:draw_dialogue()
            end
        end
    end;
}