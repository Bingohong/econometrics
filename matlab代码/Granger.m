function [beta,wald,wald_P,AIC,p,q,cov_mat] = Granger(Y,X)

%�����Ʒ��̣�y = c + y(-1) +....+y(-p) + x(-1) + ... + x(-q)
% ��ȡGranger�������waldֵ��pֵ
%  X   - ���ͱ�����������
%  Y   - �����ͱ�����������
%  p   - ADLģ��Y���ͺ����,����
%  q   - ADLģ��X���ͺ����,����
%  wald - waldͳ����
%  wald_P - waldͳ������Pֵ
%  AIC - ��СAICֵ

% 1.������ͺ�׵�AICֵ
AIC = zeros(5,5);
for p = 1:5
    for q = 1:5
        [ADLy,ADLx] = ADLxx(Y,X,p,q);
        [~,~,resid] = regress(ADLy,ADLx);
        T = length(ADLy);
        AIC(p,q) = log(resid'*resid/T)+2*(p+q+1)/T;
    end
end

% 2.�ҵ���С��AICֵ����Ӧ�Ľ���
[p,q] = find(AIC == min(min(AIC)));
[ADLy,ADLx] = ADLxx(Y,X,p,q);
[beta,~,resid] = regress(ADLy,ADLx);
 
% 3.����waldͳ����
R = [zeros(q,1+p),eye(q)];
% 3.1 ����Э�������
T = length(ADLy);
nu = T-(1+p+q);
siga2 = sum(resid.^2)/nu;
cov_mat = siga2*inv(ADLx'*ADLx);
Rcov_mat = siga2*R*inv(ADLx'*ADLx)*R';
% 3.2 ����wald
wald = (R*beta)'*inv(Rcov_mat)*(R*beta);
wald_P = 1 - chi2cdf(wald,q);
