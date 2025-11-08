clear; close all; clc; 

% Constants
f = 1e6;          % Frequency of signal (1 MHz)
fs = 20e6;        % Sampling rate (20x the signal frequency)
t = 0:1/fs:1e-5;  % Time vector for 10 microseconds
c = 3e8;          % Speed of light (m/s)
delay = 0.7e-6;   % Simulated delay in seconds (0.7 microseconds)

% Generate transmitted signal
signal = sin(2 * pi * f * t); % Create sine wave

% Received Signal
delaySamples = round(delay * fs); % Convert delay time to number of samples
receivedSignal = [zeros(1, delaySamples), signal(1:end - delaySamples)]; % Shift signal by delay

% Calculate Cross-Correlation
[R, lags] = xcorr(receivedSignal, signal); % Compare signals using cross-correlation
R = R / max(R); % Normalize correlation for easier viewing
[~, idx] = max(R); % Find index of maximum correlation
sampleDelay = lags(idx); % Delay in samples
timeDelay = sampleDelay / fs; % Convert delay to seconds
distance = timeDelay * c / 2; % Distance to target (divide by 2 for round trip)

% Display results in the Command Window
fprintf('Estimated delay: %.2e s\n', timeDelay);
fprintf('Estimated target distance: %.2f m\n', distance);

% Transmitted vs Received
figure;
plot(t * 1e6, signal, 'b', 'LineWidth', 1.2); hold on;
plot(t * 1e6, receivedSignal, 'r--', 'LineWidth', 1.2);
xlabel('Time (µs)');
ylabel('Amplitude');
title('Transmitted and Received Signals');
legend('Transmitted', 'Received');
grid on;

% Plot Cross-Correlation
figure; 
plot(lags / fs * 1e6, R, 'w', 'LineWidth', 1.3); hold on;
xline(timeDelay * 1e6, 'r--', 'LineWidth', 1); % Mark time delay position
yline(R(idx), 'r--', 'LineWidth', 1); % Mark correlation value
plot(timeDelay * 1e6, R(idx), 'ro', 'MarkerFaceColor', 'r'); % Plot point of max correlation
text(timeDelay * 1e6, R(idx), sprintf('  Delay = %.2f µs', timeDelay*1e6), ...
    'Color', 'red', 'FontSize', 10, 'VerticalAlignment', 'top');
xlabel('Lag (µs)');
ylabel('Normalized Correlation');
title('Cross-Correlation between Received and Transmitted Signals');

% Alignment Check
figure;
alignedSignal = circshift(signal, sampleDelay); % Shift transmitted signal by detected delay
plot(t * 1e6, alignedSignal, 'b', 'LineWidth', 1.2); hold on;
plot(t * 1e6, receivedSignal, 'r--', 'LineWidth', 1.2);
xlabel('Time (µs)');
ylabel('Amplitude');
title('Received Signal vs. Shifted (Aligned) Transmitted Signal');
legend('Aligned Transmitted', 'Received');
grid on;

% Also we could work back words to obtain the time delay and distance just
% based off lags
estimatedDelay = lags(idx) / fs; % Time delay from lags
estimatedDistance = estimatedDelay * c / 2; % Distance to target
fprintf('Estimated delay from lags: %.2e s\n', estimatedDelay);
fprintf('Estimated target distance from lags: %.2f m\n', estimatedDistance);
