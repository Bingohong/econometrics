function AIC_zhong=qre_lag(Y,X,select)

% **************************************** help *********************************************
% ˵��:
% �˺���Ϊ�������λ����������ͺ����,ʹ��AIC׼��
% �����Ʒ���Ϊ��y=c(1)+c(2)*y(-1)....+c(3)*x(-1)
% ע�⣺Ĭ�Ͼ����нؾ���
% *****************************************************************************************
% �������:
% Y�������ͱ���
% X������ͱ���

% �������:
% �������p,q,AICֵ,
% ***************************************** help ********************************************

Q2=linspace(0.1,0.9,100);
for i=1:100
    Q=Q2(i);ii=0;
    for p=1:5
        for q=1:5
            ii = ii+1;
			[BetaHat,ser,Y_Yhat] = qar_estim(Y,X,p,q,Q,select);
			SSE=sum(Y_Yhat);
			n=length(Y)-max(p,q);
			%����AICֵ
			L=-(n/2)*log(2*pi)-(n/2)*log(SSE/n)-n/2;
			k=p+q+1;
			AIC=(2*k-2*L)/n;
			AICju(ii,:)=[Q,p,q,AIC];
			disp(['���ڽ���AIC���㣬��λ��Ϊ' num2str(Q) ',AICֵΪ' num2str(AIC) ',��ǰ�ͺ����[' num2str(p) ',' num2str(q) '],��ǰ����(' num2str(ii) '/25),'])
        end
    end
	a=AICju(:,4);
	aa=find(a==min(a));
	AICjuzhen(i,:)=AICju(aa(1,1),:);
end
AIC_zhong(:,1)=linspace(0.1,0.9,17);
c=1;
for i=2:17
    b=find(Q2<=AIC_zhong(i,1));
    a=max(b);
    bb=AICjuzhen(c:a,4);
    aa=find(bb==min(bb));
    AIC_zhong(i-1,2:5)=AICjuzhen(c-1+aa(1,1),:);
    c=a+1;
end