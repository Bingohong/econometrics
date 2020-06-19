function [wald,AIC_zhong]=qwald(Y,X,AIC_zhong,select)

% % % % % % % % % % % % % % % % % % % % % 
% ������
% qwald��Ϊ�˵ó���λ��������������飬�������λ��SUP-Waldͳ�����ĺ���
% Sup-waldĬ�ϱ���3λ��Ч����
% ����waldΪSUP-Wald����AIC_zhongΪ����λ���������ͺ������AICֵ
% XΪ�Ա�����YΪ�������
% AIC_zhong��û�еó�����λ���������ͺ������AICֵ����ȡֵΪ1���Զ��������Ž�������Ȼ����Ҫһ��ʱ�䣩����������˾���;
% select��ʾWald���㷽ʽ��ͬ��1Ϊ�ٶ��в������idd��2Ϊ���ܶȹ���
% ʵ����
% [wald,AIC_zhong]=qwald(X,Y,1,1)
% [wald,AIC_zhong]=qwald(X,Y,AIC_zhong,1)
% % % % % % % % % % % % % % % % % % % % % 

if AIC_zhong==1
	AIC_zhong=qre_lag(Y,X,select);
end
%�������λ��Waldͳ����
Q2=linspace(0.1,0.9,1000);
wald_text(1,:)=Q2;page=0;
for i=1:1000
    page=page+1;
	%ѡȡ�����ͺ����
	a=AIC_zhong(:,1);
	aa=find(a<=Q2(i));
	b=max(aa);
	if b==17
		b=16;
	end
	p=AIC_zhong(b,3);
	q=AIC_zhong(b,4);
	[BetaHat,ser,Y_Yhat,fval,VARbeta,coefficient_interval,stao,cT,Hn,stderr,tstats,pvals,wald,exitflag] = qar_estim(Y,X,p,q,Q2(i),select);
	wald_text(2,i)=p;
	wald_text(3,i)=q;
	wald_text(4,i)=wald;
	disp(['���ڽ���Sup_wald���㣬��λ��Ϊ' num2str(Q2(i)) ',waldֵΪ' num2str(wald) ',�ͺ����Ϊ[' num2str(p) ',' num2str(q) '],����Ϊ(' num2str(page) '/1000),'])
end
%%%��������SUP-Waldͳ����
WALD(1,:)=linspace(0.1,0.9,17);
c=1;
for i=2:17
    b=find(Q2<=WALD(1,i));
    a=max(b);
    WALD(2,i-1)=max(wald_text(4,c:a));
    c=a+1;
end
WALD2=WALD';

%����SUP-Waldͳ�����Ƿ�����
star=supwaldstar(AIC_zhong,WALD2(1:16,2));
a='��λ��';a1='0.1-0.15';a2='0.15-0.2';a3='0.2-0.25';a4='0.25-0.3';a5='0.3-0.35';a6='0.35-0.4';a7='0.4-0.45';a8='0.45-0.5';a9='0.5-0.55';a10='0.55-0.6';
a11='0.6-0.65';a12='0.65-0.7';a13='0.7-0.75';a14='0.75-0.8';a15='0.8-0.85';a16='0.85-0.9';
wald=[];
wald{1,1}=a;wald{2,1}=a1;wald{3,1}=a2;wald{4,1}=a3;wald{5,1}=a4;wald{6,1}=a5;wald{7,1}=a6;wald{8,1}=a7;wald{9,1}=a8;wald{10,1}=a9;wald{11,1}=a10;
wald{12,1}=a11;wald{13,1}=a12;wald{14,1}=a13;wald{15,1}=a14;wald{16,1}=a15;wald{17,1}=a16;
wald{1,2}=['p'];wald{1,3}=['q'];wald{1,4}=['AIC'];wald{1,5}=['sup-wald'];

point=3;%������λС��
for i=1:16
%     wald{i+1,2}=num2str(AIC_zhong(i,3));
%     wald{i+1,3}=num2str(AIC_zhong(i,4));
%     wald{i+1,4}=num2str(AIC_zhong(i,5),'%4.4f');
    wald{i+1,2}=AIC_zhong(i,3);
    wald{i+1,3}=AIC_zhong(i,4);
    wald{i+1,4}=AIC_zhong(i,5);
    l=num2str(WALD2(i,2),['%3.' num2str(point) 'g']);
    if star(i,2)==3
    wald{i+1,5}=['' l '***\[' num2str(AIC_zhong(i,4)) ']'];
    elseif star(i,2)==2
        wald{i+1,5}=['' l '**\[' num2str(AIC_zhong(i,4)) ']'];
    elseif star(i,2)==1
        wald{i+1,5}=['' l '*\[' num2str(AIC_zhong(i,4)) ']'];
    else; wald{i+1,5}=['' l '\[' num2str(AIC_zhong(i,4)) ']'];
    end
end
for i=1:17
    disp(wald{i,5})
end
%xlswrite('C:\Users\Administrator\Desktop\qwald.xlsx',wald)


% out1=[];out2=[];out3=[];out4=[];out5=[];
% for i=1:17
% out1=strvcat(out1,wald{i,1});
% out2=strvcat(out2,wald{i,2});
% out3=strvcat(out3,wald{i,3});
% out4=strvcat(out4,wald{i,4});
% out5=strvcat(out5,wald{i,5});
% end
% out={out1,out2,out3,out4,out5};


