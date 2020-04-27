function [Sup_wald,walds,AIC]=qwalds(data,AICS,select,pattern)

% % % % % % % % % % % % % % % % % % % % % 
% ������
% qwalds��Ϊ�˵ó���λ��������������飬������г���λ��SUP-Waldͳ�����ĺ���

% ʵ����
% [wald,AIC_zhong]=qwalds(data,1,1,1)
% [wald,AIC_zhong]=qwalds(data,AICS,1,1)

% ���������
% Sup_waldΪ���г���λ���䣬�ͺ������waldֵ����
% walds�Ǹ��г�waldֵ���ܣ�Ĭ�ϱ���3λ��Ч����
% AIC�Ǹ��г�AIC׼��ȷ�����ͺ����

% �������:
% data��ʾ���ݼ�����һ��Ϊ���ͱ���������Ϊ�����ͱ�����X1,Y1,Y2....);�������һ��Ϊ�����ͱ�����X1,X2,X3.....Y1);
% AICS��û�еó�����λ���������ͺ������AICֵ����ȡֵΪ1���Զ��������Ž�������Ȼ����Ҫһ��ʱ�䣩����������˾���;
% select��ʾWald���㷽ʽ��ͬ��1Ϊ�ٶ��в������idd��2Ϊ���ܶȹ���

% pattern����ѭ��ģʽ,
% 1Ϊ�о���һ���ضԸ��г�Ӱ�죬���緿�۶Թ�Ʊ�������г������
% 2��Ϊ�о��໥Ӱ�죬���緿�����Ʊ�������г����໥�����
% 3��ΪĳЩ���ضԵ����г���Ӱ�죬����������Ի����г��ĳ����
% ���磺data=[X,Y1,Y2,Y3],pattern=1 ��Ϊ X��Y1�ع飻X��Y2�ع飻X��Y3�ع飻��Y1=c1+c2*X)
% pattern=2 ��Ϊ X��Y1�ع飻X��Y2�ع飻X��Y3�ع飻Y1��X�ع飻Y1��Y2�ع�;Y1��Y3�ع�;.........
% pattern=3 data=[X1,X2,X3,Y1];X1��Y1�ع飬X2��Y1�ع飻X3��Y1�ع飻
% % % % % % % % % % % % % % % % % % % % % 
tic
lim=200;   %����
lim=lim*60;
AIC={};Sup_wald={};walds={};
T=size(data,2);
if pattern==1
    X=data(:,1);
    for i=2:T
        Y=data(:,i);
        if AICS==1
            [wald,AIC_zhong]=qwald(X,Y,1,select);
        else
        [wald,AIC_zhong]=qwald(X,Y,AICS{i-1,1},select);end
        AIC{i-1,1}=AIC_zhong;
        Sup_wald{i-1,1}=wald;
        walds(:,i-1)=wald(:,5);
        disp('***********************************************')
        disp(['��' num2str(i-1) '������ɣ���' num2str(T-1) '��'])
        disp('***********************************************')
        time_toc = toc;
        if time_toc > lim 
            disp(['����ʱ' num2str(time_toc/60,'%3.5g') '����'])
            pause
            tic
        end
    end
elseif pattern==2
    n=0;nn=nchoosek(T,2)*2;
    for i=1:T
        for j=1:T
            if i~=j
                n=n+1;
                X=data(:,i);Y=data(:,j);
                if AICS==1
                    [wald,AIC_zhong]=qwald(X,Y,1,select);
                else
                    [wald,AIC_zhong]=qwald(X,Y,AICS{n,1},select);end
                AIC{n,1}=AIC_zhong;
                Sup_wald{n,1}=wald;
                walds(:,n)=wald(:,5);
                disp('***********************************************')
                disp(['��' num2str(n) '������ɣ���' num2str(nn) '��'])
                disp('***********************************************')
                time_toc = toc;
                if time_toc > lim 
                    disp(['����ʱ' num2str(time_toc/60,'%3.5g') '����'])
                    pause
                    tic
                end
            end
        end
    end
elseif pattern==3
    Y=data(:,T);
    for i=1:T-1
        X=data(:,i);
        if AICS==1
            [wald,AIC_zhong]=qwald(X,Y,1,select);
        else
            [wald,AIC_zhong]=qwald(X,Y,AICS{i,1},select);end
        AIC{i,1}=AIC_zhong;
        Sup_wald{i,1}=wald;
        walds(:,i)=wald(:,5);
        disp('***********************************************')
        disp(['��' num2str(i) '������ɣ���' num2str(T-1) '��'])
        disp('***********************************************')
        time_toc = toc;
        if time_toc > lim 
            disp(['����ʱ' num2str(time_toc/60,'%3.5g') '����'])
            pause
            tic
        end
    end
end
                
xlswrite('C:\Users\Administrator\Desktop\qwalds1.xlsx',walds)
