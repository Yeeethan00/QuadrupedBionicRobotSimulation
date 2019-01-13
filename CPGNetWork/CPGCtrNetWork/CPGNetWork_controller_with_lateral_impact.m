%% CPG���������(������)
close all;
%% ����
%��̬����
length = 0.9;                   %�峤  m
width = 0.5;                    %���  m
l = 0.3;                        %�Ƚڳ���  m
phi = 1;                        %�ؽ�����,1������ʽ,-1����ϥʽ
%�˶���������
acc_roll=2;                     %����Ǽ��ٶ�  m/s^2
%��̬����
v = 1;                          %�˶��ٶ�  m/s
T = 0.4;                        %�˶�����  s 
theta0 = pi/6;                  %���봹ֱ���������棩�нǣ�ԭƽ��λ��
beta=0.5;                       %�������ӣ���ʾ֧������ռ����
omiga_sw=1/(beta*T);            %�ڶ���Ƶ��
h = acc_roll*sin(atan(width/length))/(2*omiga_sw^2*sqrt(1-acc_roll^2/(4*omiga_sw^4)));                       %�ڶ�����˸߶�  m
phiRB=0; phiLB=0.5;             %RB LB��λ, ��betaһͬ������̬
Ak = acos((l*cos(theta0)-h)/l)-theta0;       %�Źؽڷ�ֵ
Ah = asin((beta*v*T)/(4*l/cos(theta0)));     %ϥ�ؽڷ�ֵ
%��������
alpha=100;                      %�����������������޻��õ��ٶ�
miu=Ah^2;                       %������ֵ A=sqrt(miu)
a=50;                           %����omiga��omiga_sw��omiga_st֮��ı仯�ٶ�
%���������
%ǰͥ����
slope_alpha = 0;                %�¶Ƚ�
k2=2.26;                        %ƽ��λ�øı���/������̬��
k1=0.24;                        %������̬��/�¶Ƚ�
delte_theta=phi*k2*k1*slope_alpha;  %ԭƽ��λ�øı���
U = [-(delte_theta/2-k1*slope_alpha); delte_theta;     %�ⲿ������(feed) ��Ӧx1 y1 x2 y2 x3 y3 x4 y4
     -(delte_theta/2-k1*slope_alpha); delte_theta; 
     -(delte_theta/2-k1*slope_alpha); delte_theta; 
     -(delte_theta/2-k1*slope_alpha); delte_theta;
     0; 0; 0; 0; 0; 0; 0; 0];   
%% ��ֵ
t0 = 0; tfinal = 5;             % ��Ӧʱ����Time region of response��
x0 = [0.1; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];% ������ʼֵ��Initial value��
%% ���
% ���Hopf����΢�ַ��̵���ֵ�⣨Numerical solution of differential equation��
[t, x] = ode45(@(t,x)CPGNetWork_hopf_oscillator_with_lateral_impact(t, x, alpha, beta, miu, omiga_sw, a, phiRB, phiLB, U), [t0, tfinal], x0);
%�޸��������yΪϥ�ؽڣ��������xΪ�Źؽ�
for i=2:2:9
    for j=1:size(x,1)
        if x(j,i)<=U(i)
            x(j,i)=-phi*(Ak/Ah)*(x(j,i)-U(i))+U(i);
        else
            x(j,i)=U(i);
        end
    end
end
%% �����������ͼ
subplot(4,1,1);
plot(t,x(:, 1));
xlabel('t/s'); ylabel('LF');
hold on;
plot(t,x(:, 9));
hold on;
plot(t,x(:, 2));

subplot(4,1,2);
plot(t,x(:, 3));
xlabel('t/s'); ylabel('RF');
hold on;
plot(t,x(:, 11));
hold on;
plot(t,x(:, 4));

subplot(4,1,3);
plot(t,x(:, 5));
xlabel('t/s'); ylabel('RB');
hold on;
plot(t,x(:, 13));
hold on;
plot(t,x(:, 6));

subplot(4,1,4);
plot(t,x(:, 7));
xlabel('t/s'); ylabel('LB');
hold on;
plot(t,x(:, 15));
hold on;
plot(t,x(:, 8));
legend('hip-pitch','hip-roll','knee');
