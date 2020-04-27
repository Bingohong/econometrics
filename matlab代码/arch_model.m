function archL = arch_model(beta,Y,X)

%beta(1)=beta0,beta(2)=a0,beta(3)=a1

% 1.��ֵ����
T = length(Y);
resid = Y - beta(1)*X;

% 2.�����
sigam1 = -0.5*(T-1)*log(2*pi)-0.5*log(beta(2)/(1-beta(3)))-0.5*resid(1)^2/(beta(2)/(1-beta(3)));
for i = 2:T
    c1(i-1) = -0.5*log(beta(2)+beta(3)*resid(i-1)^2);
end
for i = 2:T
    c2(i-1) = -0.5*log(resid(i).^2/(beta(2)+beta(3)*resid(i-1)^2));
end
archL = sigam1-0.5*(T-1)*log(2*pi)+sum(c1)+sum(c2);
archL = -archL;

% %��������
% data = xlsread('C:\Users\Administrator\Desktop\hourse.xlsx');
% f1 = data(:,2); f2 = data(:,3); e = data(:,6);
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
% % 3.Ѱ�����ų�ֵ
% initialTargetVectors = [unifrnd(0,10, nInitialVectors),unifrnd(0,1,[maxsize,1])];
% RQfval = zeros(nInitialVectors(1), 1);
% for i = 1:nInitialVectors(1)
%     RQfval(i) = arch_model (initialTargetVectors(i,:), f1,ones(length(f1),1));
% end
% Results          = [RQfval, initialTargetVectors];
% SortedResults    = sortrows(Results,1);
% BestInitialCond  = SortedResults(1,2: size(Results,2));    
% 
% % 4.����������Ź���ֵBeta
% A = [0,0,1] ; b = 1;
% [Beta, fval exitflag] = fmincon(@arch_model,BestInitialCond,A,b,[],[],0,[],[],options,f1,ones(length(f1),1));
% for it = 1:REP
% if exitflag == 1, break, end
% [Beta, fval exitflag] = fmincon(@arch_model,BestInitialCond,A,b,[],[],0,[],[],options,f1,ones(length(f1),1));
% end
% if exitflag~=1, warning('���棺������û�����'), end
