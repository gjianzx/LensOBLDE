clear;
clc;
close all; 
addpath(genpath(pwd));  
runNumber=30; %运行次数
D=10;         %维数
NP=100;       %NP为种群规模
F=0.5;        %突变因子
CR=0.9;       %交叉概率
gen_max=5000;%10000*D;  %最大进化代数 
border=100;     %上下界绝对值（一般为对称搜索空间）
% func_num=3;        %测试函数选择
fhd=str2func('cec17_func');

global fbias
%最优值偏移量%
fbias=[100,200,300,400,500,600,700,...
       800,900,1000,1100,1200,1300,...
       1400,1500,1600,1700,1800,1900,...
       2000,2100,2200,2300,2400,2500,...
       2600,2700,2800,2900,3000];

LensOBLDEMatrix=zeros(gen_max,runNumber);

for k=16:19 %21
    func_num=k;
    if k==2 
        continue;
    end
    fprintf("\n------------------------\n");
    fprintf("开始调用F%d函数\n",k);
    fprintf("------------------------\n");
s=zeros(7,runNumber);
for i=1:runNumber

    [Pb,xg_trace]=LensOBLDE(func_num,fhd,D,NP,F,CR,gen_max,border,func_num);
    LensOBLDEMatrix(:,i)=xg_trace(:,2);
    s(7,i)=Pb;
end

xg_trace=zeros(gen_max,2);  
for i=1:gen_max
    xg_trace(i,1)=i;        
    for j=1:runNumber
       xg_trace(i,2)=xg_trace(i,2)+LensOBLDEMatrix(i,j);       
    end
    xg_trace(i,2)= xg_trace(i,2)/runNumber;   
end
d=7;
fprintf("\nLensOBLDE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",...
        min(s(d,:)),max(s(d,:)),median(s(d,:)),mean(s(d,:)),std(s(d,:)));
    
end
