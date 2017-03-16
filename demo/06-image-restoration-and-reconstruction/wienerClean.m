%  [RES,EMSE] = wienerClean(IM,PWR)
% 
% Use a Wiener filter to remove noise from IM, assuming an image power
% spectrum of a/f^pwr.  PWR is optional, and defaults to a value of 2.
% RES is the cleaned image.  Also returns the expected mean squared
% error, as predicted by the fitted power spectral model.

function [res,emse] = wienerClean(im,pwr)

if (exist('pwr') ~= 1)
  pwr = .23;
end

dims = size(im);
dims2  = ceil((dims+1)/2);

[xramp,yramp] = meshgrid(2*pi*([1:dims(2)]-dims2(2))/dims(2), ...
    2*pi*([1:dims(1)]-dims2(1))/dims(1));
spec1 = sqrt(xramp.^2 + yramp.^2);
spec1(dims2(1),dims2(2))  = 2*spec1(dims2(1),dims2(2)+1); % avoid divide-by-zero error 
spec1 = (1./spec1).^pwr;  % we'll fit the Fourier specitude
clear xramp yramp

spec2 = ones(dims);

imfft = fftshift(fft2(im));
imSpec = abs(imfft).^2;          % Fourier 

% Compute [a,b]:
vspec1 = spec1; vspec1(dims2(1),dims2(2)) = 0;
vspec2 = spec2; vspec2(dims2(1),dims2(2)) = 0;
basis = [vspec1(:), vspec2(:)];
clear vspec1 vspec2
basis(dims2(1) + dims(1)*(dims2(2)-1), :)  = 0;
wts = inv(basis'*basis) * basis'*imSpec(:);

if (wts(2) < 0)
  wts(2) = 0;
  warning('Setting negative estimate of noise variance to zero');
end

%Signal and noise variances are squares 
filt = wts(1).*spec1 ./ ( wts(1).*spec1 + wts(2).*spec2 + eps); 
filt(dims2(1),dims2(2)) = 1;
%showIm(filt)

cleanedfft = filt .* imfft;
resfft = ifft2(ifftshift(cleanedfft));
if (var2(imag(resfft)) > 10*eps)
  error('Faulty filter: produces significant imaginary part');
end

res = real(resfft);

%% Scale factor of (Nx*Ny) due to matlab's fft scaling
%% I.E., in matlab, Parseval's rule is E(f(x).^2) = E(F(w).^2)/(Nx * Ny);
emse = mean2( (wts(1)*spec1) .* (1-filt) ) / prod(dims);
%-- END wienerClean --------------------------------------------
