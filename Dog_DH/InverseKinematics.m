function [ theta1, theta2, theta3 ] = InverseKinematics( oPx, oPy, oPz, a1, a2, a3, leg_dir)

%INPUT:
%oP(x,y,z)���м�ϵO���Źؽڣ�Ϊ�ο�ϵ oPx, oPy, oPzΪ�����Oϵ�µ�����
%a1, a2, a3Ϊ���˳��ȣ��ţ����ȣ�С�ȣ�
%leg_dir ǰ��Ϊ0�� ����Ϊ1
%OUTPUT:
%theta1 theta2 theta3 Ϊ�����ؽڽǶȣ���ڣ��ţ�ϥ��

theta1 = atan(oPy/oPz);
if leg_dir == 0 % ǰ��
    theta3 = acos(( a2^2 + a3^2 - oPx^2 - (sqrt(oPy^2 + oPz^2) - a1^2)^2)/(2 * a2 * a3));
    theta2 = -pi + acos(((oPx^2 + (sqrt(oPy^2 + oPz^2)-a1)) + a2^2 - a3^2)/(2*a2*sqrt(oPx^2 + (sqrt(oPy^2 + oPz^2)-a1)))) - atan(oPx/(sqrt(oPy^2 + oPz^2)-a1));
elseif leg_dir == 1 % ����    
    theta3 = -acos(( a2^2 + a3^2 - oPx^2 - (sqrt(oPy^2 + oPz^2) - a1^2)^2)/(2 * a2 * a3));
    theta2 = pi - acos(((oPx^2 + (sqrt(oPy^2 + oPz^2)-a1)) + a2^2 - a3^2)/(2*a2*sqrt(oPx^2 + (sqrt(oPy^2 + oPz^2)-a1)))) + atan(oPx/(sqrt(oPy^2 + oPz^2)-a1));
end % end of if

end % end of function

