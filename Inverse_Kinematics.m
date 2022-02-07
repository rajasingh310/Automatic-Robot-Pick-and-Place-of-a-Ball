%{

IMP Note: Run only, Pick_Place_Behaviour file. 

Description: 
1: File contains all predefined positions and their Inverse kinematics
2: All units are in mm & degree
3: "UserInput" is a seperate Script, used to move robot at any desired
location within workarea
4: To use UserInput, 1. comment line 17 till 28, 2. Include UserInput at
line 29

%}

clear all
clc

plat_A = 6; % platform A 6mm offset
plat_B_C = -70; % platform B&C height

pos = [0 1 plat_B_C; -1 0 plat_B_C; % positions are B to C
    -1 0 plat_B_C; 1 0 plat_A; % C to A
    1 0 plat_A ; 0 1 plat_B_C; % A to B
    0 1 plat_B_C; -1 0 plat_B_C; % B to C
    -1 0 plat_B_C; 0 1 plat_B_C]; % C to B, all positions in [x, y, z]

tot_pos = 10; % total positions

% UserInput %seperate function for User inputs

l1 = 50; %l = link value
l2 = 95;
l3 = 185;
l4 = 110;
phi = 45; % angle between horizontal axis and link 2
shi = 5; % offset angle of link 3

% Inverse Kinematics formula
for i = 1:tot_pos
    theta_1(i,1) = atan2d(pos(i,2),pos(i,1)); %motor C angles
    theta_2(i,1) = phi-shi-asind((pos(i,3)-l1-(l2*cosd(phi))+ l4)/l3); %motor B angles
end