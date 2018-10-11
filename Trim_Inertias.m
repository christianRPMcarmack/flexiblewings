% Calculates the changes in the inertia tensor, based on the trim solution.
% Currently, the code is set up to use data for mAEWing2 FEM 1.2. The trim
% inertia tensors at 23, 25, and 28 m/s 

load('Trim_Results.mat')% V and Y trim solutions Y is nV x 5 [alf,del,eta1-3]
load('mAEWing2_FEMv1p2.mat')

Jrigid=FEM.rigid_mass_matrix_inertial(4:6,4:6);%lb-in^2. In mAEWin2_FEM...

DeltaJ=zeros(3,3,3);
DeltaJ2=zeros(3,3,3);
for k=1:3% loop through three trim velocities Vtrim
    eta_trim=Y(k,3:5);% Data in Trim_Results.mat
    modei=1;
    for i=1:3
        DeltaJ(:,:,k)=DeltaJ(:,:,k)+Delta_J{modei}*eta_trim(i);
        modej=1;
        for j=1:3
            DeltaJ2(:,:,k)=DeltaJ2(:,:,k)+Delta_2J{modei,modej}*eta_trim(i)*eta_trim(j);
            modej=modej+2;
        end
        modei=modei+2;
    end
end

%Jrig_SF=Jrigid/32.17/12/12;% sl-ft^2
%DeltaJ_SF=DeltaJ/32.17/12/12;
%DeltaJ2_SF=DeltaJ2/32.17/12/12;
            
        
