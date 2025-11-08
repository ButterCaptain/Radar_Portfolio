% Radar Simulation & Arduino Live Plot
clear; clc; close all;

distances_arr = [];  % store Arduino distances

% Arduino Setup
arduino = serialport("COM3", 9600);
pause(2); % wait for serial connection

% Create animated plot
figure;
h_dist = animatedline('Color','b');
ylim([0,100]);
ylabel('Distance (cm)');
xlabel('Time (s)');
title('Ultrasonic Sensor: Distance');
grid on;

t0 = tic;  % start timer

% Main Loop
while isvalid(arduino)
    if arduino.NumBytesAvailable > 0
        data = readline(arduino);
        distance = str2double(data);
        if ~isnan(distance)
            % Timestamp
            t_now = toc(t0);

            % Store distance
            distances_arr(end+1) = distance;

            % Smooth distance (3-point moving average)
            smooth_dist = movmean(distances_arr, 3);

            % Update plots
            addpoints(h_dist, t_now, smooth_dist(end));
            drawnow limitrate
        end
    end
end

