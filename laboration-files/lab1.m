%% Part 1: Plotting EKG
load("data/ekg1.mat")

figure;
plot(ekg1);
xlabel('Sample');
ylabel('Amplitud (\muV)');
title('EKG-signal raw');

FT = 1000; % Samplingsfrekvens i Hz
N = length(ekg1); % Antal sampel
n = 0:N-1; % Sampelindex
t = n / FT; % Tid konverterat från sampling

figure;
plot(t, ekg1);
xlabel('Tid (s)');
ylabel('Amplitud (\muV)');
title('EKG-signal i tidsdomänen');


%% Part 2: Analyzing frequencies with DFT
%{
We want to see which frequencies the signal contains.
We compute DFT with fft
The ekspek vector contains both amplitude and the phase and is complex
valued. We are only interested in which frequencies are in the signal,
which is why we plot only the amplitude function which corresponds to
the absolute value of the spectrum.
%}
M = 10000;
ekgspek=fft(ekg1,M);

figure;
plot(abs(ekgspek)) % Plotting without X-axis data -> hard to read
xlabel('Frequency (Hz)');
ylabel('Amplitud (\muV)');
title('Frequencies (simply enumerated)');

% Transform from normalized to physical freqs
f = (0:M-1)/M*FT; 

figure;
plot(f, abs(ekgspek));
xlabel('Frekvens (Hz)');
ylabel('Amplitud');
title('Hela spektrumet (0 - 1000 Hz)');

%{
Frequencies above half the sampling frequency (500 Hz) are only a
mirrored image of the frequencies below 500 Hz. It is hence below 500 Hz
we are to study in the figure
%}
figure;
plot(f, abs(ekgspek));
axis([0 500 0 800000])
xlabel('Frekvens (Hz)');
ylabel('Amplitud');
title('Inzoomat till Nyquist (0 - 500 Hz)');

figure;
plot(f, abs(ekgspek));
axis([0 20 0 150000])
xlabel('Frekvens (Hz)');
ylabel('Amplitud');
title('Inzoomat till 0 - 20 Hz');

%% Part 3: Applying a filter

figure;
subplot(2,1,1);
plot(t, ekg1);
xlabel('Tid (s)');
ylabel('Amplitud (\muV)');
title('Original EKG');

%{
Our filter tries to decrease the noise of the signal by specifying
that the output signal at time n is a weighted average of fifteen
last samples. The filter is then fifteen coefficients with equal 
values, set for example to 0.2 for the input samples with index n to n-14.
The filtering is fone using convolution of the input signal and the 
filter coeffs.
%}

fs = 15;
h = 0.2*ones(1,fs);
y = conv(ekg1, h);
y = y(fs:end);

subplot(2,1,2);
plot(t,y)
xlabel('Tid (s)');
ylabel('Amplitud (\muV)');
title('EKG with sliding average');