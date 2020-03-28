# Lab 7: Stopwatch

#### Objectives

In this laboratory exercise you will implement BCD counters. You will use the Xilinx Isim simulator or the EDA playground online tool. You will use a push button on the CoolRunner board as reset device, onboard clock signal with frequency of 10&nbsp;kHz for synchronization, and 7-segment display as output device.

![basys_stopwatch](../../Images/basys_stopwatch.jpg)


## 1 Synchronize Git and create a new folder

Synchronize the contents of your Digital-electronics-1 working directory with GitHub. and create a new folder `Labs/07-stopwatch`.


## 2 Stopwatch

In VHDL, write a stopwatch counter. The counter counts the time in the form of a **seconds&nbsp;&nbsp;hundredths** and the maximum value is 59 99 (1 minute), then the time is reset to 00 00 and the counting continues. The counter increment must be performed every 10 ms (one hundredth of a second) with the clock enable signal. In addition, the counting is enabled by the input signal `cnt_en_i` and the counter is reset by the synchronous reset input.

Use an approach that uses one BCD counter for each decade and counts from 0 to 9. The lowest of the counters is incremented every 10 ms, and each higher-order counter is incremented if all lower-order counters are equal to the maximum value of 9.

Let the entity has these inputs:
* `clk_i` (clock)
* `srst_n_i` (synchronous reset, active low)
* `ce_100Hz_i` (clock enable)
* `cnt_en_i` (stopwatch enable)

and outputs:
* `sec_h_o[3:0]` (counter for tens of seconds)
* `sec_l_o[3:0]` (counter for seconds)
* `hth_h_o[3:0]` (counter for tenths of seconds)
* `hth_l_o[3:0]` (counter for hundredths of seconds)

We decreased the clock enable signal to a period of 10 ms to have a better display since counter display is changing every 10 ms
