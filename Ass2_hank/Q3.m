low_freq = 50;
hi_freq = 60;
sampling_freq = 400;
bound = [low_freq,hi_freq].*2/400;
b = fir1(50,bound,'stop');
fvtool(b,1);