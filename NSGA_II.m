% 初始化种群
clear all;
clc
popnum = 100;
m = 2; %函数值个数
D = 10; %x的列数
xmin = 0;
xmax = 1;

% FDA1 的参数设置
% pc = 0.5; %模拟二进制交叉概率
% hc = 10; %交叉分布指数
% pm = 0.1; %多项式变异概率
% hm = 20; %变异分布指数
% taot = 30;% 时间t保持固定时的迭代次数
% nt = 10; %环境变化强度

% % FDA2的参数设置
% pc = 0.6; %模拟二进制交叉概率
% hc = 10; %交叉分布指数
% pm = 0.1; %多项式变异概率
% hm = 20; %变异分布指数
% taot = 20;% 时间t保持固定时的迭代次数

% FDA3 的参数设置
pc = 0.5; %模拟二进制交叉概率
hc = 10; %交叉分布指数
pm = 0.1; %多项式变异概率
hm = 20; %变异分布指数
taot = 50;% 时间t保持固定时的迭代次数
nt = 10; %环境变化强度
gen = 1;
for i = 1:popnum
    for j = 1 : D 
        pop(i,j) = xmin + rand * (xmax-xmin);
    end
end
f = value(pop,length(pop),taot,nt,gen,D);
% FDA2的函数值
%f = value(pop,length(pop),taot,gen,D);
pop=[pop,f];
[non_dominant_sortpop, rankinfo]=non_dominant_sort(pop,m,D);
nsdcpop=crowding_distance(non_dominant_sortpop,m,D,rankinfo);
parent=generate_offsprings(nsdcpop,m,D,popnum);
figure(1)
plot(parent(:,D+1),parent(:,D+m),'B+')
% FDA1迭代次数
% iter = 300;
% FDA2迭代次数
% iter = 200;
% FDA3迭代次数
iter = 200;
for gen = 1 : iter
    gen
    offspring=genetic_operate(parent,m,D,hc,hm,xmax,xmin);
    pop = [parent(:,1:D);offspring(:,1:D)];
    f = value(pop,length(pop),taot,nt,gen,D);
    % FDA2的函数值
    % f = value(pop,length(pop),taot,gen,D);
    pop=[pop,f];
    [non_dominant_sortpop, rankinfo]=non_dominant_sort(pop,m,D);
    nsdcpop=crowding_distance(non_dominant_sortpop,m,D,rankinfo);
    parent=generate_offsprings(nsdcpop,m,D,popnum);
    % % 环境检测因子
    % 随机选出100个数
    k = randperm(popnum);
    % 检测环境变化从种群中挑选的个体数
    N = popnum * 0.1;
    % 随机挑选的10个个体
    E = parent((1:D),:);
    % 检测环境是否发生变化的阈值
    n = 0.00001;
    % 新选出的个体的函数值
    newf = value(E(:,1:10),N,taot,nt,gen+1,D);
    % FDA2的函数值
    % newf = value(E(:,1:10),N,taot,gen+1,D);
    % 旧个体的函数值
    oldf = E(:,D+1:D+2);
    % 环境检测算子
    sum=0;
    for i = 1 : N
        avgf(i) = 1/N * abs((oldf(i,1) - newf(i,1))+ (oldf(i,2) - newf(i,2)));
        sum = sum + avgf(i);
    end
    dete = sum;
    if dete > n
        figure(2)
        plot(parent(:,D+1),parent(:,D+m),'r.') ;
        pause(0.1)
        hold on
        disp('环境发生了变化');
        % 部分多样性的引入方式
        % NSGA-2-A 环境预测模型
        % 响应环境变化时随机产生的用来代替当前种群的个体数newnum
        % FDA1的newnum
        %newnum = popnum * 0.2;
        % FDA2的newnum
        %newnum = popnum * 0.35;
        % FDA3的newnum
%         newnum = popnum * 0.3;
%         for i = 1:newnum
%             for j = 1 : D
%                 newpop(i,j) = xmin + rand * (xmax-xmin);
%             end
%         end
%         newparent = [newpop;parent((newnum+1:popnum),1:D)];
%         f = value(newparent,length(newparent),taot,nt,gen,D);
%         %FDA2的函数值
%         %f = value(newparent,length(newparent),taot,gen,D);
%         newparent=[newparent,f];
%         [non_dominant_sortpop, rankinfo]=non_dominant_sort(newparent,m,D);
%         nsdcpop=crowding_distance(non_dominant_sortpop,m,D,rankinfo);
%         parent=generate_offsprings(nsdcpop,m,D,popnum);
%     end
     % NSGA-2-B 环境预测模型
     pm = 0.2;
     hm = 4;
     % FDA1的参数
     % newnum = popnum * 0.4;
     % FDA2的参数
     % newnum = popnum * 0.8;
     % FDA3的参数
     newnum = popnum * 0.6;
     for i = 1:newnum
         for j = 1 : D
             newpop(i,j) = xmin + rand * (xmax-xmin);
         end
     end
     newparent= genetic_operate(newpop,m,D,hc,hm,xmax,xmin);
     f = value(newparent,length(newparent),taot,nt,gen,D);
     % FDA2的函数值
     %f = value(newparent,length(newparent),taot,gen,D);
     newparent=[newparent,f];
     [non_dominant_sortpop, rankinfo]=non_dominant_sort(newparent,m,D);
     nsdcpop=crowding_distance(non_dominant_sortpop,m,D,rankinfo);
     parent=generate_offsprings(nsdcpop,m,D,popnum);
    end
end
hold on
% A=load('ZDT6.txt');
% f1=A(:,1);
% f2=A(:,2);
% plot(f1,f2,'g');
% title('result');
% legend('NSGA-II','ideal');
% funcval=f;  
% opt=A;
%    for j=1:m %求取最大最小值
%        maxopt(j)=max(opt(:,j));
%        minopt(j)=min(opt(:,j));
%    end
%    distance=zeros(1,size(funcval,1));
%    sumfval=zeros(1,size(opt,1));
%    dsum=0;      
%    for j=1:size(opt,1)
%    for i=1:size(funcval,1)
%         for z=1:m
%          sumfval(i)= sumfval(i)+((opt(j,z)-funcval(i,z))/(maxopt(z)-minopt(z)))^2;
%         end
%          distance(i)=sqrt(sumfval(i));
%          sumfval(:)=0;
%    end
%       distance(j)=min(distance);
%       dsum=dsum+distance(j);
%    end   
%      IGD=dsum/size(opt,1);
%      fprintf('IGD=%f\n',IGD);