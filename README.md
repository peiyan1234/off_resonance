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
1. meas_sample_AdjGre.dat can be downloaded at here: https://goo.gl/aotPQr
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
1. MPRAGE_sample (#0001~#0192) can be downloaded at here: https://goo.gl/aotPQr
2. @ Linux/MAC, using Freesurfer toolbox
3. >> recon-all -all -i sample.0001.IMA -subject subject_recon
4. >> mri_convert subject_recon/mri/T1.mgz T1.nii

Step 5
1. @ Linux/MAC, using FSL toolbox
2. >> flirt -in MNI305_T1_1mm.nii -ref MNI305_T1_2mm.nii -omat subject_T1_2stepflirt1.mat -bins 1024 -cost normcorr -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 6
3. >> flirt -in T1.nii -ref MNI305_T1_1mm.nii -omat subject_T1_2stepflirt2.mat -bins 1024 -cost normcorr -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 6
4. >> convert_xfm -concat subject_T1_2stepflirt1.omat -omat subject_T1_2stepflirt.mat subject_T1_2stepflirt2.mat
5. >> flirt -in T1.nii -ref MNI305_T1_2mm.nii -out subject_T1_2stepflirt.nii -applyxfm -init subject_T1_2stepflirt.mat -interp trilinear
6. >> flirt -in magnitude_image_bet_Af01mt.nii.gz -ref subject_T1_2stepflirt.nii.gz -out magnitude_image_bet_Af01mt_mni305.nii.gz -omat magnitude_image_bet_Af01mt_mni305.mat -bins 1024 -cost corratio -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 6
7. >> flirt -in Fieldmap.nii -applyxfm -init magnitude_image_bet_Af01mt_mni305.mat -out Fieldmap_mni305.nii -paddingsize 0.0 -interp trilinear -ref MNI305_T1_2mm.nii
8. >> bet subject_T1_2stepflirt subject_T1_2stepflirt_brain -R -f 0.4 -g 0 -m -t
9. @ Linux/MAC, using Freesurfer
10. >> mri_convert subject_T1_2stepflirt.nii.gz T1_2mm.nii
11. >> mri_convert subject_T1_2stepflirt_brain_mask.nii.gz small_mask.nii
12. >> mri_convert Fieldmap_mni305.nii.gz Fieldmap_mni305.nii


Step 6
1. @ Linux/MAC/Win10, Matlab
2. >> 
