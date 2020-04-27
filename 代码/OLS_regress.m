function [B,resid,siga2,bint,cov_matrix,t,t_p] = OLS_regress(Y,X)

%�������:
%Y - �����ͱ���
%X - ���ͱ���

%�������:
% B - �����Ʋ���beta
% resid - �в�
% siga2 - �в��
% bint - 95%������������
% cov_matrix - Э�������

% 1.��OLS������B
B = inv(X'*X)*X'*Y;

% 2.����Э�������
resid = Y - X*B;  %�в�
[n,K] = size(X);  
siga2 = sum(resid.^2)/(n-K);
cov_matrix = siga2*inv(X'*X);

% 3.t����
t = B./sqrt(diag(cov_matrix));
t_p = 2*(1-tcdf(abs(t),n-K));

% 4.����95%��������
alpha = 0.05;   %���Ŷ�
nu = max(0,n-K);  %���ɶ�
tval = tinv(1-alpha/2,nu);
se = sqrt(diag(cov_matrix));
bint = [B-tval*se, B+tval*se];



