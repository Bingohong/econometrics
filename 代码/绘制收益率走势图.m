clc;clear;
% 1.��������
data = xlsread('C:\Users\Administrator\Desktop\hourse.xlsx');
mldate = x2mdate(data(:,1)); % ��������
f1 = data(:,2);%һ�߳��з���ͬ�»���
f2 = data(:,3);%���߳��з���ͬ�»���
f3 = data(:,4);%���߳��з���ͬ�»���
e = data(:,6);%�������������

% 2.����ԭʼ���ݲ���ͼ
% 2.1 ������ͼ����
fig=figure; 
% 2.2 ���ô���λ�ü���ɫ
set(fig,'Position',[100 100 1100 320],'Color',[1 1 1])
% 2.3 ���Ƶڶ�����ͼ
subplot(1,2,2);f2plot = plot(mldate,e,'-o'); 
% 2.4 �������Ϊ���ڸ�ʽ
datetick('x','keeplimits')
% 2.5 �����ֺŴ�С
set(gca,'FontSize',14) 
% 2.6 ʹͼ�������
axis tight;
% 2.7 ��ӱ���
title('���ʲ���ͼ��������֣�','FontSize',14) 
% 2.8 ����ͼ����ɫ�Լ��������,������2.3��ͬʱ����
set(f2plot,'Color',[0 0 1],'LineWidth',2)
% 2.9 ���������
grid on
set(gca, 'GridLineStyle' ,'--','LineWidth',1,'GridAlpha',1)
% 2.9 ���Ƶ�һ����ͼ
subplot(1,2,1);fplot=plot(mldate,f1,'-rs'); 
hold on   %��֤��������ͼ
plot(mldate,f2,'-^','LineWidth',2,'MarKerFaceColor',[1 .1 1],'Color',[1 .1 0.1]);
plot(mldate,f3,'-p','LineWidth',2,'MarKerFaceColor',[1 0.5 0],'Color',[1 0.5 0]);
datetick('x','keeplimits')
axis tight;
set(gca,'FontSize',14) 
title('���߳��з��۲���ͼ','FontSize',14) 
set(fplot,'Color',[0.196080 .803920 .19608],'LineWidth',2)
grid on
set(gca, 'GridLineStyle' ,'--','LineWidth',1,'GridAlpha',1)
% 2.10 ����ͼ������λ��
set(fig.Children(1),'Position',[0.055,0.1,0.42,0.8])
set(fig.Children(2),'Position',[0.55,0.1,0.42,0.8])
% 2.11 ���ϵ�һ����ͼͼ��
legend('һ�߳���','���߳���','���߳���')







    

