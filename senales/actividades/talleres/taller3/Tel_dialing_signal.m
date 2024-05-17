
%%%%%%%%%% 2.3.1 Telephone dialing signal %%%%%%%%%%
clc;

% Leer el audio 
[x, Fs] = audioread('tel.wav');

% Compute the DFT
N = length(x);
X = fft(x);

% Compute the frequency axis
%f = linspace(-Fs/2, Fs/2, N);
f = Fs*(0:N-1)/N;

% Compute the magnitude and phase of the DFT
magX = abs(X);
phaseX = angle(X);

% Plot the magnitude and phase of the DFT versus frequency in Hz
subplot(2,1,1);
plot(f, magX);
xlim([0 Fs/2]);
ylim([0 1.1*max(magX)]);
line(f_col, '--r');
line(f_row, '--b');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude of DFT');

subplot(2,1,2);
plot(f, phaseX);
xlim([0 Fs/2]);
ylim([-pi pi]);
line(f_col, '--r');
line(f_row, '--b');
xlabel('Frequency (Hz)');
ylabel('Phase');
title('Phase of DFT');


% Define the DTMF frequencies
f_col = [1209 1336 1477 1633];
f_row = [697 770 852 941];
% Define the phone number lookup table
keypad = ['1' '2' '3' 'A';
          '4' '5' '6' 'B';
          '7' '8' '9' 'C';
          '*' '0' '#' 'D'];
% Find the two strongest frequencies in each DTMF tone
tones = [697 770 852 941 1209 1336 1477 1633];
digits = [];
for ii = 1:length(x)/N
    y = x((ii-1)*N+1:ii*N);
    Y = abs(fft(y));
    f = (0:N-1)*Fs/N;
    for jj = 1:length(tones)
        [~, idx] = max(Y(f==tones(jj)));
        idx = find(f==tones(jj), idx);
        if jj <= 4
            row_idx = mod(idx-1, length(f_row))+1;
            col_idx = floor((idx-1)/length(f_row))+1;
            digits = [digits keypad(col_idx, row_idx)];
        end
    end
end
% Display the decoded phone number
disp(digits);
