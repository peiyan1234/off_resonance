function analyze_offresonance_sources(NIIfile_name,T1_2mm,small_mask,Kernal_sizes)

% analyze_offresonance_sources('Fieldmap_mni305','T1_2mm','small_mask',9:-2:3)
% This program analyzes the FIeldmap.nii by applying vSHARP
% algorithm, to seperate it into a part of satisfying Poisson's equation and
% another part of satisfying Laplace's equation.

GyromagneticRatio = 42.58*10^6;

input_nii=MRIread(sprintf('%s.nii',NIIfile_name));
original_field=input_nii.vol;

msk_nii=MRIread(sprintf('%s.nii',T1_2mm));
msk=(msk_nii.vol~=0);

small_nii=MRIread(sprintf('%s.nii',small_mask));
small_msk=small_nii.vol;

M=(original_field.*GyromagneticRatio)./(42.58*3);
fprintf('Purifying ...\r');

[M_int1,mask_sharp]=vSHARP(M,small_msk,Kernal_sizes);
Fieldmap_brain=M.*small_msk;
oROI_vSHARP=(M-M_int1).*small_msk;
iROI_vSHARP=M_int1.*small_msk;

matrix_size=size(M);
M_int2=LBV(M,small_msk,matrix_size,[2,2,2],1e-9);
oROI_LBV=(M-M_int2).*small_msk;
iROI_LBV=M_int2.*small_msk;

M_int3=RESHARP(M,small_msk,matrix_size,[2,2,2]);
oROI_RESHARP=(M-M_int3).*small_msk;
iROI_RESHARP=M_int3.*small_msk;

m=load('Fieldmap_data.mat');
lc=m.echo1_1m(1:10,1:10,1:10);
mag=MRIread('magnitude_image_2stepflirt.nii');
N_std=(std(reshape(lc,[1000,1]),0,1)./mag.vol).*small_msk;
M_int4=PDF(M,N_std,small_msk,matrix_size,[2,2,2],[0;0;1],1e-9);
oROI_PDF=(M-M_int4).*small_msk;
iROI_PDF=M_int4.*small_msk;

fprintf('Purification of fieldmap_mni305 has been done ...\r');

fprintf('save Fieldmap_brain Fieldmap_brain ...\r');
save Fieldmap_brain Fieldmap_brain
tempmat = load('Fieldmap_brain.mat');
Fieldmap_brain = tempmat.Fieldmap_brain;
tempnii = MRIread('small_mask.nii');
tempnii.vol = Fieldmap_brain;
MRIwrite(tempnii,'Fieldmap_brain.nii','double');
fprintf('Fieldmap_brain.nii has been saved.\r');

fprintf('save oROI_vSHARP oROI_vSHARP ...\r');
save oROI_vSHARP oROI_vSHARP
tempmat1 = load('oROI_vSHARP.mat');
oROI_vSHARP = tempmat1.oROI_vSHARP;
tempnii1 = MRIread('small_mask.nii');
tempnii1.vol = oROI_vSHARP;
MRIwrite(tempnii1,'oROI_vSHARP.nii','double');
fprintf('oROI_vSHARP.nii has been saved.\r');

fprintf('save iROI_vSHARP iROI_vSHARP ...\r');
save iROI_vSHARP iROI_vSHARP
tempmat2 = load('iROI_vSHARP.mat');
iROI_vSHARP = tempmat2.iROI_vSHARP;
tempnii2 = MRIread('small_mask.nii');
tempnii2.vol = iROI_vSHARP;
MRIwrite(tempnii2,'iROI_vSHARP.nii','double');
fprintf('iROI_vSHARP.nii has been saved.\r');

fprintf('save oROI_LBV oROI_LBV ...\r');
save oROI_LBV oROI_LBV
tempmat1 = load('oROI_LBV.mat');
oROI_LBV = tempmat1.oROI_LBV;
tempnii1 = MRIread('small_mask.nii');
tempnii1.vol = oROI_LBV;
MRIwrite(tempnii1,'oROI_LBV.nii','double');
fprintf('oROI_LBV.nii has been saved.\r');

fprintf('save iROI_LBV iROI_LBV ...\r');
save iROI_LBV iROI_LBV
tempmat2 = load('iROI_LBV.mat');
iROI_LBV = tempmat2.iROI_LBV;
tempnii2 = MRIread('small_mask.nii');
tempnii2.vol = iROI_LBV;
MRIwrite(tempnii2,'iROI_LBV.nii','double');
fprintf('iROI_LBV.nii has been saved.\r');

fprintf('save oROI_RESHARP oROI_RESHARP ...\r');
save oROI_RESHARP oROI_RESHARP
tempmat1 = load('oROI_RESHARP.mat');
oROI_RESHARP = tempmat1.oROI_RESHARP;
tempnii1 = MRIread('small_mask.nii');
tempnii1.vol = oROI_RESHARP;
MRIwrite(tempnii1,'oROI_RESHARP.nii','double');
fprintf('oROI_RESHARP.nii has been saved.\r');

fprintf('save iROI_RESHARP iROI_RESHARP ...\r');
save iROI_RESHARP iROI_RESHARP
tempmat2 = load('iROI_RESHARP.mat');
iROI_RESHARP = tempmat2.iROI_RESHARP;
tempnii2 = MRIread('small_mask.nii');
tempnii2.vol = iROI_RESHARP;
MRIwrite(tempnii2,'iROI_RESHARP.nii','double');
fprintf('iROI_RESHARP.nii has been saved.\r');

fprintf('save oROI_PDF oROI_PDF ...\r');
save oROI_PDF oROI_PDF
tempmat2 = load('oROI_PDF.mat');
oROI_PDF = tempmat2.oROI_PDF;
tempnii2 = MRIread('small_mask.nii');
tempnii2.vol = oROI_PDF;
MRIwrite(tempnii2,'oROI_PDF.nii','double');
fprintf('oROI_PDF.nii has been saved.\r');

fprintf('save iROI_PDF iROI_PDF ...\r');
save iROI_PDF iROI_PDF
tempmat2 = load('iROI_PDF.mat');
iROI_PDF = tempmat2.iROI_PDF;
tempnii2 = MRIread('small_mask.nii');
tempnii2.vol = iROI_PDF;
MRIwrite(tempnii2,'iROI_PDF.nii','double');
fprintf('iROI_PDF.nii has been saved.\r');

end