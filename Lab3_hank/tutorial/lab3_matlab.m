var = 'C:\Users\lamn7\Desktop\secret_code_group17.wav';
[x,fs] = audioread(var);
L = length(x);
NFFT = 2^nextpow2(L);
X = fft(x,NFFT)/fs;
fs


f = fs/2*linspace(0,1,NFFT/2+1);
figure;
plot(f,2*abs(X(1:NFFT/2+1)));

fkill = 0.5;
coeff = firgr(14,[0 fkill-0.1 fkill fkill+0.1 1],[1 1 0 1 1],{'n' 'n' 's' 'n' 'n'});
figure;
freqz(coeff,1);

fid = fopen('C:\Users\lamn7\Desktop\tut3_coeff','w');

for i=1:length(coeff)
    fprintf(fid,'coeff[%3.0f]=%10.0f;\n',i-1,coeff(i)*32768);
end

fclose(fid);

y = filtfilt(coeff,1,x);

Y = fft(y,NFFT)/L;

sound(3*x,fs);

pause(5);

sound(3*y,fs);

figure; subplot(2,1,1);

plot(f,2*abs(X(1:NFFT/2+1)));
xlabel('frequency (Hz)');
ylabel('|X(f|');

subplot(2,1,2);
plot(f,2*abs(Y(1:NFFT/2+1)));
xlabel('frequency(Hz)');

audiowrite('C:\Users\lamn7\Desktop\tut3_filtered.wav',y,fs);