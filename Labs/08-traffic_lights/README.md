# Lab 8: Traffic light controller

#### Objectives

In this laboratory exercise you will implement a finite state machine, specifically a traffic light controller at a junction. You will use the Xilinx Isim simulator or the EDA playground online tool. You will use a push button on the CoolRunner board as reset device, onboard clock signal with frequency of 10&nbsp;kHz for synchronization, and CPLD expansion board LEDs as outputs.

[Video](https://youtu.be/P2emiQeBgE8)


## Finite State Machine (FSM)

Exemple of declaration of own data type (here state type) : type state_type is (G_R, Y_R, R_R1, R_G, R_Y, R_R2);

State Diagram of this application :

![state_diagram_photo](State_Diagram_LAB8.png)

## Traffic light controller

We renamed signals G_R, Y_R, R_R1, R_G, R_Y, R_R2
We used a counter from 1 to 3/15 to have 1s/5s with a clock enable signal of 3Hz



