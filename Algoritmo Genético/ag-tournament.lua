math.randomseed(os.time())

function sort(population, adaptability)
    for i = 1, #adaptability do
        for j = 1, #adaptability-1 do
            if adaptability[j] < adaptability[j+1] then
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
        print("Adapt " .. i .. ":")
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
    for i=1, #population do
        local a = 0
        for j=1, #population[i]-1 do
            if population[i][j] == 0 and population[i][j+1] == 1 then a = a + 1 end
        end

        table.insert(adaptability, a)
    end

    return adaptability
end

function cross(population, adaptability, descendents)
    for i=1, 25 do
        local r = math.random()
        if r >= 0.4 then
            local pivot = math.random(8)
            local ind_1, ind_2 = tournament(population, adaptability)
            local desc_1, desc_2 = generate_descendents(ind_1, ind_2, pivot)

            table.insert(descendents, desc_1)
            table.insert(descendents, desc_2)
        end
    end
end

-- Seleção por torneio
function tournament(population, adaptability)
    local r1 = 0
    local r2 = 0
    local r3 = 0

    local individuals = {}

    for i = 1, 2 do
        while r1 == r2 and (r1 == r3 or r2 == r3) do
            r1 = math.random(#population)
            r2 = math.random(#population)
        end

        if adaptability[r1] > adaptability[r2] then
            table.insert(individuals, population[r1])
            r3 = r1
        else
            table.insert(individuals, population[r2])
            r3 = r2
        end
    end

    return individuals[1], individuals[2]
end

function mutate(population, descendents)
    for i=1, 5 do
        local r = math.random()
        if r <= 0.4 then
            local desc = generate_mutated_descendents(population[i])
            table.insert(descendents, desc)
        end
    end
end

function generate_descendents(individual_1, individual_2, pivot)
    local descendent_1 = {}
    local descendent_2 = {}

    for i=1, pivot do
        table.insert(descendent_1, individual_1[i])
        table.insert(descendent_2, individual_2[i])
    end

    for i=pivot+1, 10 do
        table.insert(descendent_1, individual_2[i])
        table.insert(descendent_2, individual_1[i])
    end

    return descendent_1, descendent_2
end

function generate_mutated_descendents(individual)
    local descendent = {}

    for i, gene in ipairs(individual) do
        local r = math.random(2) - 1
        if r == 1 then
            if gene == 1 then table.insert(descendent, 0)
            else table.insert(descendent, 1) end
        else
            table.insert(descendent, gene)
        end
    end

    return descendent
end

function substitution(population, descendents)
    for i=1, 5 do
        population[#population-(i-1)] = descendents[i]
    end
end

function main()
    local population = generate_population()
    local p_adaptability = adaptability(population)
    sort(population, p_adaptability)
    local i = 0

    while p_adaptability[1] < 4 do
        i = i + 1
        local descendents = {}

        cross(population, p_adaptability, descendents)
        mutate(population, descendents)

        local d_adaptability = adaptability(descendents)
        sort(descendents, d_adaptability)

        substitution(population, descendents)
        p_adaptability = adaptability(population)
        sort(population, p_adaptability)
    end

    print_population(population, p_adaptability)
    print("\n" .. i .. " loops até o resultado")
end

main()
