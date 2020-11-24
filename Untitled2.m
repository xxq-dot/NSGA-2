   % 模拟二进制交叉
     pc = 0.9; %交叉概率
     hc = 20;
     offspringc = [];
     % popnum/2 是为了保持子代种群规模还是100
     for j = 1 : popnum/2
         s = randperm(popnum);
         %这里要重新产生1-n的包含n个数的随机排列，这里的n是100，上面的s1从第二次迭代开始是1-200，所以要区分，不能直接用前面的
         % 产生0~1 之间的随机数
         se1=s(1);
         se2=s(2);
         u = rand(1);
           if u < 0.5
                 B = (2 * u)^(1/(hc + 1));
             else 
                 B = (1/(2*(1-u)))^(1/(hc + 1));
           end
           if u < pc
               % s1 = randperm(100)
               % 第一个子代交叉                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        s1 = randperm(size(x,1)
               offsp1 = 0.5 *[(1-B)* parent(se1,:) + (1+B)* parent(se2,:)];
                for k = 1 : D 
                   offsp1(1,k) = max(offsp1(1,k),xmin+0.0001);
                   offsp1(1,k) = min(offsp1(1,k),xmax-0.0001);
                end
               offsp2 = 0.5 *[(1-B)* parent(se2,:) + (1+B)* parent(se1,:)];
               % 控制第二个个体的上下限
                for k = 1 : D 
                   offsp2(1,k) = max(offsp2(1,k),xmin+0.0001);
                   offsp2(1,k) = min(offsp2(1,k),xmax-0.0001);
                end
               %上下限的控制有问题，offsp2(1,1)范围是[xmin1,xmax1],offsp2(1,2)范围是[xmin2,xmax2]
               offspringc = [offspringc;offsp1;offsp2];
           else
               % 不交叉，即父代
               offspringc = [offspringc;parent(se1,:);parent(se2,:)];
           end
     end
     % 变异
     % 多项式变异
     pm = 0.5;
     hm = 20;
     offspringm = [];
     %变异操作的标号不能继续用i,因为外部的迭代循环用的就是i
     for j = 1 : popnum 
         r = rand(1);
         if r < 0.5
             mu = (2 * r)^(1/(hm + 1))-1;
         else
             mu = 1 - [2 * (1-r)]^(1/(hm + 1));
         end
         if r < pm
             offspringm1= offspringc(j,:) + mu * (xmax-xmin);
             for k = 1 : D
                  offspringm1(1,k) = max( offspringm1(1,k),xmin+0.0001);
                  offspringm1(1,k) = min( offspringm1(1,k),xmax-0.0001);
             end   
             offspringm = [offspringm;offspringm1]; 
         else
             % 不进行变异
             offspringm = [offspringm;offspringc(j,:)];    
         end
     end  