clear;clc;

for N=1:37
    feval(@cd,feval(@sprintf,'%s%d','subj',N));
    
    T1_2mm = MRIread('T1_2mm.nii');
    T1_2mm_vol = T1_2mm.vol;
    
    Fieldmap = MRIread('Fieldmap.nii');
    Fieldmap_vol = Fieldmap.vol;
    
    Magnitude_image = MRIread('magnitude_image.nii');
    Magnitude_image_vol = Magnitude_image.vol;
    
    for x = 1 : size(T1_2mm_vol, 2)
        new_T1_2mm_vol(:,size(T1_2mm_vol, 2) - x + 1,:) = T1_2mm_vol(:,x,:);
        new_Fieldmap_vol(:,size(T1_2mm_vol, 2) - x + 1,:) = Fieldmap_vol(:,x,:);
        new_Magnitude_image_vol(:,size(T1_2mm_vol, 2) - x + 1,:) = Magnitude_image_vol(:,x,:);
    end
    
    flip_T1_2mm_vol = permute(new_T1_2mm_vol, [1 3 2]);
    flip_Fieldmap_vol = permute(new_Fieldmap_vol, [1 3 2]);
    flip_Magnitude_image_vol = permute(new_Magnitude_image_vol, [1 3 2]);
    
    Template_nii = MRIread('MNI305_T1_2mm.nii');
    Template_nii.vol = flip_T1_2mm_vol(4:91,5:92,15:113);
    MRIwrite(Template_nii, 'rT1_2mm.nii', 'double');
    
    Template_nii.vol = flip_Fieldmap_vol(4:91,5:92,15:113);
    MRIwrite(Template_nii, 'rFieldmap.nii', 'double');
    
    Template_nii.vol = flip_Magnitude_image_vol(4:91,5:92,15:113);
    MRIwrite(Template_nii, 'rMagnitude_image.nii', 'double');
    
    feval(@cd,'..');
end

