function [ADLy,ADLx] = ADLxx(Y,X,p,q)

%�����Ʒ��̣�y = c + y(-1) +....+y(-p) + x(-1) + ... + x(-q)
% ��ȡ�Իع�ֲ��ͺ�ģ�͵Ĺ�������
%  X   - ���ͱ�����������
%  Y   - �����ͱ�����������
%  p   - ADLģ��Y���ͺ����,����
%  q   - ADLģ��X���ͺ����,����

T = length(Y);
N = max(p,q)+1;

ADLy = Y(N:T);
c = ones(length(ADLy),1);  %������
ADLx = zeros(length(ADLy),1+p+q);
ADLx(:,1) = c;
for i=1:p, ADLx(:,1+i) = Y(N-i:T-i);end
for i=1:q, ADLx(:,1+p+i) = X(N-i:T-i);end

% % 1.��������
% data = xlsread('C:\Users\Administrator\Desktop\hourse.xlsx');
% f1 = data(:,2); f2 = data(:,3); e = data(:,6);
% 
% % 2.����ADLģ��f1 = c + f1(-1) + f1(-2) + e(-1)
% [ADLy,ADLx] = ADLxx(f1,e,2,1);
% beta = regress(ADLy,ADLx);