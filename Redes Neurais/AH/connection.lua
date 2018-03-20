local Connection = Object:extend()

function Connection:new(value, weight)
    self.value = value
    self.weight = weight or 1
end

return Connection
