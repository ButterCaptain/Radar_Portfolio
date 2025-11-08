This project combines Arduino and MATLAB to create a simple radar-like distance measurement system using the HC-SR04 ultrasonic sensor.  
The goal was to interface embedded hardware with MATLAB for real-time data visualization, similar to how radar systems collect and process distance information from reflections.

---

## Project Overview

The Arduino continuously measures the distance to nearby objects using ultrasonic pulses, then sends that data to MATLAB over a serial connection.  

MATLAB receives and plots the incoming data in real time, producing a live distance vs. time graph that updates dynamically.

This project was my introduction to combining embedded systems, signal processing, and data visualization — all concepts that are essential in radar and electronic measurement systems.

<img width="1389" height="712" alt="Distance_VS_Time" src="https://github.com/user-attachments/assets/980951e2-bb6d-413d-b819-bf5b891b575b" />

---

## How It Works

### Arduino Side

- The HC-SR04 sensor sends out a short ultrasonic pulse via the TRIG pin and waits for its echo on the ECHO pin.  
- The time it takes for the echo to return is used to calculate distance using:

distance = (duration * speed_of_sound) / 2


where the division by two accounts for the pulse traveling to the object and back.

- The distance (in cm) is then sent to MATLAB over the serial port at 9600 baud.

### MATLAB Side

- MATLAB opens a serial connection (`serialport("COM3", 9600)`) and continuously reads data from the Arduino.  
- Each valid distance value is timestamped, smoothed with a 3-point moving average filter, and plotted in real time using an animated line.  
- The plot updates every 50 ms, visually showing how the measured distance changes over time — a simple analog to a radar tracking display.

---

## Key Concepts Learned

- Serial communication between Arduino and MATLAB  
- Ultrasonic distance measurement using time-of-flight  
- Real-time plotting and data smoothing in MATLAB  
- Basic understanding of how radar and sonar measure distance using reflected waves  
- The importance of filtering noisy sensor data for clean visualization  

---

## Notes and Limitations

- The HC-SR04 has limited accuracy beyond ~4 meters and can be affected by environmental noise.  
- The MATLAB visualization assumes a constant sample rate (50 ms delay), but real timing may vary slightly due to serial latency.  
- Unlike true radar systems, this project does not involve carrier frequencies, Doppler shifts, or power analysis — it focuses solely on distance measurement and live signal monitoring.

---

## Tools Used

- Arduino Uno R3
- HC-SR04 Ultrasonic Sensor  
- MATLAB R2023+ (using `serialport` and live plotting)

---

This project gave me hands-on experience bridging the gap between hardware measurement and software visualization, helping me better understand how real radar systems acquire and process range data.


