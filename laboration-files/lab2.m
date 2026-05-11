[x, fs] = jukebox; 

% pwelch(x, [], [], [], fs);

% sound(x, fs);

freq = [0.1 0.66 1.25 2.65] * 1000; % kHz

r = 0.95;
z = exp(-1j*2*pi*[freq , -freq]/fs);
p = exp(-1j*2*pi*[freq , -freq]/fs)*r;

b = poly(z);
a = poly(p);

y = filter(b, a, x);
pwelch(y, [], [], [], fs);

sound(y, fs)

save('filters/mynotch.mat', 'b', 'a');