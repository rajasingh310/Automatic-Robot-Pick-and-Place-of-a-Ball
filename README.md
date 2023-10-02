# Robot Pick and Place System

This repository contains MATLAB scripts for controlling a robot's pick-and-place behavior. The system includes inverse kinematics calculations, homing behavior, PID control for smooth motion, and user-defined position inputs. The scripts are designed to operate a robot gripper for picking up and placing objects at specific positions within its workspace.

## Scripts Overview

### 1. `Pick_Place_Behavior.m`

- **Description**: This script controls the gripper to hold and release a ball at different positions. Gripper behavior is determined by the position index.
- **Usage**: Provide the `rem` value (remainder) to decide whether the gripper will hold or release the ball based on the position index.

### 2. `Inverse_Kinematics.m`

- **Description**: This script calculates the inverse kinematics for predefined positions in the robot's workspace. It computes motor angles for precise motion.
- **Usage**: Run this script to perform the inverse kinematics calculations.

### 3. `Homing.m`

- **Description**: This script implements the homing behavior of the robot, ensuring it starts from a known position before pick-and-place operations.
- **Usage**: Execute this script to perform the robot homing sequence.

### 4. `UserInput.m`

- **Description**: This script allows users to input custom positions within the robot's workspace. It also adds an extra position at Platform B if the ball has been picked but not placed.
- **Usage**: Run this script to input desired positions and automatically add a placement position if needed.

## Getting Started

1. Clone this repository to your local machine.
2. Ensure you have MATLAB installed.
3. Open MATLAB and run the desired scripts according to your task requirements.
4. Follow the usage instructions provided for each script.

## Notes

- Carefully review the script descriptions and usage instructions to understand their functionality.
- Ensure that your robot and hardware setup are compatible with these scripts.
- Customize the scripts and parameters as needed to suit your specific robot system.

Feel free to reach out with any questions or issues you encounter while using these scripts.

Enjoy your robot pick-and-place automation!

