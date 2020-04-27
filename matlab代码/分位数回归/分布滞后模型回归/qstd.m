function [Y_Yhat,VARbeta,coefficient_interval,stao,cT,Hn,wald]=qstd(Beta,Y,X,p,q,Q,select)
% **************************************** help *********************************************
% ˵�����£�
% ʵ�ֶԷ�λ���ع�ķ������,wald�������ļ���
% �����Ʒ���Ϊ��y=c(1)+c(2)*y(-1)....+c(3)*x(-1)
% ע�⣺Ĭ�Ͼ����нؾ���
% *****************************************************************************************
% ���������
% BetaΪ���Ƴ��Ĳ���ֵ
% Y�������ͱ���
% X������ͱ���
% p�������ͱ������ͺ����������ȡ0���������ͱ�������y���ͺ��
% q�������ͱ������ͺ����������ȡ0���������ͱ���ΪX
% ����p=0,q=0
% �����Ʒ���Ϊy=c(1)+c(2)*x
% QΪ�����Ʒ�λ��
% select��ʾWald���㷽ʽ��ͬ��1Ϊ�ٶ��в������idd��2Ϊ���ܶȹ���
% *****************************************************************************************
% ���������
% Y_YhatΪ�в�
% VARbetaΪ����-Э�������
% coefficient_intervalΪ95%��������
% staoΪ�ܶȺ���Sparsity
% cTΪ�˹��ƴ���cT
% HnΪBandwidth method: Hall-Sheather,����bw
% waldΪwaldͳ����
% ***************************************** help ********************************************
if q==0
     qq=1;
 else qq=q;
end
%ȷ��Y,X����,����ʽΪ[C,Y(-p),X(-q)]�Լ��в�
a=qregobjectiveFunction(Beta,Y,X,p,q,Q,2);
b=size(a,2);
ser=a(:,1:b-1);
Y_Yhat=a(:,b);
%�����Hn
afa=0.05;
T=length(Y_Yhat);
fen=(T^(-1/3));
fen1=(norminv(1-afa/2))^(2/3);
zafa=(normpdf(norminv(Q)))^2;
fen2=((1.5*zafa)/(2*(norminv(Q))^2+1))^(1/3);
Hn=fen*fen1*fen2;
D=zeros(T,p+qq+1);
D(:,1)=ones(T,1);
D(:,2:b-1)=ser(:,2:b-1);

s=std(Y_Yhat);
IQR=iqr(Y_Yhat);
k=min(s,IQR/1.34);
cT=k*(norminv(Q+Hn)-norminv(Q-Hn));
a=(1/(T*cT));
u=Y_Yhat/cT;
b=(3/4)*(1-u.^2);
for i=1:T
   if b(i,1)<0
      b(i,1)=0;
   else b(i,1)=b(i,1);
end 
end
stao=1/sum(a*b);
H2=zeros(p+q+1);
for i=1:T
    DD=D(i,:)'*D(i,:);
H=a*b(i,1)*DD+H2;
H2=H;
end
J=(D'*D)/T;
V=Q*(1-Q)*inv(H)*J*inv(H);
VARbeta=V/T;
%��������
stderr=sqrt(diag(VARbeta));
for i=1:(1+p+qq)
    coefficient_interval(i,1)=Beta(i,1)-stderr(i,1)*tinv(0.95,T-(1+p+qq));
    coefficient_interval(i,2)=Beta(i,1)+stderr(i,1)*tinv(0.95,T-(1+p+qq));
    coefficient_interval(i,3)=Beta(i,1)-stderr(i,1)*tinv(0.975,T-(1+p+qq));
    coefficient_interval(i,4)=Beta(i,1)+stderr(i,1)*tinv(0.975,T-(1+p+qq));
    coefficient_interval(i,5)=Beta(i,1)-stderr(i,1)*tinv(0.995,T-(1+p+qq));
    coefficient_interval(i,6)=Beta(i,1)+stderr(i,1)*tinv(0.995,T-(1+p+qq));
end
%wald����
R=zeros(q,p+q+1);
if select==1    %(Ĭ����������������)
	stao2=stao^2;
	for i=1:q
	R(i,p+i+1)=1;
	end
	VV=R*inv(J)*R';
	zi=T*(R*Beta)'*inv(VV)*(R*Beta)*(1/stao2);
	wald=zi/(Q*(1-Q));end

if select==2   %EVIEWSĬ����Э������󷽷�(�˹���)
for i=1:q
R(i,p+i+1)=1;
end
wald=(R*Beta)'*inv(R*VARbeta*R')*(R*Beta);
end