
%% Filtering of One-dimensional signals
% Creating the signal
N = 256;
n = (0:N-1);
f = 12/N;
x = square(2*pi*n*f);

% Creating the filter
L = 7;
h = 1/L * ones(1,L);
y_h = filter(h, 1, x);

figure();
subplot(2,1,1);
plot(n, x, '.-')

subplot(2,1,2);
plot(n, y_h, '.-')

% Filter with other filter
d = [0 0 0 1 0 0 0];
g = d - h;
y_g = filter(g, 1, x);

% could also have done
% d = [zeros(1, floor(L/2)) 1 zeros(1, floor(L/2))]

figure();
subplot(2,1,1);
plot(n, x, '.-')

subplot(2,1,2);
plot(n, y_g, '.-')

% Observing frequency response of 1D filters
H = fft(h, 128);
G = fft(g, 128);

figure();
subplot(2,2,1); stem(h);
axis([0 L (-1/L)*2 1]);
title('h(n), i.e. how the filter looks'); xlabel('Time index n'); ylabel('Amplitude');

subplot(2, 2, 2); stem(g);
axis([0 L (-1/L)*2 1]);
title('g(n), i.e. how the filter looks'); xlabel('Time index n'); ylabel('Amplitude');

subplot(2, 2, 3); 
plot(0:(2)/128:(1-1/128)*2,abs(H));
axis([0 1 0 max([abs(H), abs(G)])]);
title('H(\omega) Frequency Response'); xlabel('\omega / \pi'); ylabel('Amplitude');

subplot(2, 2, 4); 
plot(0:(2)/128:(1-1/128)*2,abs(G));
axis([0 1 0 max([abs(H), abs(G)])])
title('G(\omega) Frequency Response'); xlabel('\omega / \pi'); ylabel('Amplitude');

%% Filtering of 2D signals

I = imread('data/grace-hopper.tif');
x2 = double(I)/255;

figure();
imshow(x2);

L = 5;
h2 = 1/(L*L) * ones(L);
y_h2 = filter2(h2, x2); % Both h2 and x2 are 2D
figure();
imshow(y_h2);

% New filter
d2 = zeros(L);
d2(ceil(L/2),ceil(L/2)) = 1;
g2 = d2 - h2;
y_g2 = filter2(g2, x2);
figure();
imshow(y_g2);


% Observing the frequency response of the 2D filters
figure();

N = 32;
H2 = fftshift(fft2(h2, N, N));
G2 = fftshift(fft2(g2, N, N));
M = max(max([abs(H2), abs(G2)]));

n = -(L-1)/2:(L-1)/2;
w = -(N-1)/2:(N-1)/2;

subplot(2, 2, 1);
stem3(n, n, h2);
set(gca , 'ZLim', [-0.5, 1]);

subplot(2, 2, 2)
stem3(n, n, g2);
set(gca , 'ZLim', [-0.5, 1]);

subplot(2, 2, 3);
surf(w, w, abs(H2));

subplot(2, 2, 4);
surf(w, w, abs(G2));