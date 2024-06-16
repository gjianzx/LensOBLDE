%用途：交互式差分演化使用反向学习策略的程序
% function main
% clear;
% clc;
% close all; 
% addpath(genpath(pwd));  %打开一个不在matlab工作路径上的文件
% runNumber=30; %运行次数
% D=10;         %维数
% NP=100;       %NP为种群规模
% F=0.5;        %突变因子
% Fmax=0.9;
% Fmin=0.1;
% CR=0.9;       %交叉概率
% Max_FES = 10000 * D; % 最大函数评估数
% gen_max = Max_FES/NP;  % 最大迭代数 
% border=100;     %上下界绝对值（一般为对称搜索空间）
% % func_num=3;        %测试函数选择
% fhd=str2func('cec17_func');
% 
% global fbias
% %最优值偏移量%
% fbias=[100,200,300,400,500,600,700,...
%        800,900,1000,1100,1200,1300,...
%        1400,1500,1600,1700,1800,1900,...
%        2000,2100,2200,2300,2400,2500,...
%        2600,2700,2800,2900,3000];
% DODEMatrix=zeros(runNumber,Max_FES);
% OMLDEMatrix=zeros(runNumber,Max_FES);
% OBAMatrix=zeros(runNumber,Max_FES);
% NBOLDEMatrix=zeros(runNumber,Max_FES);
% GPODEMatrix=zeros(runNumber,Max_FES);
% JaDEMatrix=zeros(runNumber,Max_FES);
% ACDE_FMatrix=zeros(runNumber,Max_FES);
% Algs_FES = zeros(7,Max_FES);
% 
% DEMatrix=zeros(gen_max,runNumber);
% GODEMatrix=zeros(gen_max,runNumber);
% OBLDEMatrix=zeros(gen_max,runNumber);
% CODEMatrix=zeros(gen_max,runNumber);
% DODEMatrix=zeros(gen_max,runNumber);
% OMLDEMatrix=zeros(gen_max,runNumber);
% LensOBLDEMatrix=zeros(gen_max,runNumber);
% 
% for k=21:30 
%     func_num=k;
%     if k==2
%         continue;
%     end
%     fprintf("\n------------------------\n");
%     fprintf("开始调用F%d函数\n",k);
%     fprintf("------------------------\n");
% s=zeros(7,runNumber);
% for i=1:runNumber
%     [Pb,~,FEs_fitness]=DE(func_num,fhd,D,NP,F,CR,gen_max,Max_FES,border,func_num);
%     OMLDEMatrix(i,:)=FEs_fitness;
%     DEMatrix(:,i)=trace(:,2);
%     s(1,i)=Pb;
%     
%     [Pb,trace]=GODE(func_num,fhd,D,NP,F,CR,gen_max,border,func_num);
%     GODEMatrix(:,i)=trace(:,2);
%     s(2,i)=Pb;
%     
%     [Pb,trace]=CODE(func_num,fhd,D,NP,F,CR,gen_max,border,func_num);
%     CODEMatrix(:,i)=trace(:,2);
%     s(3,i)=Pb;
%     
%     [Pb,trace]=OBLDE(func_num,fhd,D,NP,F,CR,gen_max,border,func_num);
%     OBLDEMatrix(:,i)=trace(:,2);
%     s(4,i)=Pb;
%     
%     [Pb,trace]=DODE(func_num,fhd,D,NP,F,CR,gen_max,border,func_num);
%     DODEMatrix(:,i)=trace(:,2);
%     s(5,i)=Pb;
%     
%     [Pb,trace]=OMLDE(func_num,fhd,D,NP,F,CR,gen_max,border,func_num);
%     OMLDEMatrix(:,i)=trace(:,2);
%     s(6,i)=Pb;
%     
%     [Pb,trace]=LensOBLDE(func_num,fhd,D,NP,F,CR,gen_max,border,func_num);
%     LensOBLDEMatrix(:,i)=trace(:,2);
%     s(7,i)=Pb;
% 
% end
% trace=zeros(gen_max,8);  %用于存放各个算法的每次迭代的最优值
% 
% for i=1:gen_max
%     trace(i,1)=i;        %存放迭代次数
%     for j=1:runNumber
%        trace(i,2)=trace(i,2)+DEMatrix(i,j);
%        trace(i,3)=trace(i,3)+GODEMatrix(i,j);
%        trace(i,4)=trace(i,4)+CODEMatrix(i,j);
%        trace(i,5)=trace(i,5)+OBLDEMatrix(i,j);
%        trace(i,6)=trace(i,6)+DODEMatrix(i,j);
%        trace(i,7)=trace(i,7)+OMLDEMatrix(i,j);
%        trace(i,8)=trace(i,8)+LensOBLDEMatrix(i,j);       
%     end
%     trace(i,2:8)= trace(i,2:8)/runNumber;   %求解运行50次的平均适应值    
% end
% 
% fprintf("DE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(1,:)),max(s(1,:)),median(s(1,:)),mean(s(1,:)),std(s(1,:)));
% fprintf("\nGODE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(2,:)),max(s(2,:)),median(s(2,:)),mean(s(2,:)),std(s(2,:)));
% fprintf("\nCODE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(3,:)),max(s(3,:)),median(s(3,:)),mean(s(3,:)),std(s(3,:)));
% fprintf("\nOBLDE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(4,:)),max(s(4,:)),median(s(4,:)),mean(s(4,:)),std(s(4,:)));
% fprintf("\nDODE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(5,:)),max(s(5,:)),median(s(5,:)),mean(s(5,:)),std(s(5,:)));
% fprintf("\nOMLDE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(6,:)),max(s(6,:)),median(s(6,:)),mean(s(6,:)),std(s(6,:)));
% fprintf("\nLensOBLDE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(7,:)),max(s(7,:)),median(s(7,:)),mean(s(7,:)),std(s(7,:)));
% 
% %%% 保存excel数据 %%%
% save_data(k,func_num,s,D);   
% %%% 保存mat文件 %%%
% if D==10
%     path='E:\MATLAB\project\DE\save_data\10\';
% elseif D==30
%     path='E:\MATLAB\project\DE\save_data\30\';
% elseif D==50
%     path='E:\MATLAB\project\DE\save_data\50\';
% end
% filename=strcat('DE','_',int2str(D),'_',int2str(k),'.mat');
% save([path,filename],'trace');
% 
% %%% 画图并保存 %%%
% figure(k);
% plot(trace(:,1),trace(:,2),'k-o',...   %DE黑色圆圈
%      trace(:,1),trace(:,3),'y-h',...   %GODE黄色六角形
%      trace(:,1),trace(:,4),'r-v',...   %CODE红色下三角
%      trace(:,1),trace(:,5),'m-s',...   %OBLDE品红方形
%      trace(:,1),trace(:,6),'c-^',...   %DODE青蓝上三角
%      trace(:,1),trace(:,7),'g-p',...   %OMLDE绿色五角形
%      trace(:,1),trace(:,8),'b-D',...   %LensOBLDE蓝色菱形
%      'MarkerIndices',1:round(gen_max/10):gen_max,'LineWidth',1);
% legend('DE','GODE','CODE','OBLDE','DODE','OMLDE','LensOBLDE','Location','Best');
% set(gca,'Xtick',0:round(gen_max/5):gen_max);
% xlabel('Function Evaluations');
% ylabel('Average Function Values');
% 
% if D==10
%     path='E:\MATLAB\project\DE\实验截图\10维\';
% elseif D==30
%     path='E:\MATLAB\project\DE\实验截图\30维\';
% elseif D==50
%     path='E:\MATLAB\project\DE\实验截图\50维\';
% end
% saveas(gcf,[path,'F',num2str(k),'.png']); 
% end
% 
% end

%% 测试OMLDE,SPODE,ACDE_F
clear;
clc;
close all; 
addpath(genpath(pwd));  %打开一个不在matlab工作路径上的文件
runNumber=10; %运行次数
D=50;         %维数
NP=100;       %NP为种群规模
F=0.5;        %突变因子
CR=0.9;       %交叉概率
Max_FES = 10000 * D; % 最大函数评估数
gen_max = Max_FES/NP;  % 最大迭代数 
border=100;     %上下界绝对值（一般为对称搜索空间）
fhd=str2func('cec17_func');
str="OAS";

global fbias
%最优值偏移量%
fbias=[100,200,300,400,500,600,700,...
       800,900,1000,1100,1200,1300,...
       1400,1500,1600,1700,1800,1900,...
       2000,2100,2200,2300,2400,2500,...
       2600,2700,2800,2900,3000];
   
OMLDEMatrix=zeros(runNumber,Max_FES);
SPODEMatrix=zeros(runNumber,Max_FES);
ACDE_FMatrix=zeros(runNumber,Max_FES);

OAS_FES = zeros(5,Max_FES);
s=zeros(3,runNumber);
for k=25:30
    func_num=k;
    if k==2
        continue;
    end
    fprintf("\n----------------------------------\n");
    fprintf("开始测试对比算法的%d维-F%d函数 >>>>\n",D,k);
    fprintf("----------------------------------\n");
for i=1:runNumber
    fprintf("-----第%d次运行-----\n",i);
    fprintf("OMLDE--->");
    [Pb,~,FEs_fitness]=OMLDE(func_num,fhd,D,NP,F,CR,gen_max,Max_FES,border,func_num);
    OMLDEMatrix(i,:)=FEs_fitness;
    s(1,i)=Pb;
    
    fprintf("ACDE_F--->");       
    [Pb,~,FEs_fitness]=ACDE_F(func_num,fhd,D,NP,gen_max,Max_FES,border,func_num);
    ACDE_FMatrix(i,:)=FEs_fitness;
    s(2,i)=Pb;
    
    fprintf("SPODE\n");       
    [Pb,~,FEs_fitness]=SPODE(func_num,fhd,D,NP,F,CR,gen_max,Max_FES,border,func_num);
    SPODEMatrix(i,:)=FEs_fitness;
    s(3,i)=Pb;
end
OAS_FES(1,:)= mean(OMLDEMatrix,1);
OAS_FES(2,:)= mean(ACDE_FMatrix,1);
OAS_FES(3,:)= mean(SPODEMatrix,1);

if D==10
    path='E:\MATLAB\project\LensOBLDE\Datas\10D\';
elseif D==30
    path='E:\MATLAB\project\LensOBLDE\Datas\30D\';
elseif D==50
    path='E:\MATLAB\project\LensOBLDE\Datas\50D\';
end
filename=strcat('OAS','_',int2str(D),'D_F',int2str(k),'.mat');
save([path,filename],'OAS_FES');

fprintf("\nOMLDE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(1,:)),max(s(1,:)),median(s(1,:)),mean(s(1,:)),std(s(1,:)));
fprintf("\nACDE_F:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(2,:)),max(s(2,:)),median(s(2,:)),mean(s(2,:)),std(s(2,:)));
fprintf("\nSPODE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(3,:)),max(s(3,:)),median(s(3,:)),mean(s(3,:)),std(s(3,:)));

%%% 保存excel数据 %%%
 save_data(k,D,s,str);   

end

%% 单独测试OMLDE
clear;
clc;
close all; 
addpath(genpath(pwd));  %打开一个不在matlab工作路径上的文件
runNumber=10; %运行次数
D=50;         %维数
NP=100;       %NP为种群规模
F=0.5;        %突变因子
CR=0.9;       %交叉概率
Max_FES = 10000 * D; % 最大函数评估数
gen_max = Max_FES/NP;  % 最大迭代数 
border=100;     %上下界绝对值（一般为对称搜索空间）
fhd=str2func('cec17_func');
str = "OMLDE";  % 用于保存对比算法标志的字符串

global fbias
%最优值偏移量%
fbias=[100,200,300,400,500,600,700,...
       800,900,1000,1100,1200,1300,...
       1400,1500,1600,1700,1800,1900,...
       2000,2100,2200,2300,2400,2500,...
       2600,2700,2800,2900,3000];
   
OMLDEMatrix=zeros(runNumber,Max_FES);

Local_Algs_FES = zeros(1,Max_FES);
s=zeros(1,runNumber);
for k=27:27
    func_num=k;
    if k==2
       continue;
    end
    fprintf("\n----------------------------------\n");
    fprintf("开始测试%s的%d维-F%d函数 >>>>\n",str,D,k);
    fprintf("----------------------------------\n");
    
for i=1:runNumber
    fprintf("-----%s第%d次运行-----\n",str,i);
    [Pb,~,FEs_fitness]=OMLDE(func_num,fhd,D,NP,F,CR,gen_max,Max_FES,border,func_num);
    OMLDEMatrix(i,:)=FEs_fitness;
    s(1,i)=Pb;
     
end
Local_Algs_FES(1,:)= mean(OMLDEMatrix,1);

if D==10
    path='E:\MATLAB\project\LensOBLDE\Datas\10D\';
elseif D==30
    path='E:\MATLAB\project\LensOBLDE\Datas\30D\';
elseif D==50
    path='E:\MATLAB\project\LensOBLDE\Datas\50D\';
end
filename=strcat('OAS','_',int2str(D),'D_F',int2str(k),'.mat');
load([path,filename]);
OAS_FES(1,:)=Local_Algs_FES(1,:);
save([path,filename],'OAS_FES');

fprintf("\nOMLDE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(1,:)),max(s(1,:)),median(s(1,:)),mean(s(1,:)),std(s(1,:)));

%保存OMLDE的Best,Worst,Median,Mean,Std到excel
%  save_data(k,D,s,str); 
end

%% 单独测试ACDE_F
clear;
clc;
close all; 
addpath(genpath(pwd));  %打开一个不在matlab工作路径上的文件
runNumber=10; %运行次数
D=10;         %维数
NP=100;       %NP为种群规模
F=0.5;        %突变因子
CR=0.9;       %交叉概率
Max_FES = 10000 * D; % 最大函数评估数
gen_max = Max_FES/NP;  % 最大迭代数 
border=100;     %上下界绝对值（一般为对称搜索空间）
fhd=str2func('cec17_func');
str = "ACDE_F";  % 用于保存对比算法标志的字符串

global fbias
%最优值偏移量%
fbias=[100,200,300,400,500,600,700,...
       800,900,1000,1100,1200,1300,...
       1400,1500,1600,1700,1800,1900,...
       2000,2100,2200,2300,2400,2500,...
       2600,2700,2800,2900,3000];
   
ACDE_FMatrix=zeros(runNumber,Max_FES);

Local_Algs_FES = zeros(1,Max_FES);
s=zeros(1,runNumber);
for k=30:30
    func_num=k;
    if k==2
       continue;
    end
    fprintf("\n----------------------------------\n");
    fprintf("开始测试%s的%d维-F%d函数 >>>>\n",str,D,k);
    fprintf("----------------------------------\n");
    
for i=1:runNumber
    fprintf("-----%s第%d次运行-----\n",str,i);
    [Pb,~,FEs_fitness]=ACDE_F(func_num,fhd,D,NP,gen_max,Max_FES,border,func_num);
    ACDE_FMatrix(i,:)=FEs_fitness;
    s(1,i)=Pb;
     
end
Local_Algs_FES(1,:)= mean(ACDE_FMatrix,1);

if D==10
    path='E:\MATLAB\project\LensOBLDE\Datas\10D\';
elseif D==30
    path='E:\MATLAB\project\LensOBLDE\Datas\30D\';
elseif D==50
    path='E:\MATLAB\project\LensOBLDE\Datas\50D\';
end
filename=strcat('OAS','_',int2str(D),'D_F',int2str(k),'.mat');
load([path,filename]);
OAS_FES(2,:)=Local_Algs_FES(1,:);
save([path,filename],'OAS_FES');

fprintf("\nACDE_F:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(1,:)),max(s(1,:)),median(s(1,:)),mean(s(1,:)),std(s(1,:)));

%保存OMLDE的Best,Worst,Median,Mean,Std到excel
%  save_data(k,D,s,str); 
end

%% 单独测试SPODE
clear;
clc;
close all; 
addpath(genpath(pwd));  %打开一个不在matlab工作路径上的文件
runNumber=10; %运行次数
D=50;         %维数
NP=100;       %NP为种群规模
F=0.5;        %突变因子
CR=0.9;       %交叉概率
Max_FES = 10000 * D; % 最大函数评估数
gen_max = Max_FES/NP;  % 最大迭代数 
border=100;     %上下界绝对值（一般为对称搜索空间）
fhd=str2func('cec17_func');
str = "SPODE";  % 用于保存对比算法标志的字符串

global fbias
%最优值偏移量%
fbias=[100,200,300,400,500,600,700,...
       800,900,1000,1100,1200,1300,...
       1400,1500,1600,1700,1800,1900,...
       2000,2100,2200,2300,2400,2500,...
       2600,2700,2800,2900,3000];
   
SPODEMatrix=zeros(runNumber,Max_FES);

Local_Algs_FES = zeros(1,Max_FES);
s=zeros(1,runNumber);
for k=20:20
    func_num=k;
    if k==2
       continue;
    end
    fprintf("\n----------------------------------\n");
    fprintf("开始测试%s的%d维-F%d函数 >>>>\n",str,D,k);
    fprintf("----------------------------------\n");
    
for i=1:runNumber
    fprintf("-----%s第%d次运行-----\n",str,i);
    [Pb,~,FEs_fitness]=SPODE(func_num,fhd,D,NP,F,CR,gen_max,Max_FES,border,func_num);
    SPODEMatrix(i,:)=FEs_fitness;
    s(1,i)=Pb;
     
end
Local_Algs_FES(1,:)= mean(SPODEMatrix,1);

if D==10
    path='E:\MATLAB\project\LensOBLDE\Datas\10D\';
elseif D==30
    path='E:\MATLAB\project\LensOBLDE\Datas\30D\';
elseif D==50
    path='E:\MATLAB\project\LensOBLDE\Datas\50D\';
end
filename=strcat('OAS','_',int2str(D),'D_F',int2str(k),'.mat');
load([path,filename]);
OAS_FES(3,:)=Local_Algs_FES(1,:);
save([path,filename],'OAS_FES');

fprintf("\nSPODE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(1,:)),max(s(1,:)),median(s(1,:)),mean(s(1,:)),std(s(1,:)));

%保存OMLDE的Best,Worst,Median,Mean,Std到excel
%  save_data(k,D,s,str); 
end
%% 测试ODE
clear;
clc;
close all; 
addpath(genpath(pwd));  %打开一个不在matlab工作路径上的文件
runNumber=10; %运行次数
D=30;         %维数
NP=100;       %NP为种群规模
F=0.5;        %突变因子
CR=0.9;       %交叉概率
Max_FES = 10000 * D; % 最大函数评估数
gen_max = Max_FES/NP;  % 最大迭代数 
border=100;     %上下界绝对值（一般为对称搜索空间）
fhd=str2func('cec17_func');
str = "ODE";  % 用于保存对比算法标志的字符串

global fbias
%最优值偏移量%
fbias=[100,200,300,400,500,600,700,...
       800,900,1000,1100,1200,1300,...
       1400,1500,1600,1700,1800,1900,...
       2000,2100,2200,2300,2400,2500,...
       2600,2700,2800,2900,3000];
   
OBLDEMatrix=zeros(runNumber,Max_FES);

Local_Algs_FES = zeros(1,Max_FES);
s=zeros(1,runNumber);
for k=29:29
    func_num=k;
    if k==2
       continue;
    end
    fprintf("\n----------------------------------\n");
    fprintf("开始测试%s的%d维-F%d函数 >>>>\n",str,D,k);
    fprintf("----------------------------------\n");
    
for i=1:runNumber
    fprintf("-----%s第%d次运行-----\n",str,i);
    [Pb,~,FEs_fitness]=OBLDE(func_num,fhd,D,NP,F,CR,gen_max,Max_FES,border,func_num);
    OBLDEMatrix(i,:)=FEs_fitness;
    s(1,i)=Pb;
     
end
Local_Algs_FES(1,:)= mean(OBLDEMatrix,1);

if D==10
    path='E:\MATLAB\project\LensOBLDE\Datas\10D\10\';
elseif D==30
    path='E:\MATLAB\project\LensOBLDE\Datas\30D\30\';
elseif D==50
    path='E:\MATLAB\project\LensOBLDE\Datas\50D\50\';
end
filename=strcat('Lens_OBL_Algs','_',int2str(D),'D_F',int2str(k),'.mat');
load([path,filename]);
Lens_OBL_Algs_FES(1,:)=Local_Algs_FES(1,:);
save([path,filename],'Lens_OBL_Algs_FES');

fprintf("\nODE:\nBest为:%d\nWorst为:%d\nMedian为:%d\nMean为:%d\nStd为:%d\n",min(s(1,:)),max(s(1,:)),median(s(1,:)),mean(s(1,:)),std(s(1,:)));

%保存OMLDE的Best,Worst,Median,Mean,Std到excel
%  save_data(k,D,s,str); 
end