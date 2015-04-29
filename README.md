# Matlab-Guitar-Tuner
This is a very simple Matlab application used to tune a guitar.

# How to use it ?
Simply launch the application with Matlab and plug the jack wire to the microphone connection of your computer and choose the string to tune. Hit the string and check what has to be done on the Gui.

# The backend
The detected signal is transformed via the Fast Fourier Transform to find the frequency of the signal and this frequency is compared to the reference frequency of the string to tune.
* xfft = abs(fft(data));
* [mx,freq0]=max(xfft);

freq0 is the actual frequency of the string.
