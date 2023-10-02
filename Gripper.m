%{
IMP Note: Run only, Pick_Place_Behaviour file. 

Description: The file contains Gripper to Hold and Release the Ball
In total no. of positions, at all odd positions Gripper will Hold
and at all even positions Gripper wil Release

%}

% Pause briefly before starting to allow time for setup
pause(0.5);

% Check if the remainder of some variable (possibly position index) is 1 (odd)
if rem == 1
    % Gripper Hold loop
    while readRotation(m_A) >= 0
        m_A.Speed = -40; % Set the speed of motor A to -40 (to close the gripper)
    end
    m_A.Speed = 0; % Stop motor A when the gripper is closed
else
    % Gripper Release loop
    while readRotation(m_A) <= 80
        m_A.Speed = 30; % Set the speed of motor A to 30 (to open the gripper)
    end
    m_A.Speed = 0; % Stop motor A when the gripper is open
end
