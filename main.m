%��;������ʽ����ݻ�ʹ�÷���ѧϰ���Եĳ���
% function main
% clear;
% clc;
% close all; 
% addpath(genpath(pwd));  %��һ������matlab����·���ϵ��ļ�
% runNumber=30; %���д���
% D=10;         %ά��
% NP=100;       %NPΪ��Ⱥ��ģ
% F=0.5;        %ͻ������
% Fmax=0.9;
% Fmin=0.1;
% CR=0.9;       %�������
% Max_FES = 10000 * D; % �����������
% gen_max = Max_FES/NP;  % �������� 
% border=100;     %���½����ֵ��һ��Ϊ�Գ������ռ䣩
% % func_num=3;        %���Ժ���ѡ��
% fhd=str2func('cec17_func');
% 
% global fbias
% %����ֵƫ����%
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
%     fprintf("��ʼ����F%d����\n",k);
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
% trace=zeros(gen_max,8);  %���ڴ�Ÿ����㷨��ÿ�ε���������ֵ
% 
% for i=1:gen_max
%     trace(i,1)=i;        %��ŵ�������
%     for j=1:runNumber
%        trace(i,2)=trace(i,2)+DEMatrix(i,j);
%        trace(i,3)=trace(i,3)+GODEMatrix(i,j);
%        trace(i,4)=trace(i,4)+CODEMatrix(i,j);
%        trace(i,5)=trace(i,5)+OBLDEMatrix(i,j);
%        trace(i,6)=trace(i,6)+DODEMatrix(i,j);
%        trace(i,7)=trace(i,7)+OMLDEMatrix(i,j);
%        trace(i,8)=trace(i,8)+LensOBLDEMatrix(i,j);       
%     end
%     trace(i,2:8)= trace(i,2:8)/runNumber;   %�������50�ε�ƽ����Ӧֵ    
% end
% 
% fprintf("DE:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(1,:)),max(s(1,:)),median(s(1,:)),mean(s(1,:)),std(s(1,:)));
% fprintf("\nGODE:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(2,:)),max(s(2,:)),median(s(2,:)),mean(s(2,:)),std(s(2,:)));
% fprintf("\nCODE:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(3,:)),max(s(3,:)),median(s(3,:)),mean(s(3,:)),std(s(3,:)));
% fprintf("\nOBLDE:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(4,:)),max(s(4,:)),median(s(4,:)),mean(s(4,:)),std(s(4,:)));
% fprintf("\nDODE:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(5,:)),max(s(5,:)),median(s(5,:)),mean(s(5,:)),std(s(5,:)));
% fprintf("\nOMLDE:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(6,:)),max(s(6,:)),median(s(6,:)),mean(s(6,:)),std(s(6,:)));
% fprintf("\nLensOBLDE:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(7,:)),max(s(7,:)),median(s(7,:)),mean(s(7,:)),std(s(7,:)));
% 
% %%% ����excel���� %%%
% save_data(k,func_num,s,D);   
% %%% ����mat�ļ� %%%
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
% %%% ��ͼ������ %%%
% figure(k);
% plot(trace(:,1),trace(:,2),'k-o',...   %DE��ɫԲȦ
%      trace(:,1),trace(:,3),'y-h',...   %GODE��ɫ������
%      trace(:,1),trace(:,4),'r-v',...   %CODE��ɫ������
%      trace(:,1),trace(:,5),'m-s',...   %OBLDEƷ�췽��
%      trace(:,1),trace(:,6),'c-^',...   %DODE����������
%      trace(:,1),trace(:,7),'g-p',...   %OMLDE��ɫ�����
%      trace(:,1),trace(:,8),'b-D',...   %LensOBLDE��ɫ����
%      'MarkerIndices',1:round(gen_max/10):gen_max,'LineWidth',1);
% legend('DE','GODE','CODE','OBLDE','DODE','OMLDE','LensOBLDE','Location','Best');
% set(gca,'Xtick',0:round(gen_max/5):gen_max);
% xlabel('Function Evaluations');
% ylabel('Average Function Values');
% 
% if D==10
%     path='E:\MATLAB\project\DE\ʵ���ͼ\10ά\';
% elseif D==30
%     path='E:\MATLAB\project\DE\ʵ���ͼ\30ά\';
% elseif D==50
%     path='E:\MATLAB\project\DE\ʵ���ͼ\50ά\';
% end
% saveas(gcf,[path,'F',num2str(k),'.png']); 
% end
% 
% end

%% ����OMLDE,SPODE,ACDE_F
clear;
clc;
close all; 
addpath(genpath(pwd));  %��һ������matlab����·���ϵ��ļ�
runNumber=10; %���д���
D=50;         %ά��
NP=100;       %NPΪ��Ⱥ��ģ
F=0.5;        %ͻ������
CR=0.9;       %�������
Max_FES = 10000 * D; % �����������
gen_max = Max_FES/NP;  % �������� 
border=100;     %���½����ֵ��һ��Ϊ�Գ������ռ䣩
fhd=str2func('cec17_func');
str="OAS";

global fbias
%����ֵƫ����%
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
    fprintf("��ʼ���ԶԱ��㷨��%dά-F%d���� >>>>\n",D,k);
    fprintf("----------------------------------\n");
for i=1:runNumber
    fprintf("-----��%d������-----\n",i);
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

fprintf("\nOMLDE:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(1,:)),max(s(1,:)),median(s(1,:)),mean(s(1,:)),std(s(1,:)));
fprintf("\nACDE_F:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(2,:)),max(s(2,:)),median(s(2,:)),mean(s(2,:)),std(s(2,:)));
fprintf("\nSPODE:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(3,:)),max(s(3,:)),median(s(3,:)),mean(s(3,:)),std(s(3,:)));

%%% ����excel���� %%%
 save_data(k,D,s,str);   

end

%% ��������OMLDE
clear;
clc;
close all; 
addpath(genpath(pwd));  %��һ������matlab����·���ϵ��ļ�
runNumber=10; %���д���
D=50;         %ά��
NP=100;       %NPΪ��Ⱥ��ģ
F=0.5;        %ͻ������
CR=0.9;       %�������
Max_FES = 10000 * D; % �����������
gen_max = Max_FES/NP;  % �������� 
border=100;     %���½����ֵ��һ��Ϊ�Գ������ռ䣩
fhd=str2func('cec17_func');
str = "OMLDE";  % ���ڱ���Ա��㷨��־���ַ���

global fbias
%����ֵƫ����%
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
    fprintf("��ʼ����%s��%dά-F%d���� >>>>\n",str,D,k);
    fprintf("----------------------------------\n");
    
for i=1:runNumber
    fprintf("-----%s��%d������-----\n",str,i);
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

fprintf("\nOMLDE:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(1,:)),max(s(1,:)),median(s(1,:)),mean(s(1,:)),std(s(1,:)));

%����OMLDE��Best,Worst,Median,Mean,Std��excel
%  save_data(k,D,s,str); 
end

%% ��������ACDE_F
clear;
clc;
close all; 
addpath(genpath(pwd));  %��һ������matlab����·���ϵ��ļ�
runNumber=10; %���д���
D=10;         %ά��
NP=100;       %NPΪ��Ⱥ��ģ
F=0.5;        %ͻ������
CR=0.9;       %�������
Max_FES = 10000 * D; % �����������
gen_max = Max_FES/NP;  % �������� 
border=100;     %���½����ֵ��һ��Ϊ�Գ������ռ䣩
fhd=str2func('cec17_func');
str = "ACDE_F";  % ���ڱ���Ա��㷨��־���ַ���

global fbias
%����ֵƫ����%
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
    fprintf("��ʼ����%s��%dά-F%d���� >>>>\n",str,D,k);
    fprintf("----------------------------------\n");
    
for i=1:runNumber
    fprintf("-----%s��%d������-----\n",str,i);
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

fprintf("\nACDE_F:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(1,:)),max(s(1,:)),median(s(1,:)),mean(s(1,:)),std(s(1,:)));

%����OMLDE��Best,Worst,Median,Mean,Std��excel
%  save_data(k,D,s,str); 
end

%% ��������SPODE
clear;
clc;
close all; 
addpath(genpath(pwd));  %��һ������matlab����·���ϵ��ļ�
runNumber=10; %���д���
D=50;         %ά��
NP=100;       %NPΪ��Ⱥ��ģ
F=0.5;        %ͻ������
CR=0.9;       %�������
Max_FES = 10000 * D; % �����������
gen_max = Max_FES/NP;  % �������� 
border=100;     %���½����ֵ��һ��Ϊ�Գ������ռ䣩
fhd=str2func('cec17_func');
str = "SPODE";  % ���ڱ���Ա��㷨��־���ַ���

global fbias
%����ֵƫ����%
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
    fprintf("��ʼ����%s��%dά-F%d���� >>>>\n",str,D,k);
    fprintf("----------------------------------\n");
    
for i=1:runNumber
    fprintf("-----%s��%d������-----\n",str,i);
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

fprintf("\nSPODE:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(1,:)),max(s(1,:)),median(s(1,:)),mean(s(1,:)),std(s(1,:)));

%����OMLDE��Best,Worst,Median,Mean,Std��excel
%  save_data(k,D,s,str); 
end
%% ����ODE
clear;
clc;
close all; 
addpath(genpath(pwd));  %��һ������matlab����·���ϵ��ļ�
runNumber=10; %���д���
D=30;         %ά��
NP=100;       %NPΪ��Ⱥ��ģ
F=0.5;        %ͻ������
CR=0.9;       %�������
Max_FES = 10000 * D; % �����������
gen_max = Max_FES/NP;  % �������� 
border=100;     %���½����ֵ��һ��Ϊ�Գ������ռ䣩
fhd=str2func('cec17_func');
str = "ODE";  % ���ڱ���Ա��㷨��־���ַ���

global fbias
%����ֵƫ����%
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
    fprintf("��ʼ����%s��%dά-F%d���� >>>>\n",str,D,k);
    fprintf("----------------------------------\n");
    
for i=1:runNumber
    fprintf("-----%s��%d������-----\n",str,i);
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

fprintf("\nODE:\nBestΪ:%d\nWorstΪ:%d\nMedianΪ:%d\nMeanΪ:%d\nStdΪ:%d\n",min(s(1,:)),max(s(1,:)),median(s(1,:)),mean(s(1,:)),std(s(1,:)));

%����OMLDE��Best,Worst,Median,Mean,Std��excel
%  save_data(k,D,s,str); 
end