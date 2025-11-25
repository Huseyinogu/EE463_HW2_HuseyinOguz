% Parameters
r = 0.250;       % Inductor ESR in Ohms
R_load = 50;     % Load Resistance in Ohms
D = 0:0.001:0.99; % Duty Cycle vector

% 1. Ideal Efficiency Calculation (r = 0)
% Efficiency is always 100% (or 1)
Eff_Ideal = ones(size(D)); 

% 2. Real Efficiency Calculation (with ESR)
% Derived Formula: 1 / ( 1 + r / (R_load * (1-D)^2) )
ratio = r / R_load;
Eff_Real = 1 ./ ( 1 + ratio ./ ((1 - D).^2) );

% Plotting
figure;
plot(D, Eff_Ideal * 100, 'b--', 'LineWidth', 2); hold on; % Ideal (Blue Dashed)
plot(D, Eff_Real * 100, 'r-', 'LineWidth', 2);           % Real (Red Solid)
grid on;

% Formatting
title('Boost Converter Efficiency: Ideal vs. With ESR');
xlabel('Duty Cycle (D)');
ylabel('Efficiency (%)');
legend('Ideal Efficiency (r=0)', ['Real Efficiency (r=' num2str(r) '\Omega)'], 'Location', 'SouthWest');
xlim([0 1]);
ylim([0 105]);

% Mark the drop-off point (e.g., where Efficiency drops below 90%)
idx_90 = find(Eff_Real < 0.90, 1);
if ~isempty(idx_90)
    plot(D(idx_90), Eff_Real(idx_90)*100, 'ko', 'MarkerFaceColor', 'k');
    text(D(idx_90)-0.2, Eff_Real(idx_90)*100-5, sprintf('Drops <90%% @ D=%.2f', D(idx_90)));
end