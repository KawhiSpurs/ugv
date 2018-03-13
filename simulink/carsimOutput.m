function [sys,x0] = carsimOutput(t,x,u,flag)
%%
global lc;
% glb_data = 1;

if flag==0
    sys=[0;0;6;6;1;1];
    x0=[];
    lc = lcm.lcm.LCM.getSingleton();
    
elseif flag==3
    
     
    msgCan = lcmtypes.PacketCanMsg(); % ��Can�з��� �ٶȡ�������ת��
    msgSlamPos = lcmtypes.PacketSlamPos(); % ��GPS�з��� ���� x���ꡢy����
    if u(6)== 1
         
        msgCan.speed = u(1);     
        msgCan.steer = u(2);
        lc.publish('CANMsg', msgCan);

            
        msgSlamPos.x = -u(4);
        msgSlamPos.y = u(3); 
        msgSlamPos.heading = -u(5)+322; 
        msgSlamPos.accuracy = 0.05;
        lc.publish('SlamPos', msgSlamPos);
    end
    sys=[msgCan.speed;msgCan.steer;msgSlamPos.x;msgSlamPos.y;msgSlamPos.heading;u(6)];
else sys=[];
end

          
 






