function [Pb,trace,FEs_fitness] = LensOBLDE(func_num,fhd,D,NP,F,CR,gen_max,Max_FES,border,varargin)

eps=1e-7;
fbias=[100,200,300,400,500,600,700,...       % Optimal value offset
       800,900,1000,1100,1200,1300,...
       1400,1500,1600,1700,1800,1900,...
       2000,2100,2200,2300,2400,2500,...
       2600,2700,2800,2900,3000];

trace=zeros(gen_max,2);    
bounds=border*ones(D,2);    
bounds(:,1)=-1*bounds(:,1);   
rng=(bounds(:,2)-bounds(:,1))';    
x=(ones(NP,1)*rng).*(rand(NP,D))+(ones(NP,1)*bounds(:,1)'); 

for i=1:NP
        a=min(x);
        b=max(x);
        ox(i,:)=rand()*(a+b)-x(i,:);
        if ox(i,:)<a | ox(i,:)>b
           ox(i,:)=(b-a)*rand()+a;
        end     
        if (feval(fhd,ox(i,:)',varargin{:})-fbias(func_num))<(feval(fhd,x(i,:)',varargin{:})-fbias(func_num))
            x(i,:)=ox(i,:);
        end
end

trial=zeros(1,D);  
cost=zeros(1,NP);   
Pb=inf; 
Xb=x(1,:);
for i=1:NP
    cost(i)=feval(fhd,x(i,:)',varargin{:})-fbias(func_num);
    if(cost(i)<=Pb)
        Pb=cost(i);
        Xb=x(i,:);
    end
end
fitFEs_count = NP;
initial_FEs = 1;
new_FEs = fitFEs_count;
FEs_fitness(initial_FEs:new_FEs) = Pb;
old_FEs = new_FEs;

trace(1,1)=1;
trace(1,2)=Pb;
% Main loop %
for count = 2 : gen_max
    
    if fitFEs_count > Max_FES
        break;
    end
    
    if rand()<=0.01
        [pop_value,pop_index] = sort(cost); 
        [~,pop_rank] = sort(pop_index);     
        for i=1:length(cost) 
            if pop_rank(i) <= 10
                for ii=1:NP            
                    if (cost(ii) == pop_value(pop_rank(i))) 
                        x(ii,:)=x(ii,:)*(0.1+0.1*tan((rand()-0.5)*pi));   % Cauchy perturbation strategy %
                    end            
                end
            end
        end
    end
    for i=1:NP
        while 2>1            
            a=floor(rand*NP)+1;  
            if a~=i          
                break;
            end
        end
        while 2>1
            b=floor(rand*NP)+1;
            if b~=i&&b~=a
                break;
            end
        end
        while 2>1
            c=floor(rand*NP)+1;
            if c~=i&&c~=a&&c~=b
                break;
            end
        end
        jrand=floor(rand*D+1);   
        %%%%%%%% Mutation and Crossover %%%%%%%%
        for k=1:D
            if(rand<CR||jrand==k)       
                trial(k)=x(c,k)+F*(x(a,k)-x(b,k));
            else
                trial(k)=x(i,k);
            end
            if trial(k)<bounds(k,1)       
                trial(k)=bounds(k,1);
            end
            if trial(k)>bounds(k,2)
                trial(k)=bounds(k,2);
            end
        end
        
        a=min(x);
        b=max(x);
        K1=1-(1-0.01)*(count/gen_max);     %The scale factor
        K2=1+count*(2-1)/gen_max;
        R1=(a+b-2*x(i,:))*(1/((K1+1)*2));  %The search radius
        R2=(a+b-2*x(i,:))*(1/((K2+1)*2));        
          if rand<=0.05
                 if x(i,:)<R1 & x(i,:)>=2*R1 
                     ox(i,:)=((1+1/K1)*R1+(a+b)/2);     %The position of the oppsite point
                 elseif x(i,:)<2*R2
                     ox(i,:)=((1+1/K2)*R2+(a+b)/2);
                 else
                     ox(i,:)=rand*(a+b)-x(i,:);
                 end
                 if ox(i,:)<a | ox(i,:)>b
                     ox(i,:)=rand()*(b-a)+a;
                 end
          else
              ox(i,:)=(a+b)-x(i,:);
          end
        
        oxscore=feval(fhd,ox(i,:)',varargin{:})-fbias(func_num);
        trialscore=feval(fhd,trial(:),varargin{:})-fbias(func_num); 
        fitFEs_count = fitFEs_count + 1;    
        xiscore=cost(i);   
        
        xmin=xiscore;
        if xmin>trialscore
            x(i,1:D)=trial(1:D);
            cost(i)=trialscore;
            xmin=trialscore;
        end
        if xmin>oxscore
            x(i,1:D)=ox(1:D);
            cost(i)=oxscore;
        end
        
        if cost(i)<=Pb     
            Pb=cost(i);
            if cost(i)<=eps
                cost(i)=0;
            end
            Xb(1:D)=x(i,1:D);
        end
    new_FEs = fitFEs_count;
    FEs_fitness(old_FEs:new_FEs) = Pb;
    old_FEs = new_FEs;
    end
    
    trace(count,1)=count;
    trace(count,2)=Pb;
end
%--------------End search---------------
%fprintf("The optimal value is:%d\n",trace(count,2));
end
