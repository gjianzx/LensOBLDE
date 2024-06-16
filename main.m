clear;
clc;
close all; 
addpath(genpath(pwd));  
runNumber=30;                 % Run times
D=10;                         % Dimension  (10  30  50)
NP=100;                       % Population size
F=0.5;                        % Mutation operator
CR=0.9;                       % Crossover operator
gen_max=5000;%10000*D;        % Maximum number of iterations 
border=100;                   % Absolute value of upper and lower bounds
fhd=str2func('cec17_func');   % CEC2017 benchmark suite

global fbias
% Optimal value offset %
fbias=[100,200,300,400,500,600,700,...
       800,900,1000,1100,1200,1300,...
       1400,1500,1600,1700,1800,1900,...
       2000,2100,2200,2300,2400,2500,...
       2600,2700,2800,2900,3000];

LensOBLDEMatrix=zeros(gen_max,runNumber);

for k=1:30 
    func_num=k;
    if k==2 
        continue;
    end
    fprintf("\n------------------------\n");
    fprintf("Start testing the F%d function\n",k);
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
