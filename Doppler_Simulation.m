clear; close all; clc; 

c = 3e8; % Speed of light
fc = 10e9; % Carrier frequency 10 GHz
fs = 1e6; % Sampling rate 1 MHz
f_tx = 10e3; % baseband transmitted frequency 10 KHz
t = 0:1/fs:1e-3; % Time vector for 1 second
signal = sin(2 * pi * f_tx * t); % Baseband signal

tiledlayout(2,1); 
nexttile; 
% Plot Baseband Signal
plot(t*1e3,signal); 
xlabel("time (ms)"); 
ylabel("Amplitude"); 
title('Baseband Signal'); 
grid on;
hold on; 

% The velocity we will shift the Baseband signal
velocity = 30; % Velocity of the transmitter in m/s
% Doppler shift equation for 1 dim
% fd = 2 * fc * v /c
fd = 2 * fc * velocity / c; 

% Apply Doppler shift to the baseband signal
shiftedSignal = sin(2 * pi * (f_tx + fd) * t);

% Plot Shifted Signal
plot(t*1e3, shiftedSignal, 'r');
xlabel("time (ms)");
ylabel("Amplitude");
title('Doppler Shifted Signal');
grid on;

% Lets create noise to make it more realistic
noiseAmp = 0.3; 
noise = randn(size(shiftedSignal)); 

% Add noise to the shifted signal
noisySignal = shiftedSignal + noiseAmp*noise;

% Then lets add a new graph under to see what the recieved signal would
% look like in the real world with noise.
nexttile; 
plot(t*1e3, noisySignal, 'r');
xlabel("time (ms)");
ylabel("Amplitude");
title('Noisy Doppler Shifted Signal vs Baseband Signal');
grid on;
hold on; 

% Baseband signal to compare
plot(t*1e3,signal, 'b'); 

%% Fast Fouier Transform
N = length(shiftedSignal); % Number of points
Y = fft(shiftedSignal); % Compute FFT (Note this returns complex values)
Y = fftshift(Y); % Shif the vector to center at 0 to make 
                             % more sense
f = (-N/2:N/2-1)*(fs/N); % Create frequency Vector based of fs and number 
                    % of samples in the shifted signal
figure; 
plot(f/1e3,abs(Y)/N); % We only need the magnitude of the complex values 
                  % so we use abs. Then we normalize it by dividing by N. 

hold on; 
% Now Lets do the same thing for the orignal signal to compare the two
Y_orig = fft(signal); % Compute FFT of the original baseband signal
Y_orig = fftshift(Y_orig); % Shift the vector to center at 0
plot(f/1e3, abs(Y_orig)/N); % Plot the magnitude of the FFT of the original signal

% Limit x axis to make it zoom in a bit.
xlabel("Frequency KHz"); 
title('FFT of Baseband Signal');
grid on;
xlim([-100,100]); 
xlabel("Frequency KHz"); 
legend("Received Signal", "Transmitted Signal"); 
%% Smoothing Filters
% Now lets you some simple filtering techniques 
figure; 
tiledlayout(2,1); 

% Baseband signal to compare
nexttile; 
plot(t*1e3,noisySignal, 'b'); 
hold on; 

% Lets move mean filter
windowSize = 7; 
filteredSignal = movmean(noisySignal, windowSize);
plot(t*1e3, filteredSignal, 'g');
xlabel("time (ms)");
ylabel("Amplitude");
title('Moveing Mean filter vs Noisy Signal');
grid on; 

legend('Noisy Signal','Filtered Signal');


% Baseband signal to compare
nexttile; 
plot(t*1e3,noisySignal, 'b'); 
hold on; 

% Lets try Savitzky - Golay filter
% Apply Savitzky-Golay filter
sgolayOrder = 3; % Order of the polynomial
frameSize = 7; % Frame size for the filter
filteredSG = sgolayfilt(noisySignal, sgolayOrder, frameSize);
plot(t*1e3, filteredSG, 'g');
xlabel("time (ms)");
ylabel("Amplitude");
title('Savitzky-Golay Filtered Signal vs Noisy Signal');
grid on;

legend('Noisy Signal','Savitzky-Golay Filtered Signal');
