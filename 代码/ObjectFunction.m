% 1.��дĿ�꺯��
function z = ObjectFunction(Beta)
	z = (Beta(1)+1)^2 + (Beta(2)-1)^2;

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
% initialTargetVectors = unifrnd(-5,5, nInitialVectors);
% RQfval = zeros(nInitialVectors(1), 1);
% for i = 1:nInitialVectors(1)
%     RQfval(i) = ObjectFunction(initialTargetVectors(i,:));
% end
% Results          = [RQfval, initialTargetVectors];
% SortedResults    = sortrows(Results,1);
% BestInitialCond  = SortedResults(1,2: size(Results,2));    
% 
% % 4.����������Ź���ֵBeta
% [Beta, fval exitflag] = fminsearch(' ObjectFunction ', BestInitialCond);
% for it = 1:REP
% if exitflag == 1, break, end
% [Beta, fval exitflag] = fminsearch(' ObjectFunction ', BestInitialCond);
% end
% if exitflag~=1, warning('���棺������û�����'), end

