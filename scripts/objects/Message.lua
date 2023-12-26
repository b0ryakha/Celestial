require "libs/class"

class "Message" {
--private:
    answers = nil;
    text = "";

--public:
    constructor = function(self, text, answers)
        self.answers = answers
        self.text = text
    end;

    get_text = function(self)
        return self.text
    end;

    get_answers = function(self)
        return self.answers
    end;
}