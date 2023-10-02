%{
IMP Note: Run only, Pick_Place_Behaviour file.

Description: The file contains Homing of Robot and opening of Gripper
Assumptions:
1: Motor rotation is not beyond the Touch sensor
2: The Gripper is initially in a closed condition with a negative speed for closing
%}

% Initialize the EV3 robot
mylego = legoev3('usb');

% Configure touch sensors for detecting limits
ts_1 = touchSensor(mylego, 1); % Touch sensor at position 1
ts_3 = touchSensor(mylego, 3); % Touch sensor at position 3

% Initialize motors
m_A = motor(mylego, 'A'); % Motor A
m_B = motor(mylego, 'B'); % Motor B
m_C = motor(mylego, 'C'); % Motor C

% Start all motors
start(m_A);
start(m_B);
start(m_C);

% Set initial speed to reset Gripper
m_A.Speed = -40;

% Homing procedure to bring the robot to a known starting position
rts_1 = readTouch(ts_1);
while rts_1 ~= 1
    rts_3 = readTouch(ts_3);
    while rts_3 ~= 1
        m_B.Speed = -40; % Move motor B upwards
        rts_3 = readTouch(ts_3);
    end
    m_B.Speed = 0; % Stop motor B
    m_C.Speed = 30; % Move motor C to the left
    rts_1 = readTouch(ts_1);
end

m_C.Speed = 0; % Stop motor C
pause(0.5);

% Reset rotation values for all motors
resetRotation(m_A);
resetRotation(m_B);
resetRotation(m_C);

rem = 0; % Initialize remainder as a variable
Gripper % Call the Gripper function
