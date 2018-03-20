local Neuron = Object:extend()

function Neuron:new(inputs, linear, threshold, greater_than)
    self.inputs = inputs
    self.output = Connection(0)
    self.greater_than = greater_than or false
    self.linear = linear
    self.threshold = threshold or 0
end

function Neuron:update(weight)
    local sum = 0

    for i,v in ipairs(self.inputs) do
        sum = sum + v.value * v.weight
    end

    if self.linear then
        self.output.value = sum
    elseif self.greater_than then
        if sum >= self.threshold then
            self.output.value = weight
        end
    else
        if sum <= self.threshold then
            self.output.value = weight
        end
    end
end

return Neuron
