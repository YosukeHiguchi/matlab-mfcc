Fs = 8820
[wav, Fs] = audioread('a.wav');
t = 0: 1 / Fs: length(wav) / Fs;
plot(t(1: length(t) - 1) * 1000, wav); xlabel('時間[ms]'); ylabel('振幅');
saveas(gcf, 'sound.png');

center = fix(length(wav) / 2);
cuttime = 0.04;
wavdata = wav(center - fix(cuttime / 2 * Fs): center + fix(cuttime / 2 * Fs));
time = t(center - fix(cuttime / 2 * Fs): center + fix(cuttime / 2 * Fs));
subplot(3, 1, 1); plot(time * 1000, wavdata); ylabel('振幅');

han_window = 0.5 - 0.5 * cos(2 * pi * [0: 1 / length(wavdata): 1]);
wavdata = han_window(1: length(wavdata))' .* wavdata;
subplot(2, 1, 2); plot(time * 1000, wavdata); xlabel('時間[ms]'); ylabel('振幅');
saveas(gcf, 'han_window.png');

fftsize = 2048;
dft = fft(wavdata, fftsize);

Pdft = (real(dft) .^ 2) + (imag(dft) .^ 2);
Adft = sqrt(Pdft);

fscale = linspace(0, Fs, fftsize);
subplot(2, 1, 1); plot(fscale(1: fftsize / 2), Adft(1: fftsize / 2));
xlabel('周波数[Hz]'); ylabel('振幅スペクトル'); xlim([0, 5000]);
subplot(2, 1, 2); plot(fscale(1: fftsize / 2), Pdft(1: fftsize / 2));
xlabel('周波数[Hz]'); ylabel('パワースペクトル'); xlim([0, 5000]);
saveas(gcf, 'sound_spectre.png');

Angdft = atan2(imag(dft), real(dft));

Adft_log = log10(abs(dft));
Pdft_log = log10(abs(dft) .^ 2);
subplot(2, 1, 1); plot(fscale(1: fftsize / 2), Adft_log(1: fftsize / 2));
xlabel('周波数[Hz]'); ylabel('振幅スペクトル'); xlim([0, 5000]);
subplot(2, 1, 2); plot(fscale(1: fftsize / 2), Pdft_log(1: fftsize / 2));
xlabel('周波数[Hz]'); ylabel('振幅スペクトル'); xlim([0, 5000]);
saveas(gcf, 'log_spectre.png')

