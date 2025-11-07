# Doppler Shift Simulation and Signal Analysis (MATLAB)

This project simulates the Doppler effect on a sinusoidal signal to explore how motion between a transmitter and receiver affects the observed frequency. The goal was to gain a better understanding of basic radar principles, the use of the Fast Fourier Transform (FFT) for frequency analysis, and simple noise filtering techniques.

---

## Overview

The simulation begins with a baseband signal, a 10 kHz sine wave representing the transmitted tone.  
A Doppler shift is introduced based on a simulated transmitter velocity of 30 m/s and a 10 GHz carrier frequency, using the standard Doppler shift equation:

fd = (2 * fc * v) / c

This produces a frequency-shifted version of the original waveform, representing what would be received by a stationary receiver when the source is moving.

To make the simulation more realistic, **Gaussian noise** is added to the shifted signal, representing interference or background noise commonly found in radar and communication systems.

<img width="1912" height="866" alt="Figure_1" src="https://github.com/user-attachments/assets/716566a0-0b9c-43ad-96cc-1f766cdb9d26" />

---

## Frequency-Domain Analysis

Both the transmitted and Doppler-shifted signals are analyzed in the frequency domain** using the Fast Fourier Transform (FFT).  

The FFT is shifted and normalized to center the frequency components, making it easier to visualize the frequency displacement caused by motion.  

This comparison clearly shows how the Doppler effect shifts the received signal’s frequency relative to the transmitted one.

<img width="1830" height="866" alt="Figure_2" src="https://github.com/user-attachments/assets/b06c8d96-bad9-4304-a2f9-ba737e11a8e6" />

---

## Signal Filtering

To reduce noise and smooth out the received signal, two different filters were applied:

- **Moving Mean Filter:** Smooths out fluctuations by averaging samples over a sliding window.  
- **Savitzky–Golay Filter:** A polynomial-based smoothing filter that maintains the shape and amplitude of the signal more effectively than a simple moving average.

These filters demonstrate fundamental techniques used to recover useful data from noisy signals in real-world systems.

<img width="1895" height="866" alt="Figure_3" src="https://github.com/user-attachments/assets/0deacfe0-efb5-4224-a40d-456d5b49ef1c" />

---

## Key Takeaways

Through this project, I learned how to:

- Simulate and visualize Doppler-shifted waveforms in MATLAB  
- Apply the Doppler equation to a baseband signal  
- Perform FFT-based frequency analysis  
- Understand how motion and noise affect received signals  
- Implement and compare basic filtering methods

---
