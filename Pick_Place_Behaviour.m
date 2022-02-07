%{
IMP Note: Run only, Pick_Place_Behaviour file. 

Description: 
1: The file contains the Behaviour of Robot to pick and place the
Ball at desired locations
2: Program divided into 4 parts, consisting moton of mototr C,B,A and final retraction with motor B
3: 4 different functions are implemented to optimize program
3: error_0 is current error, where as error_1 is past error & error_2 is
pasttopast error
4: cur_sp = current speed, del_sp is change in speed
5: pid controller is implemented in function called pid

%}
Inverse_Kinematics % include matlab script
Homing % include matlab script

%Tuning Parameters
kp = 0.5;
Tn = 0.3;
Tv = 0.12;
Tsam = 0.03; % sampling time
ki = kp/Tn;
kd = kp*Tv;
c0 = kp+kd/Tsam;
c1 = ki*Tsam-kp-2*(kd/Tsam);
c2 = kd/Tsam;

for i = 1:tot_pos % total position 10 for our task
    
    % Part 1: Motion of motor C
    [past_sp, error_1, error_2] = init; % call function init
    error_0 = -theta_1(i,1) - readRotation(m_C)/3.33; % providing 0.33 offset in Gear ratio
    while abs(error_0) > 1 % providing 1 degree tolerence
        cur_sp = pid(error_0, error_1, error_2, c0, c1, c2, past_sp); % call function pid
        cur_sp(cur_sp>30)= 30;% providing range to speed -30 to 30
        cur_sp(cur_sp<-30)= -30;
        m_C.Speed = cur_sp; % Providing speed to motor C
        [past_sp, error_2, error_1] = swap(cur_sp, error_1, error_0); % call function swap
        error_0 = -theta_1(i,1) - readRotation(m_C)/3.33;
    end
    m_C.Speed = 0;
    
    % Part 2: Motion of motor B
    [past_sp, error_1, error_2] = init; % call function init
    error_0 = theta_2(i,1) - readRotation(m_B)/5;
    while abs(error_0) > 1 % providing 1 degree tolerence
        cur_sp = sp(error_0, error_1, error_2, c0, c1, c2, past_sp); % call function sp
        m_B.Speed = cur_sp; % Providing speed to motor B
        [past_sp, error_2, error_1] = swap(cur_sp, error_1, error_0); % call function swap
        error_0 = theta_2(i,1) - readRotation(m_B)/5;
    end
    m_B.Speed = 0;
    
    % Part 3: Motion of motor A
    rem = mod(i,2); % remainder to decide odd and even positions
    Gripper % calling Matlab Script Gripper
    
    % Part 4: Motion of motor B till standard height 20 degree
    [past_sp, error_1, error_2] = init; % call function init
    error_0 = 20 - readRotation(m_B)/5; % picking Ball till standard height 20 degree
    while abs(error_0) > 1 % providing 1 degree tolerence
        cur_sp = sp(error_0, error_1, error_2, c0, c1, c2, past_sp); % call function sp
        m_B.Speed = cur_sp; % Providing speed to motor B
        [past_sp, error_2, error_1] = swap(cur_sp, error_1, error_0); % call function swap
        error_0 = 20 - readRotation(m_B)/5;
    end
    m_B.Speed = 0;
end
stop(m_A);
stop(m_B);
stop(m_C);

disp ('The end');
clear mylego;

function [p_sp, err_1, err_2] = init % implementing function name init
pause(0.5);
p_sp = 0; % Initilization of past speed
err_1 = 0; % Initilization of error_1
err_2 = 0; % Initilization of error_2
end
function [p_sp, err_2, err_1] = swap(c_sp, er_1, er_0) % implementing function name swap
p_sp = c_sp; % past speed = current speed
err_2 = er_1; % error_(k-2) = error_(k-1)
err_1 = er_0; % error_(k-1) = error_(k)
end
function c_sp = sp(err_0, err_1, err_2, c_0, c_1, c_2, p_sp) % implementing function name sp
c_sp = pid(err_0, err_1, err_2, c_0, c_1, c_2, p_sp); % call subfunction speed
c_sp(c_sp>10)=10; % providing range to motor B speed -40 till 10
c_sp(c_sp<-40)=-40;
end
function c_sp = pid(err_0, err_1, err_2, c_0, c_1, c_2, p_sp) % implementing function name pid
d_sp = c_0*err_0+c_1*err_1+c_2*err_2; % change in Speed
c_sp = p_sp+d_sp; % PID controller output as current speed
end