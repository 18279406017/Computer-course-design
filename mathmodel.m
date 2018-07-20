%���������
clear;
% �������
syms x;
% ����ϵͳ��̬����ָ��ĳ������Լ�����ʱ����ȡ����ϵ������ز���
% �������ϵ��kese
ee=eval(solve('-x*3.14/(sqrt(1-x*x))-log(0.05)=0','x'));
% ���wn
wn=eval(solve('pi/(x*sqrt(1-ee*ee))-0.5=0','x'));
% ������ɢ�Ĳ��ʱ��
dt = 0.0001
% ����Ƶ��50HZ
f = 50
% ���ý��ٶ�w
w = 0
% ��ϵͳ�����ѧģ������
Aforward = [-110.2424 0 200.9966 0;
    0 -110.2424 0 200.9966;
    107.1489 0 -206.7995 0;
    0 107.1489 0 -206.7995]

Anon = [0 17.0724 0 17.5653;
        -17.0724 0 -17.5653 0;
        0 -17.5653 0 -18.0742;
        17.5653 0 18.0742 0]
A = Aforward + Anon*w
B = [253.4307 0;
    0 253.4307;
    -264.3194 0;
    0 -246.3194]
C = [1 0 0 0;
    0 1 0 0]
D = [0 0;
        0 0];
% ���ݳ������͵���ʱ������������ز��������伫��
% �������һ������ʵ��
r1real = -ee*wn;
% �������һ�������鲿
r1fail = wn*sqrt(1-ee*ee);
% �����һ��һ������ʵ��
r2real = -ee*wn;
% �����һ��һ������ʵ�鲿
r2fail = -wn*sqrt(1-ee*ee);
% �����ܿ��ܹ����Լ���żԭ�������״̬��������
Azhuanzhi = A';
Czhuanzhi = C';
p = [-220 -200 6*(r1real+r1fail*i) 6*(r2real+r2fail*i)]
k = place(A,B,p);
Gzhuanzhi = place(Azhuanzhi,Czhuanzhi,p')
G = Gzhuanzhi'
% ��ϵͳ������ɢ��
[AL BL] = c2d(A,B,dt )
[ALG BLG] = c2d(A-G*C,[B-G*D G],dt )
% ����������ͬ�ĳ�ʼ״̬
X1 = [0;
     0;
     0;
     0];
 X2 = [0.1;
     0.1;
     0.1;
     0.1];
%  ����һЩ���飬�洢��ر���
Vx_all = [];
Vy_all = [];
Ids1_all = [];
Iqs1_all = [];
Idr1_all = [];
Iqr1_all = [];
Ids2_all = [];
Iqs2_all = [];
Idr2_all = [];
Iqr2_all = [];
Idserror_all = [];
Iqserror_all = [];
Idrerror_all = [];
Iqrerror_all = [];
t_all = [];
for i = 1:1:2000
    t = i*dt;
    Vx = 1*sin(2*pi*f*t);
    Vy = 1*sin(2*pi*f*(t+0.25*pi));
    U = [Vx;
         Vy];
    X1_1 = AL*X1 + BL*U;
    y = C*X1;
    X1 = X1_1;
    
    ULG = [Vx;
           Vy;
           y(1,1);
           y(2,1)]
    X2_1 = ALG*X2 + BLG*ULG ;
    X2 = X2_1;

    Ids1_all(i) = X1_1(1,1);
    Iqs1_all(i) = X1_1(2,1);
    Idr1_all(i) = X1_1(3,1);
    Iqr1_all(i) = X1_1(4,1);
    Ids2_all(i) = X2_1(1,1);
    Iqs2_all(i) = X2_1(2,1);
    Idr2_all(i) = X2_1(3,1);
    Iqr2_all(i) = X2_1(4,1);
    Idserror_all(i) =  X1_1(1,1)-X2_1(1,1);
    Iqserror_all(i) = X1_1(2,1)-X2_1(2,1);
    Idrerror_all(i) = X1_1(3,1)-X2_1(3,1);
    Iqrerror_all(i) = X1_1(4,1)-X2_1(4,1);
    Vx_all(i) = Vx;
    Vy_all(i) = Vy;
    t_all(i) = t;
end
subplot(3,3,1),plot(t_all,Vx_all, t_all,Vy_all)
title('���������ź�Vx;���������ź�Vy')
subplot(3,3,2),plot(t_all,Ids1_all, t_all,Ids2_all)
title('���״̬Ids')
subplot(3,3,3),plot(t_all,Iqs1_all, t_all,Iqs2_all)
title('���״̬Iqs')
subplot(3,3,4),plot(t_all,Idr1_all, t_all,Idr2_all)
title('���״̬Idr')
subplot(3,3,5),plot(t_all,Iqr1_all, t_all,Iqr2_all)
title('���״̬Iqr')
subplot(3,3,6),plot(t_all,Idserror_all)
title('������Idserror')
subplot(3,3,7),plot(t_all,Iqserror_all)
title('������Iqserror')
subplot(3,3,8),plot(t_all,Idrerror_all)
title('������Idrerror')
subplot(3,3,9),plot(t_all,Iqrerror_all)
title('������Iqrerror')

