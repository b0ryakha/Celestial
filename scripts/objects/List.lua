require "libs/class"
require "objects/ListElement"

class "List" {
--private:
    elements = nil;
    pos = nil;
    row_len = 0;
    tile_size = nil;

--public:
    constructor = function(self, x, y, w, h, row_len, elements)
        if type(elements) ~= "table" then
            error("Invalid type, the variable 'elements' should have the type table.")
        end
    
        self.elements = {}
        self.pos = Vector2:new(x, y)
        self.row_len = row_len
        self.tile_size = Vector2:new(w, h)

        local row = {}
        for i = 1, #elements do
            if not elements[i]:instanceof("ListElement") then
                error("Invalid type, the variable 'elements' should have the type table<ListElement>.")
            end

            elements[i]:set_size(self.tile_size.x, self.tile_size.y)
            elements[i]:set_pos(
                self.pos.x + (i - 1) * (self.tile_size.x + 10) + elements[i]:get_measure_info().x,
                self.pos.y + #self.elements * (self.tile_size.y + 10)
            )
            
            row[#row + 1] = elements[i]

            if i % row_len == 0 then
                self.elements[#self.elements + 1] = row
                row = {}
            end
        end

        if next(row) ~= nil then
            self.elements[#self.elements + 1] = row
        end
    end;

    update = function(self)
        for _, row in pairs(self.elements) do
            for _, element in pairs(row) do
                element:update()
            end
        end

        
    end;

    draw = function(self)
        for _, row in pairs(self.elements) do
            for _, element in pairs(row) do
                element:draw()
            end
        end
    end;
}