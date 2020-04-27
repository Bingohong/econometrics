function loss_sum = qreg_object(beta,y,x,q)
% beta - �����Ʋ���,������
% y - �����ͱ���,������
% x - ���ͱ���,������
% q - ��λ��
[T,~] = size(x); 
y_hat = zeros(T,1);
for i = 1:T
    y_hat(i) = x(i,:)*beta;
end
resid = y-y_hat;

loss = zeros(T,1);
for i=1:T
    if resid(i)>0
        loss(i) = q*resid(i);
    else
        loss(i) = (q-1)*resid(i);
    end
end
loss_sum = sum(loss);

% % ���Ʒ�λ�����̣�f1 = c + e ,��λ��Ϊ0.4
% % 1.��������
% data = xlsread('C:\Users\Administrator\Desktop\hourse.xlsx');
% f1 = data(:,2); f2 = data(:,3); e = data(:,6); q = 0.4;
%  
% % 2.��ʼ�����趨
% maxsize         = 2000;         % ���ɾ���������ĸ���(���ڸ���ֵ)
% REP			    = 100;          % ����ɢ��������е����Ĵ���
% nInitialVectors    = [maxsize, 2];    % �������������
% MaxFunEvals    = 5000;         % �������۵�������
% MaxIter         = 5000;         % ���������������
% options = optimset('LargeScale', 'off','HessUpdate', 'dfp','MaxFunEvals', ...
% MaxFunEvals, 'display', 'on', 'MaxIter', MaxIter, 'TolFun', 1e-6, 'TolX', 1e-6,'TolCon',10^-12);
% 
% % 3.ʹ��OLS�ع�������ų�ֵ
% beta = regress(f1,[ones(length(f1),1),e]);
% 
% % 4.����������Ź���ֵBeta
% [Beta, fval, exitflag] = fminsearch(' qreg_object ', beta ,options,f1,[ones(length(f1),1),e],q);
% for it = 1:REP
% if exitflag == 1, break, end
% [Beta, fval, exitflag] = fminsearch(' qreg_object ', beta ,options,f1,[ones(length(f1),1),e],q);
% end
% if exitflag~=1, warning('���棺������û�����'), end