wczytywanie()

subplot(2,2,1)
plot(data)
title('Przebieg sygna³u EKG z zak³óceniami i przesuniêt¹ lini¹ bazow¹')
grid on
xlabel('Próbka')
ylabel('LSB')
legend('EKG')
hold on




% wyrównanie poziomu
[p,s,mu] = polyfit((1:length(data))',data,6);
y = polyval(p,(1:length(data))',[],mu);

ECG_data = data - y;
plot(y,'-r')
hold off

subplot(2,2,2)
plot(ECG_data); grid on
%ax = axis; axis([ax(1:2) -1.2 1.2])
title('Sygna³ z wyrównan¹ lini¹ bazow¹')
xlabel('Próbka'); ylabel('LSB')
legend('Sygna³ EKG')
                                    
% wykres3 - R + S
subplot(2,2,3)
plot(ECG_data); grid on
title('Za³amki R oraz S')
xlabel('Próbka'); ylabel('LSB')


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
title('Wyg³adzony przebieg i próba wyszukania za³amków Q')
xlabel('Próbka'); ylabel('LSB')
%   ax = axis; axis([0 1850 -1.1 1.1])
legend('EKG po wyg³adzeniu','Q','R','S');

fprintf('Pozycje za³amków Q:\n')
for N=1:length(locs_Qwave)
    fprintf('%d ', locs_Qwave(N))
end
fprintf('\n');
fprintf('Pozycje za³amków R:\n')
for N=1:length(locs_Rwave)
    fprintf('%d ', locs_Rwave(N))
end
fprintf('\n');
fprintf('Pozycje za³amków S:\n')
for N=1:length(locs_Swave)
    fprintf('%d ', locs_Swave(N))
end
fprintf('\nPodane wy¿ej wartoœci s¹ numerami próbek dla jednego z 2 kana³ów EKG\n');





