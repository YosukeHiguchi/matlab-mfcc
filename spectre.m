% complex wave
Fs = 8820;
time = 0: 1 / Fs: 0.05;
sinwav_1 = 1.2 * sin(2 * pi * 130 * time);
coswav_1 = 0.9 * sin(2 * pi * 200 * time);
sinwav_2 = 1.8 * sin(2 * pi * 260 * time);
coswav_2 = 1.4 * sin(2 * pi * 320 * time);
wavdata = 1.4 + [sinwav_1 + coswav_1 + sinwav_2 + coswav_2];

plot(time * 1000, wavdata); xlabel('time[ms]'); ylabel('amplitude');
saveas(gcf,'wave.png');


% fourier transform
fftsize = 2048;
dft = fft(wavdata, fftsize);
% amplitude spectre
Adft = sqrt(dft .* conj(dft));
% power spectre
Pdft = abs(dft) .^ 2;
% frequency scale
fscale = linspace(0, Fs, fftsize);

subplot(2,1,1); plot(fscale(1:fftsize/2), Adft(1:fftsize/2)); 
xlabel('周波数[Hz]'); ylabel('振幅スペクトル'); xlim([0 1000]);
subplot(2,1,2); plot(fscale(1:fftsize/2), Pdft(1:fftsize/2)); 
xlabel('周波数[Hz]'); ylabel('パワースペクトル'); xlim([0 1000]);
saveas(gcf,'fft.png');


% plot in decibel
subplot(2, 1, 1); plot(fscale(1: fftsize / 2), 20 * log10(Adft(1: fftsize / 2)));
xlabel('周波数[Hz]'); ylabel('振幅スペクトル[dB]'); xlim([0 1000]);
subplot(2, 1, 2); plot(fscale(1: fftsize / 2), 20 * log10(Pdft(1: fftsize / 2)));
xlabel('周波数[Hz]'); ylabel('パワースペクトル[dB]'); xlim([0 1000]);
saveas(gcf, 'fft_db.png')

% inverse fourier transform
newdata = ifft(dft);
subplot(1, 1, 1);
plot(time * 1000, newdata(1: length(wavdata))); xlabel('時間[ms]'); ylabel('振幅');
saveas(gcf, 'ifft.png')
