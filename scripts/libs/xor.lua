local bit = require("bit")

local repeat_key = function(key, length)
    if #key >= length then
        return key:sub(1, length)
    end

    local times = math.floor(length / #key)
    local remain = length % #key

    local result = ""
    for _ = 1, times do
        result = result .. key
    end

    if remain > 0 then
        result = result .. key:sub(1, remain)
    end

    return result
end

xor = function(str, key)
    local rkey = repeat_key(key, #str)
    local result = ""

    for i = 1, #str do
        local k_char = rkey:sub(i, i)
        local m_char = str:sub(i, i)

        local k_byte = k_char:byte()
        local m_byte = m_char:byte()

        local xor_byte = bit.bxor(m_byte, k_byte)
        local xor_char = string.char(xor_byte)

        result = result .. xor_char
    end

    return result
end