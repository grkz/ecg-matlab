% wyczyszczenie ekranu
clear all
clc
close all
% nazwa pliku .dat (musi by� w tym samym katalogu co skrypt!
filename = '215.dat';

fid=fopen(filename,'r');

% czas odpowiada samples / 360 (pr�bkowanie) / 2 (bo s� dwa kana�y)
samples = 2*1200;
f=fread(fid,samples,'ubit12');

% bierzemy dane tylko z jednego kana�u (co druga pr�bka)
data=f(1:2:length(f));