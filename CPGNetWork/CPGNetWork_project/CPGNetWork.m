function [joint_angle, osc_x] = CPGNetWork( acc_roll,slope_alpha, v, T, osc_x, tfinal, phi, theta0, beta, phiRB, phiLB, alpha, a, k1 ,k2)
%% ����
%��̬����
length = 0.9;                   %�峤  m
width = 0.5;                    %���  m
l = 0.3;                        %�Ƚڳ���  m
%��̬����
omiga_sw=1/(beta*T);            %�ڶ���Ƶ��
if(acc_roll>0.959595959)
    h = acc_roll*sin(atan(width/length))/(2*omiga_sw^2*sqrt(1-acc_roll^2/(4*omiga_sw^4)));                       %�ڶ�����˸߶�  m
else
    h=0.02;
end
Ak = acos((l*cos(theta0)-h)/l)-theta0;       %�Źؽڷ�ֵ
Ah = asin((beta*v*T)/(4*l/cos(theta0)));     %ϥ�ؽڷ�ֵ
%��������
miu=Ah^2;                       %������ֵ A=sqrt(miu)
%���������
%ǰͥ����
delte_theta=phi*k2*k1*slope_alpha;  %ԭƽ��λ�øı���
U = [-(delte_theta/2-k1*slope_alpha); delte_theta;     %�ⲿ������(feed) ��Ӧx1 y1 x2 y2 x3 y3 x4 y4
     -(delte_theta/2-k1*slope_alpha); delte_theta; 
     -(delte_theta/2-k1*slope_alpha); delte_theta; 
     -(delte_theta/2-k1*slope_alpha); delte_theta;
     0;0;0;0;0;0;0;0];
%% ��ֵ
t0 = 0;              % ��Ӧʱ����Time region of response��
%% ���
% ���Hopf����΢�ַ��̵���ֵ�⣨Numerical solution of differential equation��
[t, x] = ode45('CPGNetWork_hopf_oscillator_with_lateral_impact', [t0, tfinal], osc_x,[],alpha, beta, miu, omiga_sw, a, phiRB, phiLB, U);
%�������
for i = 1:16
    osc_x(i)=x(size(x,1), i);
end
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
x_out=x;
% �����ؽ����
joint_angle=[x_out(size(x_out,1), 1),x_out(size(x_out,1), 2),x_out(size(x_out,1), 3),x_out(size(x_out,1), 4),x_out(size(x_out,1), 5),x_out(size(x_out,1), 6),x_out(size(x_out,1), 7),x_out(size(x_out,1), 8),x_out(size(x_out,1), 9),x_out(size(x_out,1), 10),x_out(size(x_out,1), 11),x_out(size(x_out,1), 12),x_out(size(x_out,1), 13),x_out(size(x_out,1), 14),x_out(size(x_out,1), 15),x_out(size(x_out,1), 16)];
fprintf('LF  hip-pitch:%f  knee:%f  hip-roll:%f  ', joint_angle(1),joint_angle(2),joint_angle(9));
fprintf('RF  hip-pitch:%f  knee:%f  hip-roll:%f  ', joint_angle(3),joint_angle(4),joint_angle(11));
fprintf('RB  hip-pitch:%f  knee:%f  hip-roll:%f  ', joint_angle(5),joint_angle(6),joint_angle(13));
fprintf('RL  hip-pitch:%f  knee:%f  hip-roll:%f\n', joint_angle(7),joint_angle(8),joint_angle(15));
end

