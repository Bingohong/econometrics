function [BetaHat,ser,Y_Yhat,fval,VARbeta,coefficient_interval,stao,cT,Hn,stderr,tstats,pvals,wald,exitflag] = qar_estim(Y,X,p,q,Q,select)

% **************************************** help *********************************************
% ˵�����£�
% �˺���Ϊ��λ���ֲ��ͺ�ģ�͹���
% �����Ʒ���Ϊ��y=c(1)+c(2)*y(-1)....+c(3)*x(-1)
% ע�⣺Ĭ�Ͼ����нؾ���
% *****************************************************************************************
% ���������
% Y�������ͱ���
% X������ͱ���
% p�������ͱ������ͺ����������ȡ0���������ͱ�������y���ͺ��
% q�������ͱ������ͺ����������ȡ0���������ͱ���ΪX
% ����p=0,q=0
% �����Ʒ���Ϊy=c(1)+c(2)*x
% select��ʾWald���㷽ʽ��ͬ��1Ϊ�ٶ��в������idd��2Ϊ���ܶȹ���
% *****************************************************************************************
% ���������
% BetaHatΪ���Ʋ�����˳��Ϊ[C,Y(-p),X(-q)]
% serΪ��ʵ��������(������������)������ʽΪ[Y,Y(-p),X(-q)]
% Y_YhatΪ�в�
% fvalΪ��λ����Ȩ�в��
% VARbetaΪ����-Э�������
% coefficient_intervalΪ95%��������
% staoΪ�ܶȺ���Sparsity
% cTΪ�˹��ƴ���cT
% HnΪBandwidth method: Hall-Sheather,����bw
% stderr��ʾ��׼��
% tstats��ʾt����
% pvals��ʾt����ĸ���ֵ
% wald��ʾwaldͳ����
% exitflag = 1��ʾ����,�����ʾ������û�����
% ***************************************** help ********************************************

% 1.���Ʋ����趨
 maxsize         = 2000;         % ���ɾ���������ĸ���(���ڸ���ֵ)
 REP			 = 100;          % ����ɢ��������е����Ĵ���
 nInitialVectors = [maxsize, 1]; % �������������
 MaxFunEvals     = 5000;         % �������۵�������
 MaxIter         = 5000;         % ���������������
% options = optimset('MaxFunEvals',MaxFunEvals, 'display', 'on', 'MaxIter', MaxIter,'TolCon',10^-12,'TolFun',10^-6,'TolX',10^-6);
% options = optimset('Display','iter','TolCon',10^-12,'TolFun',10^-4,'TolX',10^-6);
 options = optimset('LargeScale', 'off','HessUpdate', 'dfp','MaxFunEvals', ...
                      MaxFunEvals, 'display', 'on', 'MaxIter', MaxIter, 'TolFun', 1e-6, 'TolX', 1e-6,'TolCon',10^-12);
% warning('off', 'verbose') 
% *****************************************************************************************

% 2.�õ���ʵ��������ser(������������),����ʽΪ[Y,Y(-p),X(-q)]
 C=Y((max(p,q)+1):length(Y),1);
 if p==0,Y_p=[];else
 for i=1:p,Y_p(:,i)=Y((max(p,q)-(i-1)):(length(Y)-i),1);end;end
 if q==0,X_q=[X];else
 for i=1:q,X_q(:,i)=X((max(p,q)-(i-1)):(length(X)-i),1);end;end
 ser=[C,Y_p,X_q];
 if q==0,qq=1;else qq=q;end
 ser=[C,Y_p,X_q];
 c=ones(length(C),1);  %������
 x=[c,Y_p,X_q];        %�����ͱ�������
% *****************************************************************************************

% 3.����OLS�ع�ѡ�����ŵĳ�ֵ
 beta_ols=regress(C,x);Q_range=abs(Q-0.5)+0.1;
 initialTargetVectors(:,1) =beta_ols(1)+ unifrnd(-Q_range, Q_range, nInitialVectors);
 initialTargetVectors(:,2:p+qq+1)=beta_ols(2:p+qq+1)'.*ones(maxsize,p+qq)+ unifrnd(-Q_range, Q_range, [maxsize,p+qq]);
 RQfval = zeros(nInitialVectors(1), 1);
 for i = 1:nInitialVectors(1)
    RQfval(i) = qregobjectiveFunction(initialTargetVectors(i,:),Y,X,p,q,Q,1);
 end
 Results          = [RQfval, initialTargetVectors];
 SortedResults    = sortrows(Results,1);
 BestInitialCond  = SortedResults(1,2:p+qq+2);    
 Beta = zeros(size(BestInitialCond)); fval = Beta(:,1); exitflag = Beta(:,1);
% *****************************************************************************************

% 4.���в������Ƶõ� BetaHat
 for i = 1:size(BestInitialCond,1)
    [Beta(i,:), fval(i,1), exitflag(i,1)] = fminsearch('qregobjectiveFunction', BestInitialCond(i,:), ...
        options,Y,X,p,q,Q,1);
    for it = 1:REP
        if exitflag(i,1) == 1, break, end
        [Beta(i,:), fval(i,1), exitflag(i,1)] = fminsearch('qregobjectiveFunction', Beta(i,:), ...
            options, Y,X,p,q,Q,1);
        if exitflag(i,1) == 1, break, end
    end
 end
 BetaHat = Beta';
 if exitflag~=1, disp('���棺������û�����'), end
% *****************************************************************************************

% 5.����в�,����-Э�������,t����,��׼��Ȳ���ֵ
 [Y_Yhat,VARbeta,coefficient_interval,stao,cT,Hn,wald]=qstd(BetaHat,Y,X,p,qq,Q,select);
 %t����
 stderr=sqrt(diag(VARbeta));
 tstats= BetaHat./stderr;
 pvals=2-2*normcdf(abs(tstats));

