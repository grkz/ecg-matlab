% wyczyszczenie ekranu
clear all
clc
close all
% nazwa pliku .dat (musi byæ w tym samym katalogu co skrypt!
filename = '215.dat';

fid=fopen(filename,'r');

% czas odpowiada samples / 360 (próbkowanie) / 2 (bo s¹ dwa kana³y)
samples = 2*1200;
f=fread(fid,samples,'ubit12');

% bierzemy dane tylko z jednego kana³u (co druga próbka)
data=f(1:2:length(f));