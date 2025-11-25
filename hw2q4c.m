% Parameters
r = 0.250;       % Inductor ESR in Ohms (250 mOhm)
R_load = 34.56;     % Load Resistance in Ohms (Assumed)
D = 0:0.01:0.99; % Duty Cycle vector (0 to 95%)

% 1. Ideal Gain Calculation (r = 0)
% Formula: 1 / (1-D)
Gain_Ideal = 1 ./ (1 - D);

% 2. Non-Ideal Gain Calculation (with ESR)
% Formula Derived above
ratio = r / R_load;
Gain_Real = (1 - D) ./ ( (1 - D).^2 + ratio );

% Plotting
figure;
plot(D, Gain_Ideal, 'b--', 'LineWidth', 2); hold on;
plot(D, Gain_Real, 'r-', 'LineWidth', 2);
grid on;

% Formatting
title('Boost Converter Voltage Gain: Ideal vs. With ESR');
xlabel('Duty Cycle (D)');
ylabel('Voltage Gain (Vout / Vin)');
legend('Ideal Gain (r=0)', ['Real Gain (r=' num2str(r) '\Omega)']);
xlim([0 1]);
ylim([0 20]); % Limiting Y-axis to see the divergence clearly

% Mark the maximum point of the real curve
[max_gain, max_idx] = max(Gain_Real);
plot(D(max_idx), max_gain, 'ko', 'MarkerFaceColor', 'k');
text(D(max_idx), max_gain+1, sprintf('Max Gain @ D=%.2f', D(max_idx)));