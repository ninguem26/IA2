Object = require "classic"
Connection = require "connection"
Neuron = require "neuron"

matrix_a  = {{1,1,1}, {1,0,1}, {1,1,1}, {1,0,1}}
matrix_h1 = {{1,0,1}, {1,1,1}, {1,0,1}, {1,0,1}}
matrix_h2 = {{1,0,1}, {1,0,1}, {1,1,1}, {1,0,1}}

matrix = matrix_a

function main()
    local inputs_a1 = {Connection(matrix[1][1]), Connection(matrix[1][2]), Connection(matrix[1][3]),
                       Connection(matrix[2][1]), Connection(matrix[2][3]), Connection(matrix[3][1]),
                       Connection(matrix[3][2]), Connection(matrix[3][3]), Connection(matrix[4][1]),
                       Connection(matrix[4][3])}

    local a1 = Neuron(inputs_a1, _, 10, true)
    a1:update(1)

    local inputs_a2 = {Connection(matrix[2][2]), Connection(matrix[4][2])}

    local a2 = Neuron(inputs_a2, _, 0, false)
    a2:update(1)

    local inputs_a = {a1.output, a2.output}

    local a = Neuron(inputs_a, _, 2, true)
    a:update(1)

    local inputs_h1u = {Connection(matrix[1][1]), Connection(matrix[1][3]), Connection(matrix[2][1]),
                        Connection(matrix[2][2]), Connection(matrix[2][3]), Connection(matrix[3][1]),
                        Connection(matrix[3][3]), Connection(matrix[4][1]), Connection(matrix[4][3])}

    local h1u = Neuron(inputs_h1u, _, 9, true)
    h1u:update(1)

    local inputs_h2u = {Connection(matrix[1][2]), Connection(matrix[3][2]), Connection(matrix[4][2])}

    local h2u = Neuron(inputs_h2u, _, 0, false)
    h2u:update(1)

    local inputs_h3u = {h1u.output, h2u.output}

    local h3u = Neuron(inputs_h3u, _, 2, true)
    h3u:update(1)

    local inputs_h1d = {Connection(matrix[1][1]), Connection(matrix[1][3]), Connection(matrix[2][1]),
                        Connection(matrix[2][3]), Connection(matrix[3][1]), Connection(matrix[3][2]),
                        Connection(matrix[3][3]), Connection(matrix[4][1]), Connection(matrix[4][3])}

    local h1d = Neuron(inputs_h1d, _, 9, true)
    h1d:update(1)

    local inputs_h2d = {Connection(matrix[1][2]), Connection(matrix[2][2]), Connection(matrix[4][2])}

    local h2d = Neuron(inputs_h2d, _, 0, false)
    h2d:update(1)

    local inputs_h3d = {h1d.output, h2d.output}

    local h3d = Neuron(inputs_h3d, _, 2, true)
    h3d:update(1)

    local inputs_h = {h3u.output, h3d.output}

    local h = Neuron(inputs_h, _, 1, true)
    h:update(2)

    local inputs_letter = {a.output, h.output}

    local letter = Neuron(inputs_letter, true)
    letter:update()

    if letter.output.value == 1 then
        print("Letra: A")
    elseif letter.output.value == 2 then
        print("Letra: H")
    else
        print("Letra desconhecida")
    end
end

main()
