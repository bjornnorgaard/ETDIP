%What is the fundamental/basic functions, for the Fourier transform when we are studing images?
%Sinoids in the spatial domain
%HKa Feb. 2015

clear, close all;

N = 16;
n = 0:N-1;
k = 2
x = sin((2*pi)/N*k*n);
fft(x) % We see the sinoid correspondes to a pair of par of non-zero values in the frequnecy domian

%   0 1 2 3 3 5 6 7 8 9 0 1 2 3 4 5 
ix=[0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0]
x = ifft(ix) % We could also get these using ifft
stem(x); title('ifft("point pair") = sine')

% Lets try this in 2 dimensions
M = 256;N = 256;
l = 2; k = 2;
for r = 0:M-1
    for s = 0:N-1
        I(r+1,s+1)=.5*sin(2*pi/M*(l*r)+2*pi/N*(k*s))+.5;
    end
end

figure, imshow(I); title('Sine wave') % Note the wave vector (l,k) is ortogonal to the wave

fI = fftshift(fft2(I));
figure, imshow(abs(fI)>.001); title('Spectrum of the sine wave'); % Only two points != 0 + DC
