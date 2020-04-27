% 1.��������
data = xlsread('C:\Users\Administrator\Desktop\���г�������');
rst   = data(:,2);   %WTI�г��ֻ�ԭʼ������
mldate   = x2mdate(data(:,1)); % ��������

% 2.�����������������
epsilon=rst-mean(rst);   %�ֻ�ԭʼ�����ʲв�
T=length(epsilon);

% 3.����GARCH(1,1)ģ��
options=optimset('fminunc');
 
options=optimset(options,'TolFun',1e-005); 
 
options=optimset(options,'TolX',1e-005); 
 
options=optimset(options,'Display','off'); 
 
options=optimset(options,'Diagnostics','off'); 
 
options=optimset(options,'LargeScale','off');
 
options=optimset(options,'MaxFunEvals',2000);
 
[garch11p,garch11LL,garch11ht,garch11vcvrobust]=tarch(epsilon,1,0,1,'SKEWT',[],[],options);
[garch11text,garch11AIC,garch11BIC]=tarch_display(garch11p,garch11LL,garch11vcvrobust,epsilon,1,2,1);

% 4.����в�ֲ�ѡ���Ƿ����(��������AICֵ��QQͼ��KS���顢��׼�в���ARCH����)
% 4.1 KS����
ehat = epsilon./sqrt(garch11ht);   %��׼�в�
u = skewtcdf(ehat,garch11p(4,1),garch11p(5,1));     %���ʻ��ֱ任
v = unifrnd(0,1,T,1);
[H, pValue, KSstatistic] = kstest2(u,v);

% 4.2 QQͼ
fig=figure;
set(fig,'Position',[100 100 550 500],'Color',[1 1 1])
y = unifinv((1:T)'/(T+1),0,1);
LB = 0;
UB=1;
h=plot([LB UB],[LB UB],sort(u),y);
set(h(1),'LineStyle','--','Color',[1 0 0],'LineWidth',1)
set(h(2),'LineStyle','none','Marker','o','MarkerSize',1,'Color',[0 0 1])
axis tight
set(gca,'FontSize',16)
a = 'WTI';
title(['' a 'ԭ���ֻ�������Q-Qͼ'],'FontSize',16)
xlabel('U(0��1)')
ylabel('�в����ֵ');

% 4.3 ��׼�в���ARCH����,pֵ��˵���޷��ܾ�ԭ����(�����������췽��)
[h,p,stat,cValue] = archtest(ehat,'lags',10);
if p<=0.01
    arch{1,1} = ['' num2str(stat,'%3.3f') '***'];
    elseif p<=0.05
        arch{1,1} = ['' num2str(stat,'%3.3f') '**'];
    elseif p<=0.1
        arch{1,1} = ['' num2str(stat,'%3.3f') '*'];
    else arch{1,1} = ['' num2str(stat,'%3.3f') ''];
end
