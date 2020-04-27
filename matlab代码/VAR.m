function [beta,resid,cov_mat,AIC] = VAR(Y,X,p)
% ע��:ֻ��ʵ������������VARģ�ͣ�˼�����ʵ�������������VAR
% p - �ͺ����
% AIC - ��Ϣ׼��

% 1.����ϵ��
[ADLy,ADLx] = ADLxx(Y,X,p,p);
[beta1,~,resid1] = regress(ADLy,ADLx);

[ADLy,ADLx] = ADLxx(X,Y,p,p);
[beta2,~,resid2] = regress(ADLy,ADLx);

beta = [beta1';beta2'];
resid = [resid1,resid2];

% 2.����AICֵ(eviews�������ɶ�֮���)
T = length(ADLy);
cov_mat = resid'*resid/(T-3);
AIC = log(det(cov_mat))+2*(2*p+1)*2/T;

% % 1.��������
% data = xlsread('C:\Users\Administrator\Desktop\hourse.xlsx');
% f1 = data(:,2); f2 = data(:,3); e = data(:,6);
% 
% % 2.����VARģ��
% [beta,resid,AIC] = VAR(f1,e,2);