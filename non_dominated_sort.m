function [F,rank] = non_dominated_sort(popnum,f)
for i = 1:popnum
    person(i).n = 0;
    person(i).s = [];   
end
 
for i = 1:popnum
    for j = i+1 : popnum
        more = 0;
        less = 0;
        equal = 0;
        for k = 1:2
            if f(i,k) > f(j,k)
                more = more + 1;
            elseif f(i,k) < f(j,k)
                less = less + 1;
            else
                equal = equal + 1;
            end
        end
        if more ==  0 && equal ~= 2
            person(i).s = [person(i).s,j];
            person(j).n = person(j).n+1;
        elseif less == 0 && equal ~= 2
            person(j).s = [person(j).s,i];
            person(i).n = person(i).n+1;    
        end
    end
end
r = 1;
z(r).f = [];
rank = zeros(1,popnum);
for i = 1:popnum
    if person(i).n == 0
        z(r).f = [z(r).f,i];
        rank(i)= r;
    end
end

while(~isempty(z(r).f))
r = r + 1;
z(r).f = [];
b = z(r-1).f ;
for i = 1 : length(b)
    a = person(b(i)).s;
    for  j = 1:length(a) 
        person(a(j)).n = person(a(j)).n -1;
        if person(a(j)).n == 0
          z(r).f = [z(r).f,a(j)]; 
          rank(a(j))= r;
        end
    end
end
end
for i=1:r-1
   F(i).f=z(i).f;
end