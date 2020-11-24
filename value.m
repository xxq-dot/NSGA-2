function  f = value(x,popnum,taot,nt,gen,D)
% function  f = value(x,popnum,taot,gen,D)
% for i = 1 :popnum
%     sum = 0;
%     for k = 2:10
%         sum = sum + (x(i,k) / 9);
%     end
%     f(i,1) = 1 -exp(-4 * x(i,1)) * sin(6 * pi * x(i,1))^6;
%     g = 1 + 9 *(sum)^0.25;
%     f(i,2) = g*(1-(f(i,1)/g)^2);


% 标准测试函数FDA1
% xmin = -1;
% xmax =1;
% for i = 1 : popnum
%     % floor向下取整
%     t = floor(gen/taot) * 1/nt;
%     G= sin(0.5 * pi * t);
%     sum = 0;
%     for j = 2 : D
%         x(i,j) = xmin + x(i,j) *(xmax-(xmin));
%         sum = sum + (x(i,j) - G)^2;      
%     end
%     g = 1 + sum;
%     f(i,1) = x(i,1); 
%     h = 1 - sqrt(f(i,1)/g);
%     f(i,2) = g * h;
% FDA2 mod函数
% xmin = -1;
% xmax = 1;
% for i = 1:popnum
%     t = 2 * floor(gen/taot)*(taot/(200-taot));
%     H = 2 * sin(0.5 * pi *(t-1));
%     f(i,1) = x(i,1);
%     sum1 = 0;
%     for j = 2 : 6
%         x(i,j) = xmin + x(i,j) *(xmax-(xmin));
%         sum1 = sum1 + x(i,j)^2;
%     end
%     g = 1 + sum1;
%     sum2 = 0;
%     sum3 = 0;
%     for k = 7 : 10
%         x(i,j) = xmin + x(i,j) *(xmax-(xmin));
%         sum2 = sum2 + (x(i,k)-H/4)^2;
%     end
%     sum3 = sum3 + H + sum2;
%     h = 1 - (f(i,1)/g)^(2*sum3);
%     f(i,2) = g * h;
% FDA3
xmin = -1;
xmax = 1;
for i = 1 : popnum 
    t = floor(gen/taot)* 1/nt;
    F = 10^(2 * sin(0.5 * pi * t));
    f(i,1) = x(i,1)^F;
    G = abs(sin(0.5 * pi * t));
    sum = 0;
    for j = 2 :D
        x(i,j) = xmin + x(i,j) *(xmax-(xmin));
        sum = sum + (x(i,j) - G)^2;
    end
    g = 1 + G + sum;
    h = 1 - sqrt(f(i,1)/g);
    f(i,2) = g * h;   
end

    
  

  
