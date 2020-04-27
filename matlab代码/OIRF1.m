function [beta,IR] = OIRF1(Y,X,num,IMP)

% num - ��������

% 1.����VARģ�Ͳ���
[beta,~,cov_mat] = VAR(Y,X,1);

% 2.������Ӧ����
% 2.1 �������ֽ⣬����P����
P = chol(cov_mat, 'lower');
% 2.2 ����IR,s=1��ΪADt,s=k����ΪA^(k)Dt
b = beta(:,2:3);
SHOCK = zeros(2,1);
if IMP == 1
    SHOCK(1,1) = 1; 
elseif IMP == 2
    SHOCK(2,1) = 1; 
end
IR = zeros(num,2);
IR(1,:) = b*(P*SHOCK);
for s=2:num, IR(s,:) = (b*IR(s-1,:)')'; end