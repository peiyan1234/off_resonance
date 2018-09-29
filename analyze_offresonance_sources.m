function analyze_offresonance_sources(NIIfile_name,T1_2mm,small_mask)

% analyze_offresonance_sources('Fieldmap_mni305','T1_2mm','small_mask')
% This program analyzes the FIeldmap.nii by applying the LBV method, 
% to seperate B into B_L and B_P.
%   Created by Pei-Yan, Li,
%   National Taiwan University.

GyromagneticRatio = 42.58*10^6;

input_nii=MRIread(sprintf('%s.nii',NIIfile_name));
original_field=input_nii.vol;

msk_nii=MRIread(sprintf('%s.nii',T1_2mm));
msk=(msk_nii.vol~=0);

small_nii=MRIread(sprintf('%s.nii',small_mask));
small_msk=small_nii.vol;

M=(original_field.*GyromagneticRatio)./(42.58*3);
fprintf('Purifying ...\r');

% matrix_size=size(M);
% M_int2=LBV(M,small_msk,matrix_size,[2,2,2],1e-9,8,0);
Fieldmap_brain=M.*small_msk;
% oROI_LBV=(M-M_int2).*small_msk;
% iROI_LBV=M_int2.*small_msk;

% m=load('Fieldmap_data.mat');
% lc=m.echo1_1m(1:10,1:10,1:10);
% mag=MRIread('magnitude_image_2stepflirt.nii');
% N_std=(std(reshape(lc,[1000,1]),0,1)./mag.vol).*small_msk;
% M_int4=PDF(M,N_std,small_msk,matrix_size,[2,2,2],[0;0;1],1e-9);
% oROI_PDF=(M-M_int4).*small_msk;
% iROI_PDF=M_int4.*small_msk;

% fprintf('Purification of fieldmap_mni305 has been done ...\r');

fprintf('save Fieldmap_brain Fieldmap_brain ...\r');
save Fieldmap_brain Fieldmap_brain
tempmat = load('Fieldmap_brain.mat');
Fieldmap_brain = tempmat.Fieldmap_brain;
tempnii = MRIread('small_mask.nii');
tempnii.vol = Fieldmap_brain;
MRIwrite(tempnii,'Fieldmap_brain.nii','double');
fprintf('Fieldmap_brain.nii has been saved.\r');

% fprintf('save oROI_LBV oROI_LBV ...\r');
% save oROI_LBV oROI_LBV
% tempmat1 = load('oROI_LBV.mat');
% oROI_LBV = tempmat1.oROI_LBV;
% tempnii1 = MRIread('small_mask.nii');
% tempnii1.vol = oROI_LBV;
% MRIwrite(tempnii1,'oROI_LBV.nii','double');
% fprintf('oROI_LBV.nii has been saved.\r');
% 
% fprintf('save iROI_LBV iROI_LBV ...\r');
% save iROI_LBV iROI_LBV
% tempmat2 = load('iROI_LBV.mat');
% iROI_LBV = tempmat2.iROI_LBV;
% tempnii2 = MRIread('small_mask.nii');
% tempnii2.vol = iROI_LBV;
% MRIwrite(tempnii2,'iROI_LBV.nii','double');
% fprintf('iROI_LBV.nii has been saved.\r');

% fprintf('save oROI_PDF oROI_PDF ...\r');
% save oROI_PDF oROI_PDF
% tempmat2 = load('oROI_PDF.mat');
% oROI_PDF = tempmat2.oROI_PDF;
% tempnii2 = MRIread('small_mask.nii');
% tempnii2.vol = oROI_PDF;
% MRIwrite(tempnii2,'oROI_PDF.nii','double');
% fprintf('oROI_PDF.nii has been saved.\r');
% 
% fprintf('save iROI_PDF iROI_PDF ...\r');
% save iROI_PDF iROI_PDF
% tempmat2 = load('iROI_PDF.mat');
% iROI_PDF = tempmat2.iROI_PDF;
% tempnii2 = MRIread('small_mask.nii');
% tempnii2.vol = iROI_PDF;
% MRIwrite(tempnii2,'iROI_PDF.nii','double');
% fprintf('iROI_PDF.nii has been saved.\r');

end