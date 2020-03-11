close all;
[x,fs]=audioread('motor.mp3');
Nfft = 20480;
[Pxx,f] = pwelch(x,gausswin(Nfft),Nfft/2,Nfft,fs);
[~,loc] = max(Pxx);
subplot(2,1,1);
plot(f,Pxx);
ylabel('PSD'); xlabel('Frequency (Hz)');
xlim([0 500])
freq = f(loc(1));
title(['Original sound =',num2str(freq),' Hz'])

y=modulate(x,freq-220,fs,'amssb');
[Pxx,f] = pwelch(y,gausswin(Nfft),Nfft/2,Nfft,fs);
[~,loc] = max(Pxx);
subplot(2,1,2);
plot(f,Pxx);
ylabel('PSD'); xlabel('Frequency (Hz)');
title('Modified sound')
xlim([0 500])
freq2 = f(loc(1));
title(['Modified sound =',num2str(freq2),' Hz'])

disp(freq-freq2)


