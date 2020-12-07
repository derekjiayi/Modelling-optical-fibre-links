clc; clear; close all;

L = [10 20 30 40 50 60 70 80 90 100];
SNR_1 = [78.92	70.21	68.62	59.75	58.22	55.64	55.80	55.58	47.77	44.52];
SNR_10 = [65.55	57.96	58.56	55.91	57.68	50.95	51.64	49.64	45.56	36.95];
BER_1 = [4.46*10^-6	1.39*10^-5	1.72*10^-5	5.56*10^-5	6.8*10^-5	9.59*10^-5	9.39*10^-5	9.66*10^-5	2.74*10^-4	4.25*10^-4];
BER_10 = [2.58*10^-5	7.05*10^-5	6.51*10^-5	9.25*10^-5	9.31*10^-5	1.79*10^-4	1.63*10^-4	2.14*10^-4	3.69*10^-4	1.19*10^-3];
% plot(L,log10(BER),'.','Markersize',20);
semilogy(SNR_1,BER_1,'*','Markersize',50);hold on
semilogy(SNR_10,BER_10,'*','Markersize',50);
% xlim([0, 105]);
ylim([10^-5.5, 10^-2.8]);
set(gca,'FontName','Times New Roman','FontSize',22);
set(gca,'linewidth',1.5);
% lgd = legend('1 Gbps','10 Gbps', 'Location','southeast');
lgd = legend('1 Gbps','10 Gbps', 'Location','northeast');
legend boxoff
set(lgd,'FontName','Times New Roman','FontWeight','normal')
xlabel('L [{\itkm}]') 
ylabel('BER') 
% t.Units = 'inches';
% t.OuterPosition = [0.5 0.5 3 3];
f = gcf;
% exportgraphics(f,'BER.jpeg','Resolution',600)
