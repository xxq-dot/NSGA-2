function parent = generate_offsprings(intermediate_chromosome,m,n,popnum)
max_rank = max(intermediate_chromosome(:,m + n + 1));
previous_index = 0;
for i = 1 : max_rank
    current_index = max(find(intermediate_chromosome(:,m + n+ 1) == i));
    if current_index > popnum
        remaining = popnum - previous_index;
        temp_pop = intermediate_chromosome(previous_index + 1 : current_index, :);
        [temp_sort,temp_sort_index] = sort(temp_pop(:, m + n + 2),'descend');
        for j = 1 : remaining
            parent(previous_index + j,:) = temp_pop(temp_sort_index(j),:);
        end
        return;
    elseif current_index < popnum
        parent(previous_index + 1 : current_index, :) = intermediate_chromosome(previous_index + 1 : current_index, :);
    else
        parent(previous_index + 1 : current_index, :) = intermediate_chromosome(previous_index + 1 : current_index, :);
        return;
    end
    previous_index = current_index;
end