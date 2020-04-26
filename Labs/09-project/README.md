# Project Digital electronics 1

In this project we are implementing a module able to count from a set value to zero. The set value will be given by the rotary encoder KY-040 with button and the output will be displayed on the serial 7-segment display with control circuit TM1637.

## Rotary encoder KY-040 with button

![KY_040_image](KY_040_rotary_encoder.jpg)

The KY-040 rotary encoder is a rotary input device that provides an indication of how much the knob has been rotated and in what direction it is rotating. We will use the knob to set each number of the 4 digits we are working with (seconds and hundredths) to set the start value for the countdown. We will use the button included to switch the selected digit we want to modify. We will use the 4 LEDS below the 7 segments to show to the user which digits is currently selected. 

### KY-040 pinout

![KY_040_pinout](KY_040_Rotary_Encoder_pinout.png)

The device has 5 pins. + will obviously be connected with 5V and GND with groung. The pushbutton swith will be used as a normal button and will be connected to a pin of the board set on pull-up so the value when pressed will be 0. The 2 others inputs are used to determine that the knob is rotating, in which direction and how much its rotating. 

### KY-040 Management of pins A and B

The pictures below explain how it works, A and B connected to pulled-up pins and compared to the ground. When the knob is rotating it modifies the values of A and B. We just have to the change of value of A to check if the knob is rotating and then we have to check the value of B, if values of A and B are different its rotating clockwise, if they are the same its rotating counter clockwise.

![KY_040_A_B](KY_040_A_B.png)
![KY_040_CW_CCW](KY_040_CW_CCW.png)

## 7 segments display

![7segmetns](7segments.png)

We will use the same 7 segments as we used during labs, so we will use the same VHDL module we created for labs to manage the display of numers. We can see below the 7 segments the 4 LEDS we will use for the user to know which digit is selected to modify. The LED3 will correspond to the tens of the seconds, the LEDS 2 to the units of the seconds...

The 7 segments has 4 digits : 2 for seconds and 2 for hundredths so the countdown will be updated every 10 ms (hundredths) we have to choose a period to be sure the hundredths will be updated by the driver between 2 incrementation of the counter, we can choose 1 ms, indeed with 1 ms it takes 4 ms for the driver to update the 4 digits. 

## Clock Enable Module

The clock enable module we have implemented during labs will be used to manage the countdown that have to be updated every 10 ms so the clock enable will be set on 100 Hz and to manage the 7 segments as said before.


## Sources :
https://www.youtube.com/watch?v=v4BbSzJ-hz4
