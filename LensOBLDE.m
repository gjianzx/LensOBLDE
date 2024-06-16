% ����͹͸������ķ���ѧϰ��ֽ����㷨 %
function [Pb,trace,FEs_fitness] = LensOBLDE(func_num,fhd,D,NP,F,CR,gen_max,Max_FES,border,varargin)

eps=1e-7;%����
% gen_max=20;%����������
%rng('shuffle');
fbias=[100,200,300,400,500,600,700,...
       800,900,1000,1100,1200,1300,...
       1400,1500,1600,1700,1800,1900,...
       2000,2100,2200,2300,2400,2500,...
       2600,2700,2800,2900,3000];
Fmin=0.1;
Fmax=0.9;

trace=zeros(gen_max,2);     %gen_max*2�������
bounds=border*ones(D,2);    %�߽�
bounds(:,1)=-1*bounds(:,1);   %����߽�Ϊ��
rng=(bounds(:,2)-bounds(:,1))';    %�ұ߽�����߽�Ĳ�  ������Ϊת��
x=(ones(NP,1)*rng).*(rand(NP,D))+(ones(NP,1)*bounds(:,1)');  %��ʼ��Ⱥ

for i=1:NP
        a=min(x);
        b=max(x);
        ox(i,:)=rand()*(a+b)-x(i,:);
        if ox(i,:)<a | ox(i,:)>b
           ox(i,:)=(b-a)*rand()+a;
        end     
%           for j=1:D
%               ox(i,j)=rand()*(a(j)+b(j))-x(i,j);
%           end
        if (feval(fhd,ox(i,:)',varargin{:})-fbias(func_num))<(feval(fhd,x(i,:)',varargin{:})-fbias(func_num))
            x(i,:)=ox(i,:);
        end
end

trial=zeros(1,D);   %����1*D�ľ���
cost=zeros(1,NP);   
Pb=inf; %cost(1);%�������ֵ    %�ѵ�һ�����ӵ���Ӧֵ������ʼ��ȫ������ֵ
Xb=x(1,:);%�������λ��
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

for count = 2 : gen_max
    
    if fitFEs_count > Max_FES
        break;
    end
    
%     if rand()<=0.01
%         s_cost=sort(cost);
%         for j=1:0.1*length(s_cost)
%         for i=1:NP            
%             if (cost(i)==Pb) %(cost(i)==Pb)
%                 x(i,:)=x(i,:)*(0.75+0.1*tan((rand()-0.5)*pi));
%             end            
%         end
%         end
%     end
    if rand()<=0.01
        [pop_value,pop_index] = sort(cost); % pop_value �������Ӧֵ��pop_index �������Ӧֵ������ֵ��
        [~,pop_rank] = sort(pop_index);     % pop_rank �ó���Ⱥ��Ӧֵ����  ������Ӧ��costԭʼֵ
        for i=1:length(cost) 
            if pop_rank(i) <= 10
                for ii=1:NP            
                    if (cost(ii) == pop_value(pop_rank(i))) %(cost(i)==Pb)
                        x(ii,:)=x(ii,:)*(0.1+0.1*tan((rand()-0.5)*pi));
                    end            
                end
            end
        end
    end
%     betterSolutionMatrix=[];
    for i=1:NP
        while 2>1             %��֤�����е���������Ϊ��ͬ������      
            a=floor(rand*NP)+1;  %floor�������е���ȡ����ֵ�������������С����
            if a~=i          % ~Ϊ�� ��a������iʱ
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
        jrand=floor(rand*D+1);   %Ϊ[1,2...D]�������(���ά��)
        %%%%%%%%���콻�����%%%%%%%%
        for k=1:D
            if(rand<CR||jrand==k)       
                trial(k)=x(c,k)+F*(x(a,k)-x(b,k));
            else
                trial(k)=x(i,k);
            end
            if trial(k)<bounds(k,1)       %�߽紦��
                trial(k)=bounds(k,1);
            end
            if trial(k)>bounds(k,2)
                trial(k)=bounds(k,2);
            end
        end
        
        a=min(x);
        b=max(x);
        K1=1-(1-0.01)*(count/gen_max);  %��������
        K2=1+count*(2-1)/gen_max;
        R1=(a+b-2*x(i,:))*(1/((K1+1)*2));  %�����뾶
        R2=(a+b-2*x(i,:))*(1/((K2+1)*2));        
          if rand<=0.05
                 if x(i,:)<R1 & x(i,:)>=2*R1 
                     ox(i,:)=((1+1/K1)*R1+(a+b)/2);     %������λ��
                 elseif x(i,:)<2*R2
                     ox(i,:)=((1+1/K2)*R2+(a+b)/2);
%                  elseif x(i,:)>=R1
%                      ox(i,:)=(a+b)-x(i,:);
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
        fitFEs_count = fitFEs_count + 1;    %��¼��������
        xiscore=cost(i);   %�ϸ������Ӧֵ
        
        xmin=xiscore;
        if xmin>trialscore
            x(i,1:D)=trial(1:D);
            cost(i)=trialscore;
            xmin=trialscore;
%             betterSolutionMatrix=[betterSolutionMatrix;x(i,:)];
        end
        if xmin>oxscore
            x(i,1:D)=ox(1:D);
            cost(i)=oxscore;
%             betterSolutionMatrix=[betterSolutionMatrix;x(i,:)];
        end
        
        if cost(i)<=Pb     %�ó����Ž�
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

    %��Ӣ����
%     if ~isempty(betterSolutionMatrix)   %�����Ϊ��
%         for i=1:NP            
%             if rand<=0.15 && (feval(fhd,x(i,:)',varargin{:})-fbias(func_num))>(feval(fhd,mean(betterSolutionMatrix,1)',varargin{:})-fbias(func_num))
%                 [row,colum]=size(betterSolutionMatrix);   %size(A) ����һ������������Ԫ���� A ����Ӧά�ȵĳ���
%                 index=randi([1,row],1,1);                %����һ������1��row��1*1������
%                 if (feval(fhd,x(i,:)',varargin{:})-fbias(func_num))>(feval(fhd,betterSolutionMatrix(index,:)',varargin{:})-fbias(func_num))
%                     x(i,:)=betterSolutionMatrix(index,:);
%                     cost(i)=feval(fhd,x(i,:)',varargin{:})-fbias(func_num);
%                 end              
%             end
%         end
%     end
    
    trace(count,1)=count;
    trace(count,2)=Pb;
end
%--------------��������---------------
%fprintf("����ֵΪ:%d\n",trace(count,2));
end
