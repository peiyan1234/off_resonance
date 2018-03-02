function analyze_offresonance_sources(NIIfile_name,T1_2mm,small_mask,Kernal_sizes,iterations)

% analyze_offresonance_sources('Fieldmap_mni305','T1_2mm','small_mask',9:-2:3,1)
% This program analyzes the FIeldmap.nii by applying vSHARP
% algorithm, to seperate it into a part of satisfying Poisson's equation and
% another part of satisfying Laplace's equation.

input_nii=MRIread(sprintf('%s.nii',NIIfile_name));
original_field=input_nii.vol;

msk_nii=MRIread(sprintf('%s.nii',T1_2mm));
msk=(msk_nii.vol~=0);

small_nii=MRIread(sprintf('%s.nii',small_mask));
small_msk=small_nii.vol;

M_bkg=zeros(size(original_field));
M_int=original_field;
fprintf('Purifying ...\r');
for r=1:iterations
    fprintf('This is during %d-th time of iterations ...\r',r);
    [M_int,mask_sharp]=vSHARP(M_int,msk,Kernal_sizes);
end
Poisson_piece=M_int;
Fieldmap_brain=original_field.*small_msk;
Fieldmap_purified=(original_field-Poisson_piece).*small_msk;
Poisson_piece=Poisson_piece.*small_msk;
fprintf('Purification of fieldmap_mni305 has been done ...\r');

fprintf('save Fieldmap_brain Fieldmap_brain ...\r');
save Fieldmap_brain Fieldmap_brain
tempmat = load('Fieldmap_brain.mat');
Fieldmap_brain = tempmat.Fieldmap_brain;
tempnii = MRIread('small_mask.nii');
tempnii.vol = Fieldmap_brain;
MRIwrite(tempnii,'Fieldmap_brain.nii','double');
fprintf('Fieldmap_brain.nii has been saved.\r');

fprintf('save Fieldmap_purified Fieldmap_purified ...\r');
save Fieldmap_purified Fieldmap_purified
tempmat1 = load('Fieldmap_purified.mat');
Fieldmap_purified = tempmat1.Fieldmap_purified;
tempnii1 = MRIread('small_mask.nii');
tempnii1.vol = Fieldmap_purified;
MRIwrite(tempnii1,'Fieldmap_purified.nii','double');
fprintf('Fieldmap_purified.nii has been saved.\r');

fprintf('save Poisson_piece Poisson_piece ...\r');
save Poisson_piece Poisson_piece
tempmat2 = load('Poisson_piece.mat');
Poisson_piece = tempmat2.Poisson_piece;
tempnii2 = MRIread('small_mask.nii');
tempnii2.vol = Poisson_piece;
MRIwrite(tempnii2,'Poisson_piece.nii','double');
fprintf('Poisson_piece.nii has been saved.\r');

end