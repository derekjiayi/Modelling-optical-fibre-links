clc; clear; close all

t = linspace(0,4,100);                                  % Time space 0-5 ns
tau_0 = 0.5;                                            % The width of the Gaussian pulse
D = 0.015;                                              % Dispersion coefficient [ns/(km.nm)]
delta_lambda = 0.1;                                     % Optical linewidth

L = 50;                                                 % Length of the fibre (50km)
delta_tau = D*delta_lambda*L;                           % Dispersion induced pulse broadening
tau = sqrt(tau_0^2+delta_tau^2);                        % Total pulse width
P = exp(-t.^2/(2*tau^2));                               % Pulse without peak
fun = @(t)exp(-t.^2/(2*tau^2));
int = integral(fun,0,5);                                % Integral of the pulse
P_0 = int;                                              % Normalization
P = P_0*P/int;
plot(t,P,'Color',[0.93333 0.25098 0],'linewidth',3);    % 10km red line
hold on

L_1 = L+90;                                             % Length of the fibre (100km)
delta_tau_1 = D*delta_lambda*L_1;
tau_1 = sqrt(tau_0^2+delta_tau_1^2);
P_1 = exp(-t.^2/(2*tau_1^2));
fun_1 = @(t)exp(-t.^2/(2*tau_1^2));
int_1 = integral(fun_1,0,5);
P_1 = (P_0/int_1)*P_1;
plot(t,P_1,'Color',[0 0.60392 0.80392],'linewidth',3);  % 100km blue line
hold on

L_2 = L+190;                                            % Length of the fibre (200km)
delta_tau_2 = D*delta_lambda*L_2;
tau_2 = sqrt(tau_0^2+delta_tau_2^2);
P_2 = exp(-t.^2/(2*tau_2^2));
fun_2 = @(t)exp(-t.^2/(2*tau_2^2));
int_2 = integral(fun_2,0,5);
P_2 = (P_0/int_2)*P_2;
plot(t,P_2,'Color',[0.12549	0.69804	0.66667],'linewidth',3);% 100km green line


lgd = legend('50km', '100km', '200km','Location','northeast');
legend boxoff
set(lgd,'FontName','Times New Roman','FontWeight','normal')
xlabel('Time [{\itns}]') 
ylabel('Normalised Power') 
%xlim([0, 2]);
ylim([0, 1]);
set(gca,'FontName','Times New Roman','FontSize',22);
set(gca,'linewidth',1.5);
% t.Units = 'inches';
% t.OuterPosition = [0.5 0.5 3 3];
% f = gcf;
% exportgraphics(f,'1.jpeg','Resolution',600)
