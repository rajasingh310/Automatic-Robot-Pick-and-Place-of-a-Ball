%{

IMP Note: Run only, Pick_Place_Behaviour file. 

Description: 
1: The file contains User Inputs for any positions within workspace
2: If ball is picked and not placed, then autamatically Placing Ball at platform B

%}
tot_pos = input('Enter total no. of positions = ');
for r = 1:tot_pos % r = rows
    fprintf('Give values for position no: %d \n',r);
    for c = 1:3 % c = colums
         pos(r,c) = input('Enter valid positions = '); % Give three positions as [X, Y, Z]
    end
    fprintf('\n');
end 

% Placing ball ultimately at platform B
rem = mod(tot_pos,2);
if rem == 1
    tot_pos = tot_pos+1;
    pos(tot_pos,1) = 0; % position in X
    pos(tot_pos,2) = 1; % position in Y
    pos(tot_pos,3) = -70; % position in Z
    
    disp ('Added extra position to place ball at Platform B');
end