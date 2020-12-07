clc; clear; close all

e = 1.6*(10^(-19));                                 % Electron
P_0 = 1;                                            % Initial power [mW]
N = 1000;                                           % Sampled points
min_1 = 0;                                          % Minimum time
max_1 = 2;                                          % Maximum time
t_1 = linspace(min_1,max_1,N);                      % Time space [ns]
min_10 = -1;                                        % Minimum time
max_10 = 1;                                         % Maximum time
t_10 = linspace(min_10,max_10,N);                   % Time space [ns]
tau_0_1 = 0.5;                                      % The width of the Gaussian pulse
tau_0_10 = 0.05;                                    % The width of the Gaussian pulse
D = 0.015;                                          % Dispersion coefficient [ns/(km.nm)]
delta_lambda = 0.2;                                 % Optical linewidth
Pulse_sep_1 = 1;                                    % Pulse separation [ns]
Pulse_sep_10 = 0.1;                                 % Pulse separation [ns]
b_1 = 1*(10^9);                                     % Bitrate [Hz]
b_10 = 10*(10^9);                                   % Bitrate [Hz]
B_width_1 = b_1/2;                                  % Bandwidth of the detector [Hz]
B_width_10 = b_10/2;                                % Bandwidth of the detector [Hz]
NEP = 2;                                            % [pW/sqrt(Hz)]
Th_1 = NEP*(10^(-9))*sqrt(B_width_1);               % Thermal noise [mW]
Sh_1 = sqrt(2*e*B_width_1);                         % Shot noise parameter
Th_10 = NEP*(10^(-9))*sqrt(B_width_10);             % Thermal noise [mW]
Sh_10 = sqrt(2*e*B_width_10);                       % Shot noise parameter
loss = 0.3;                                         % [dB/km]
R = 0.7;                                            % Responsivity of the detector
S = [0 0 0; 0 0 1; 0 1 0; 1 0 0; 0 1 1; 1 0 1; 1 1 0; 1 1 1];
SNR_1 = [0 0 0 0 0 0 0 0 0 0];
L = 10;                                             % Length of the fibre [km]
for k = 1:10
    figure(k);
%     SNR = 0;
    % 1 Gbps
    for i = 1:8
            P = zeros(1,N);
            T = 0;                                          % Time interval
            for j = 1:3
                delta_tau = D*delta_lambda*L;               % Dispersion
                tau = sqrt(tau_0_1^2+delta_tau^2);          % Total pulse width                       
                P_T = P_0*exp(-(t_1-T).^2/(2*tau^2));
                T = T+Pulse_sep_1;
                if S(i,j)==1
                    P = P+P_T;
                else
                    P = P+0;
                end
            end
            P = P*(10^(-loss*L/10));                        % Loss   
            noise = randn(size(P));
            noise_Th = Th_1 * noise;                        % Thermal noise
            noise_Sh = (Sh_1 * sqrt(R*P).*noise)/R;         % Shot noise 

            sub1 = subplot(2,1,1);
            P_n = P+noise_Th+noise_Sh;
            plot(t_1,P_n,'.','Markersize',9);               % Noisy signal
            hold on
    end
    % 10 Gbps    
    for i = 1:8
        P = zeros(1,N);
        T = 0;                                              % Time interval
        for j = 1:3
            delta_tau = D*delta_lambda*L;                   % Dispersion
            tau = sqrt(tau_0_10^2+delta_tau^2);             % Total pulse width                       
            P_T = P_0*exp(-(t_10-T).^2/(2*tau^2));
            T = T+Pulse_sep_10;
            if S(i,j)==1
                P = P+P_T;
            else
                P = P+0;
            end
        end
        P = P*(10^(-loss*L/10));                            % Loss   
        noise = randn(size(P));
        noise_Th = Th_1 * noise;                            % Thermal noise
        noise_Sh = (Sh_1 * sqrt(R*P).*noise)/R;             % Shot noise 
        
        sub2 = subplot(2,1,2);
        P_n = P+noise_Th+noise_Sh;
        plot(t_10,P_n,'.','Markersize',9);                  % Noisy signal
        hold on
        
%       SNR = SNR + max(P./abs(noise_Th+noise_Sh));         % [dB]
        
    end
%   SNR_1(k) = SNR/9;
%   BER_1(k) = 0.5*erfc(sqrt(SNR_1(k)/8));
%   SNR_1(k) = 10*log10(SNR_1(k));
    L = L+10;
    
    xlabel(sub1,'Time [{\itns}]');
    ylabel(sub1,'Power [{\itmW}]');
    xlabel(sub2,'Time [{\itns}]') 
    ylabel(sub2,'Power [{\itmW}]') 
    xlim(sub1,[0, 2]);
%   xlim(sub2,[-0.6, 0.8]);
    xlim(sub2,[0, 0.2]);
    set(sub2,'XTick',(-0.6:0.2:0.8));
%   ylim([-0.05, 1.4*10^-3]);
%   ylim(sub2,[-1*10^-3, 6*10^-3]);
    set(sub1,'FontName','Times New Roman','FontSize',22,'linewidth',1.5);
    set(sub2, 'FontName','Times New Roman','FontSize',22,'linewidth',1.5);
end
f = gcf;
% exportgraphics(f,'95km_1_10Gbps.jpeg','Resolution',600)
