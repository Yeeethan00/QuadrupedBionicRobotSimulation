%% CPG����
close all;
%��̬����
acc_roll=0;slope_alpha=0;
%��̬����
T = 0.4;                        %�˶����� m 
v = 1;                          %�˶��ٶ�  m/s
phi = 1;                        %�ؽ�����,1������ʽ,-1����ϥʽ
theta0 = pi/6;                  %���봹ֱ���������棩�нǣ�ԭƽ��λ��
beta=0.5;                       %�������ӣ���ʾ֧������ռ����
phiRB=0; phiLB=0.5;             %RB LB��λ, ��betaһͬ������̬
%����
alpha=100;                      %�����������������޻��õ��ٶ�
a=50;                           %����omiga��omiga_sw��omiga_st֮��ı仯�ٶ�
%����
k2=2.26;                        %ƽ��λ�øı���/������̬��
k1=0.24;                        %������̬��/�¶Ƚ�
%��ֵ
tfinal = 0.001;                  % ��Ӧʱ����Time region of response��
osc_x = [0.1; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];% ������ʼֵ��Initial value��
for i=1:T/tfinal
    [joint_angle, osc_x] = CPGNetWork( acc_roll,slope_alpha, v, T, osc_x, tfinal, phi, theta0, beta, phiRB, phiLB, alpha, a, k1 ,k2);
end
