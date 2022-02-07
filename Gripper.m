%{

IMP Note: Run only, Pick_Place_Behaviour file. 

Description: The file contains Gripper to Hold and Release the Ball
In total no. of positions, at all odd positions Gripper will Hold
and at all even positions Gripper wil Release

%}
pause(0.5);
if rem == 1
    while readRotation(m_A) >= 0 % Gripper Hold loop
        m_A.Speed = -40; % Providing speed to motor A
    end
    m_A.Speed = 0;
else
    while readRotation(m_A) <= 80 % Gripper Release loop
        m_A.Speed = 30; % Providing speed to motor A
    end
    m_A.Speed = 0;
end