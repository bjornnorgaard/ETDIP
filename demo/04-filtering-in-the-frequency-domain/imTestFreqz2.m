%Testing frequence response of different filters
%HKa Feb. 2015

clear; close all;

h=fspecial('average',3);
figure, freqz2(h);title('Amp. reponse of Average-filter')
pause;

h=fspecial('laplacian',0);
figure, freqz2(h);title('Amp. reponse of Laplacian-filter')
pause;

h=fspecial('sobel');
figure, freqz2(h);title('Amp. reponse of Sobel-filter')
pause;

h=fspecial('prewitt');
figure, freqz2(h);title('Amp. reponse of Prewitt-filter')
pause;

close all;
