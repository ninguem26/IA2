math.randomseed(os.time())

function sort(population, adaptability)
    for i = 1, 10 do
        for j = 1, 9 do
            if adaptability[j] > adaptability[j+1] then
                local aux = adaptability[j]
                adaptability[j] = adaptability[j+1]
                adaptability[j+1] = aux

                aux = population[j]
                population[j] = population[j+1]
                population[j+1] = aux
            end
        end
    end
end

function print_population(population, adaptability)
    for i, individual in ipairs(population) do
        local list = ""
        for _, gene in ipairs(individual) do
            list = list .. gene .. " "
        end
        print(list .. " " .. adaptability[i])
    end
end

function generate_population()
    local population = {}
    for i = 1, 10 do
        local individuals = {}
        for j = 1, 8 do
            local gene = math.random(2) - 1
            table.insert(individuals, gene)
        end
        table.insert(population, individuals)
    end

    return population
end

function adaptability(population)
    local adaptability = {}
    for i=1, 10 do
        local a = 0
        for j=1, 7 do
            if population[i][j] == 0 and population[i][j+1] == 1 then a = a + 1 end
        end

        table.insert(adaptability, a)
    end

    return adaptability
end

p = generate_population()
a = adaptability(p)
sort(p, a)
print_population(p, a)
