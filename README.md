# The Intrinsic Limitation of Shim Coils Capability

Written by:
Pei-Yan, Li.
Institute of Biomedical Engineering, 
National Taiwan University.
d05548014@ntu.edu.tw

This README file decribes the process from a measured raw data to an example of final results.

Processing environments: 
1. Matlab (R2015a, at Linux/MAC/Win10, https://www.mathworks.com/?s_tid=gn_logo), 
2. FSL toolbox (at Linux/MAC, https://fsl.fmrib.ox.ac.uk/fsl/fslwiki), 
3. Freesurfer toolbox (at Linux, https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki)

Step 1
1. meas_sample_AdjGre.dat can be download at here: URL
2. @ Linux/MAC/Win10, Matlab
3. >> off_resonance(1,'meas_sample_AdjGre',32,0.002,0.00446,0,0,0); 

Step 2
1. @ Linux/MAC, using FSL toolbox
2. >> bet magnitude_image.nii magnitude_image_bet_Af01mt -A -f 0.1 -m -t
3. @ Linux, using Freesurfer toolbox
4. >> mri_convert magnitude_image_bet_Af01mt_mask.nii.gz big_mask.nii

Step 3
1. @ Linux/MAC/Win10, Matlab
2. >> off_resonance(0,'meas_sample_AdjGre',32,0.002,0.00446,1,0,1);

Step 4
1. @ Linux/MAC, using FSL toolbox
2. bet magnitude_image_bet_Af01mt.nii.gz magnitude_image_bet_Af01mt_Bf025g0mt -B -f 0.25 -g 0 -m -t
3. >> flirt -in MNI305_T1_1mm.nii -ref MNI305_T1_2mm.nii -omat magnitude_image_bet_Af01mt_2stepflirt1.mat -bins 1024 -cost corratio -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 6
4. >> flirt -in magnitude_image_bet_Af01mt.nii.gz -ref MNI305_T1_1mm.nii -omat magnitude_image_bet_Af01mt_2stepflirt2.mat -bins 1024 -cost corratio -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 6
5. >> convert_xfm -concat magnitude_image_bet_Af01mt_2stepflirt1.mat -omat magnitude_image_bet_Af01mt_2stepflirt.mat magnitude_image_bet_Af01mt_2stepflirt2.mat
6. >> flirt -in magnitude_image_bet_Af01mt.nii.gz -ref MNI305_T1_2mm.nii -out magnitude_image_bet_Af01mt_2stepflirt.nii.gz -applyxfm -init magnitude_image_bet_Af01mt_2stepflirt.mat -interp trilinear
7. >> flirt -in magnitude_image_bet_Af01mt_Bf025g0mt.nii.gz -applyxfm -init magnitude_image_bet_Af01mt_2stepflirt.mat -out magnitude_image_bet_Af01mt_Bf025g0mt_2stepflirt.nii.gz -paddingsize 0.0 -interp trilinear -ref MNI305_T1_2mm.nii
8. >> flirt -in magnitude_image_bet_Af01mt_Bf025g0mt_mask.nii.gz -applyxfm -init magnitude_image_bet_Af01mt_2stepflirt.mat -out magnitude_image_bet_Af01mt_Bf025g0mt_mask_2stepflirt.nii.gz -paddingsize 0.0 -interp trilinear -ref MNI305_T1_2mm.nii
9. @ Linux, using Freesurfer toolbox
10. >> mri_convert magnitude_image_bet_Af01mt_2stepflirt.nii.gz T1_2mm.nii
11. >> mri_convert magnitude_image_bet_Af01mt_Bf025g0mt_mask_2stepflirt.nii.gz small_mask.nii

Step 5
1. @ Linux/MAC/Win10, Matlab
2. >> 
