%{
IMP Note: Run only, Pick_Place_Behaviour file.

Kindly change Gripper direction of rotation if robot gets stuck
at Home

Description: The file contains Homing of Robot and opening of Gripper
Assumptions:
1: Motor rotation is not beyond Touch sensor
2: Gripper is in closed condition and having negative speed for closing

%}
mylego = legoev3('usb');

ts_1 = touchSensor(mylego,1);
ts_3 = touchSensor(mylego,3);

m_A = motor(mylego, 'A');
m_B = motor(mylego, 'B');
m_C = motor(mylego, 'C');

start(m_A);
start(m_B);
start(m_C);
m_A.Speed = -40; % reset Gripper

% Homing
rts_1 = readTouch(ts_1);
while rts_1 ~= 1
    rts_3 = readTouch(ts_3);
    while rts_3 ~= 1
        m_B.Speed = -40; % up motion
        rts_3 = readTouch(ts_3);
    end
    m_B.Speed = 0;
    m_C.Speed = 30; % left motion
    rts_1 = readTouch(ts_1);
end
m_C.Speed = 0;
pause(0.5);

resetRotation(m_A); % reseting all motors
resetRotation(m_B);
resetRotation(m_C);

rem = 0; % remainder as a variable
Gripper % calling function Gripper