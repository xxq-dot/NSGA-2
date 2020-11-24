%拥挤距离的计算,矩阵行中前n个为变量值，第n+1：n+m个为函数值，第n+m+1个记录rank值，第n+m+2个记录拥挤距离
function nsdcpop=crowding_distance(pop,m,n,rank_info)
[xsize,ysize]=size(pop);
index=0;%存储每次rank等级开始个体所在位置
pop(:,m+n+2)=0;%用于存储cd值
for i=1:length(rank_info)
    for j=1:m
        [temp index_sort]=sort(pop(index+1:index+rank_info(i),n+j));%排序
        index_sort=index_sort+index;%记录排序的位置
       for k=1:rank_info(i)
           newpos=find(index_sort==index+k);%找到个体k排序后的位置，然后求取聚焦距离
           if (newpos==1 || newpos==rank_info(i))
                pop(index+k,m+n+2)=inf;
           else
               pre_person_index=index_sort(newpos+1);
               next_person_index=index_sort(newpos-1);
               pop(index+k,m+n+2)=pop(index+k,m+n+2)+(pop(pre_person_index,n+j)-pop(next_person_index,n+j));
           end
       end
    end
    index =index+rank_info(i);
end
nsdcpop=pop;
end
