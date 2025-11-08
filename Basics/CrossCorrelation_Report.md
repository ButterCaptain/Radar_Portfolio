# Time Delay Estimation Using Cross-Correlation
---

## Overview

This project simulates how radar systems measure distance using **time delay estimation**. The idea is simple: transmit a signal, receive its echo after it reflects off a target, and calculate how long it took to return. That time delay is then used to find the distance to the target.

The MATLAB script generates a sine wave to represent the transmitted signal and creates a delayed version to simulate the received echo. Using cross-correlation, the program compares the two signals to find where they best align — that alignment point corresponds to the delay caused by the signal’s round trip.

From there, the script converts the delay into seconds and multiplies it by the speed of light to calculate the target distance.

---

## How It Works

The simulation follows these main steps:

1. **Define constants** such as frequency, sampling rate, and the speed of light.  
2. **Generate a sine wave** to act as the transmitted radar signal.  
3. **Simulate a delayed echo** by shifting the signal in time, representing the reflection off a distant object.  
4. **Perform cross-correlation** between the transmitted and received signals to measure their similarity at different time shifts.  
5. **Find the peak correlation**, which reveals the number of samples (and therefore the time) between the two signals.  
6. **Convert the delay into distance** using the equation:
   
   Distance = (c * Time Delay)/2
   
   The division by two accounts for the signal traveling to the target and back.

---

## Results

When the simulation runs, MATLAB prints an estimated **time delay** and **distance**.  
For a simulated delay of `0.7 µs`, the output shows a target distance of about **105 meters**, which makes sense given the speed of light.

The code also includes visual plots:
- A comparison of the transmitted and received signals, showing the time shift.
- A cross-correlation plot, with a sharp peak at the detected delay.
- An alignment check, showing that the shifted transmitted signal matches the received signal after applying the detected delay.

---

## Key Takeaways

- Cross-correlation is a powerful tool for detecting time shifts between two signals.  
- The sampling rate greatly affects accuracy — higher sampling gives better precision.  
- Small time differences (on the order of microseconds) represent large physical distances because electromagnetic waves travel at the speed of light.  
- The method shown here is foundational to how radar, sonar, and even wireless communication systems determine range or delay.


