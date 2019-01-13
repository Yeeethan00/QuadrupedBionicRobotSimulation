%% hopf oscillator for four-legged robots
% x'=alpha*(miu-(x-u1)^2-(y-u2)^2)*(x-u1)-((1-beta)*omiga_sw/(beta*(1+exp(-a*y)))+omiga_sw/(1+exp(a*y)))*(y-u2);
% y'=alpha*(miu-(x-u1)^2-(y-u2)^2)*(y-u2)+((1-beta)*omiga_sw/(beta*(1+exp(-a*y)))+omiga_sw/(1+exp(a*y)))*(x-u1);
function xdot = hopf_oscillator_for_fourlegged_robots( t, x)
alpha=100;                      %�����������������޻��õ��ٶ�
u1=0;u2=0;                      %�ⲿ������
beta=0.5;                       %��������
miu=1;                          %������ֵ A=sqrt(miu)
omiga_sw=2*pi;                  %�ڶ���Ƶ��
a=50;                           %����omiga��omiga_sw��omiga_st֮��ı仯�ٶ�
xdot = [ alpha*(miu-(x(1)-u1)^2-(x(2)-u2)^2)*(x(1)-u1)-((1-beta)*omiga_sw/(beta*(1+exp(-a*x(2))))+omiga_sw/(1+exp(a*x(2))))*(x(2)-u2);
         alpha*(miu-(x(1)-u1)^2-(x(2)-u2)^2)*(x(2)-u2)+((1-beta)*omiga_sw/(beta*(1+exp(-a*x(2))))+omiga_sw/(1+exp(a.*x(2))))*(x(1)-u1)];
end