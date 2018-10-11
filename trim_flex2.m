function [Yref] = trim_flex2(AEClong,aero,Vinf)
% Calculates the trim solution (longitudinal), including 1st 3 symmetric 
% modes. Sw, cbar & gen mass are set for mAEWing2. Change for other vehicle.
%   Inputs are the longitudinal aeroelastic coefficients, RB coefficients,
%   weight (lb), vib frequencies (rad/sec), and Vinf (fps).

load('mAEWing2_FEMv1p2.mat')
W=FEM.model_total_weight;
omega=[ModeShape.natural_frequency(7),ModeShape.natural_frequency(9),ModeShape.natural_frequency(11)];% symmetric modes

CLalf=aero(1);CMalf=aero(2);
CLdel=aero(3:8);CMdel=aero(9:14);
CL0=0;CM0=0;

CLeta=AEClong(1,:);
CMeta=AEClong(3,:);% three vib modes
CQalf=AEClong(5,:);
CQdel=AEClong(7:12,:);% dels x modes
CQeta=AEClong(13:15,:);% modes x modes

S=18.375;cbar=19.5/12;gmass=1/12;% mAEWing2, gmass in sl-ft^2
rho=0.0023081;qS=0.5*rho*Vinf*Vinf*S;qSc=qS*cbar;% 1000 ft altitude

RHS=[W/qS-CL0;-CM0;zeros(3,1)];

ndel=4;% select control surface to use for trim (3,4,or 5)
Mat=[CLalf,CLdel(ndel),CLeta;CMalf,CMdel(ndel),CMeta;
    CQalf(1),CQdel(ndel,1),(CQeta(1,1)-(gmass*omega(1)^2)/qSc),CQeta(1,2:3);
    CQalf(2),CQdel(ndel,2),CQeta(2,1),(CQeta(2,2)-(gmass*omega(2)^2)/qSc),CQeta(2,3);
    CQalf(3),CQdel(ndel,3),CQeta(3,1:2),(CQeta(3,3)-(gmass*omega(3)^2)/qSc)];

Yref=Mat\RHS;% Y=alf,del,eta1-3
end

