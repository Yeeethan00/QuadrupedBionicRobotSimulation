%% CPG����
close all;
%��ֵ
tfinal = 0.001;                  % ��Ӧʱ����Time region of response��
osc_x = [0.1; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];% ������ʼֵ��Initial value��
for i=1:100000
    [joint_angle, osc_x] = CPGNetWork(osc_x, tfinal);
end
