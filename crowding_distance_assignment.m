function idistance = crowding_distance_assignment(popnum,F,f,m)
idistance = zeros(1,popnum);
% 得到种群有多少个等级
N = length(F);
for i = 1 : N
    F1 = F(i).f;
    ff = f(F1,:);
    distance = zeros(1,size(ff,1));
    % 对每列的函数值进行排序
    for j = 1 : m
          % [ff1,index] = sort(ff); 
          [ff1,index] = sort(ff(:,j)); 
        for k = 1 : length(index)
            kindex = find(index== k);
            % 边界个体的距离设置为无穷大
            if kindex==1 || kindex==length(index)
                distance(k) = Inf;
            else
                % 将每列的函数值进行相加
                distance(k) = distance(k) + ff1(kindex+1)-ff1(kindex-1);
            end
        end           
    end
    % 得到每个序号对应的拥挤距离
   idistance(F1) = distance;
end
