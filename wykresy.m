wczytywanie()

subplot(2,2,1)
plot(data)
title('Przebieg sygna�u EKG z zak��ceniami i przesuni�t� lini� bazow�')
grid on
xlabel('Pr�bka')
ylabel('LSB')
legend('EKG')
hold on




% wyr�wnanie poziomu
[p,s,mu] = polyfit((1:length(data))',data,6);
y = polyval(p,(1:length(data))',[],mu);

ECG_data = data - y;
plot(y,'-r')
hold off

subplot(2,2,2)
plot(ECG_data); grid on
%ax = axis; axis([ax(1:2) -1.2 1.2])
title('Sygna� z wyr�wnan� lini� bazow�')
xlabel('Pr�bka'); ylabel('LSB')
legend('Sygna� EKG')
                                    
% wykres3 - R + S
subplot(2,2,3)
plot(ECG_data); grid on
title('Za�amki R oraz S')
xlabel('Pr�bka'); ylabel('LSB')


% RS detekcja
[~,locs_Rwave] = findpeaks(ECG_data,'MinPeakHeight',100,'MinPeakDistance',100);
                                
ECG_inverted = -ECG_data;
[~,locs_Swave] = findpeaks(ECG_inverted,'MinPeakHeight',100,'MinPeakDistance',100);


hold on
plot(locs_Rwave,ECG_data(locs_Rwave),'rv','MarkerFaceColor','r');
plot(locs_Swave,ECG_data(locs_Swave),'rs','MarkerFaceColor','b');
%axis([0 1850 -1.1 1.1]); grid on;
legend('EKG','R','S');
hold off




% WYKRES 4
smoothECG = sgolayfilt(ECG_data,7,21);


[~,min_locs] = findpeaks(-smoothECG,'MinPeakDistance',40);

% Peaks between -0.2mV and -0.5mV
locs_Qwave = min_locs(smoothECG(min_locs)>-35 & smoothECG(min_locs)<-20);

subplot(2,2,4)
hold on
plot(smoothECG);
plot(locs_Qwave,smoothECG(locs_Qwave),'rs','MarkerFaceColor','g');
plot(locs_Rwave,smoothECG(locs_Rwave),'rv','MarkerFaceColor','r');
plot(locs_Swave,smoothECG(locs_Swave),'rs','MarkerFaceColor','b');
grid on
title('Wyg�adzony przebieg i pr�ba wyszukania za�amk�w Q')
xlabel('Pr�bka'); ylabel('LSB')
%   ax = axis; axis([0 1850 -1.1 1.1])
legend('EKG po wyg�adzeniu','Q','R','S');

fprintf('Pozycje za�amk�w Q:\n')
for N=1:length(locs_Qwave)
    fprintf('%d ', locs_Qwave(N))
end
fprintf('\n');
fprintf('Pozycje za�amk�w R:\n')
for N=1:length(locs_Rwave)
    fprintf('%d ', locs_Rwave(N))
end
fprintf('\n');
fprintf('Pozycje za�amk�w S:\n')
for N=1:length(locs_Swave)
    fprintf('%d ', locs_Swave(N))
end
fprintf('\nPodane wy�ej warto�ci s� numerami pr�bek dla jednego z 2 kana��w EKG\n');





