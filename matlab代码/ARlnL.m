function lnL = ARlnL(Beta,Y)
%Beta(1) = Beta0 ;Beta(2) = Beta1 ;Beta(3) = siga ;
T = length(Y);
lnL1 = -0.5*log(2*pi)-0.5*log(Beta(3)^2/(1-Beta(2)^2))-(Y(1)-(Beta(1)/(1-Beta(2))))^2/(2*Beta(3)^2/(1-Beta(2)^2))-0.5*log(2*pi)*(T-1)-0.5*(T-1)*log(Beta(3)^2);
for i = 2:T
    lnL2(i) = (Y(i)- Beta(1)-Beta(2)*Y(i-1))^2;
end
lnL = lnL1-0.5*sum(lnL2)/Beta(3)^2;
lnL = -lnL;

% %��������
% data = xlsread('C:\Users\Administrator\Desktop\hourse.xlsx');
% f1 = data(:,2); f2 = data(:,3); e = data(:,6);
% 
% % 2.��ʼ�����趨
% maxsize           = 2000;          % ���ɾ���������ĸ���(���ڸ���ֵ)
% REP			    = 100;           % ����ɢ��������е����Ĵ���
% nInitialVectors   = [maxsize, 3];  % �������������
% MaxFunEvals       = 5000;          % �������۵�������
% MaxIter           = 5000;          % ���������������
% options = optimset('LargeScale', 'off','HessUpdate', 'dfp','MaxFunEvals', ...
% MaxFunEvals, 'display', 'on', 'MaxIter', MaxIter, 'TolFun', 1e-6, 'TolX', 1e-6,'TolCon',10^-12);
% 
% % 3.Ѱ�����ų�ֵ
% initialTargetVectors = unifrnd(-1,1, nInitialVectors);
% RQfval = zeros(nInitialVectors(1), 1);
% for i = 1:nInitialVectors(1)
%     RQfval(i) = ARlnL (initialTargetVectors(i,:), f1);
% end
% Results          = [RQfval, initialTargetVectors];
% SortedResults    = sortrows(Results,1);
% BestInitialCond  = SortedResults(1,2: size(Results,2));    
% 
% % 4.����������Ź���ֵBeta
% [Beta, fval exitflag] = fminsearch(' ARlnL ', BestInitialCond,options,f1);
% for it = 1:REP
% if exitflag == 1, break, end
% [Beta, fval exitflag] = fminsearch(' ARlnL ', BestInitialCond,options,f1);
% end
% if exitflag~=1, warning('���棺������û�����'), end

