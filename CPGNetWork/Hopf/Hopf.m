%% PARAM: 
%      omiga:����Ƶ��       omiga_sw:�ڶ���Ƶ��         omiga_st:֧����Ƶ��      a:����omiga��omiga_sw��omiga_st֮��ı仯�ٶ�
%      beta:��������          miu:������ֵ A=sqrt(miu)  u1\u2:�ⲿ������         alpha:�����������������޻��õ��ٶ�
%      x\y:״̬����           r:����Բ�뾶
%% ���޻���ͼ
clear;
alpha=100;                      %�����������������޻��õ��ٶ�
u1=0;u2=0;                      %�ⲿ������
beta=0.5;                       %��������
miu=1;                          %������ֵ A=sqrt(miu)
omiga_sw=2*pi;                  %�ڶ���Ƶ��
a=50;                           %����omiga��omiga_sw��omiga_st֮��ı仯�ٶ�
%���Ƽ��޻���ͼ
figure(1)
[x,y]=meshgrid(linspace(-1.5,1.5));
h=streamslice(x,y,alpha.*(1-(x-u1).^2-(y-u2).^2).*(x-u1)-((1-beta).*omiga_sw./(beta.*(1+exp(-a.*y)))+omiga_sw./(1+exp(a.*y))).*(y-u2),alpha.*(1-(x-u1).^2-(y-u2).^2).*(y-u2)+((1-beta).*omiga_sw./(beta.*(1+exp(-a.*y)))+omiga_sw./(1+exp(a.*y))).*(x-u1));
set(h,'Color','k');
xlabel('x'); ylabel('y');
title('Hopf���޻���ͼ');
axis([-1.5 1.5 -1.5 1.5]);
%% ���޻�����
clear
% ��Ӧʱ����Time region of response��
t0 = 0; tfinal = 10;
% ������ʼֵ��Initial value��
x0 = [0.1; 0.2];
% ���΢�ַ��̵���ֵ�⣨Numerical solution of differential equation��
[t, x] = ode45('hopf_oscillator_for_fourlegged_robots', [t0, tfinal], x0);
% ���Ƽ��޻�ͼ��Phase diagram��
figure(2);
plot(x(:, 1), x(:, 2));
xlabel('x'); ylabel('y');
title('Hopf���޻�');
grid on;
%�����������ͼ
figure(3);
plot(t,x(:, 1));
xlabel('t/s'); ylabel('Output x y');
title('Hopf�������');
hold on;
plot(t,x(:, 2));
legend('x','y');