global Ts
Ts = 1/100;                % sampling time [s]
StopTime = 15;

% Mechanical parameter setting
flag_Unicycle_Nabeel = "Unicycle_V2.0";

% Intial Positions
global x0 q1_0 q2_0 q3_0 q4_0 q5_0 q5_d_0
q1_0 = -deg2rad(36); % initial roll (alpha) angle of unicycle to ground before stand up in degree
q2_0 = deg2rad(0); % initial pitch (beta) angle of unicycle to ground before stand up in degree
q3_0 = 0; % initial yaw (delta) angle of unicycle to ground before stand up in degree
q4_0 = 0; % initial wheel angle (theta) of unicycle to ground before stand up in degree
q5_0 = 0; % initial pendulum angle (gamma) of unicycle to ground before stand up in degree

q5_d_0 = convangvel(1250, 'rpm', 'rad/s'); % 250

x0 = [q1_0; 0; q2_0; 0; q3_0; 0; ...
      q4_0; 0; q5_0; q5_d_0; 0; 0; 0; 0];
g = 9.81;

%% Motor parameters
flag_saturateTorque = 1;
stall_torque = 1.6; %Nm
noload_rate = convangvel(1622, 'rpm', 'rad/s');

%% Sensor parameters
variance_IMUacc = 0.0049;
mean_IMUgyro = -0.0065;
variance_IMUgyro = 6.3956e-04;

estimator_bias = 0.5*(2*pi/360); % Encoder bias in degree
%noiserad_ndist.mu
%noiserad_ndist.sigma
%estimator_UsePulse = 0;
%estimator_PulseAmplitude = 0.06;

%% Unicycle_Nabeel mechanical parameters
if flag_Unicycle_Nabeel == "v2_5"
        %% IMU positions
    B_p1 = [ -0.048; -0.048; 0.119];
    B_p2 = [ 0.048; 0.048; 0.119];
    B_p3 = [ 0.048; -0.048; -0.004];
    B_p4 = [-0.048; 0.048; -0.004];
    Bp = [B_p1 B_p2 B_p3 B_p4];
    P = [[1;B_p1] [1;B_p2] [1;B_p3] [1;B_p4]];
    X = (P.')/(P*P.'); % Estimator IMU position matrix 
    Xp = X(:,1); % With Sebastian's estimator only first column is required for estimating gravity vector
end