# The Intrinsic Limitation of Shim Coils Capability

Created by:
Pei-Yan, Li.
Institute of Biomedical Engineering, 
National Taiwan University.
d05548014@ntu.edu.tw

This README file decribes the process from a measured raw data to an example of final results.

Processing environments: 
1. Matlab (R2015a, at Linux/MAC/Win10, https://www.mathworks.com/?s_tid=gn_logo), 
2. FSL toolbox (FSL 5.0.10, at Linux/MAC, https://fsl.fmrib.ox.ac.uk/fsl/fslwiki), 
3. Freesurfer toolbox (centos4_x86_64-stable-v4.0.2-20071215, https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki)

Step 1
1. meas_sample_AdjGre.dat can be downloaded at here: https://goo.gl/aotPQr and https://goo.gl/gZ1ZgZ
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
1. MPRAGE_sample (#0001~#0192) can be downloaded at here: https://goo.gl/aotPQr and https://goo.gl/gZ1ZgZ
2. @ Linux/MAC, using Freesurfer toolbox
3. >> recon-all -all -i sample.0001.IMA -subject subject_recon
4. >> mri_convert subject_recon/mri/T1.mgz T1.nii

Step 5
1. @ Linux/MAC, using FSL toolbox
2. >> flirt -in MNI305_T1_1mm.nii -ref MNI305_T1_2mm.nii -omat subject_T1_2stepflirt1.mat -bins 1024 -cost normcorr -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 6
3. >> flirt -in T1.nii -ref MNI305_T1_1mm.nii -omat subject_T1_2stepflirt2.mat -bins 1024 -cost normcorr -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 6
4. >> convert_xfm -concat subject_T1_2stepflirt1.mat -omat subject_T1_2stepflirt.mat subject_T1_2stepflirt2.mat
5. >> flirt -in T1.nii -ref MNI305_T1_2mm.nii -out subject_T1_2stepflirt.nii -applyxfm -init subject_T1_2stepflirt.mat -interp trilinear
6. >> flirt -in magnitude_image_bet_Af01mt.nii.gz -ref subj_T1.nii -out magnitude_image_bet_Af01mt_2t1nii.gz -omat magnitude_image_bet_Af01mt_2t1nii.gz.mat -bins 1024 -cost corratio -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 6 -interp trilinear
7. >> convert_xfm -concat subj_T1_2stepflirt.mat -omat mag2mni305.mat magnitude_image_bet_Af01mt_2t1nii.gz.mat
8. >> flirt -in magnitude_image_bet_Af01mt.nii.gz -applyxfm -init mag2mni305.mat -out magnitude_image_bet_Af01mt_mni305.nii.gz -paddingsize 0.0 -interp trilinear -ref subj_T1_2stepflirt.nii.gz
9. >> flirt -in Fieldmap.nii -applyxfm -init mag2mni305.mat -out Fieldmap_mni305.nii -paddingsize 0.0 -interp trilinear -ref subj_T1_2stepflirt.nii.gz
10. >> flirt -in magnitude_image.nii -applyxfm -init mag2mni305.mat -out magnitude_image_2stepflirt.nii -paddingsize 0.0 -interp trilinear -ref subj_T1_2stepflirt.nii.gz
11. >> bet subject_T1_2stepflirt subject_T1_2stepflirt_brain -R -f 0.4 -g 0 -m -t
12. @ Linux/MAC, using Freesurfer
13. >> mri_convert subject_T1_2stepflirt.nii.gz T1_2mm.nii
14. >> mri_convert subject_T1_2stepflirt_brain_mask.nii.gz small_mask.nii
15. >> mri_convert Fieldmap_mni305.nii.gz Fieldmap_mni305.nii
16. >> mri_convert magnitude_image_2stepflirt.nii.gz magnitude_image_2stepflirt.nii


Step 6
1. @ Linux/MAC/Win10, Matlab
>> analyze_offresonance_sources('Fieldmap_mni305','T1_2mm','small_mask',9:-2:3)
>> load('Fieldmap_brain.mat')
>> load('oROI_vSHARP.mat')
>> load('iROI_vSHARP.mat')
>> load('oROI_LBV.mat')
>> load('iROI_LBV.mat')
>> load('oROI_RESHARP.mat')
>> load('iROI_RESHARP.mat')
>> load('oROI_PDF.mat')
>> load('iROI_PDF.mat')
>> structure=MRIread(sprintf('%s.nii','T1_2mm'));
>> figure;imagesc(squeeze(structure.vol(:,:,50)));colormap(jet);title('T1-wighted structure image');axis equal
>> figure;imagesc(squeeze(Fieldmap_brain(:,:,50)));colormap(jet);title('Original image');axis equal
>> figure;imagesc(squeeze(oROI_vSHARP(:,:,50)));colormap(jet);title('oROI vSHARP image');axis equal
>> figure;imagesc(squeeze(iROI_vSHARP(:,:,50)));colormap(jet);title('Intrinsic limit image');axis equal
>> figure;imagesc(squeeze(oROI_LBV(:,:,50)));colormap(jet);title('oROI LBV image');axis equal
>> figure;imagesc(squeeze(iROI_LBV(:,:,50)));colormap(jet);title('iROI LBV Intrinsic limit image');axis equal
>> figure;imagesc(squeeze(oROI_RESHARP(:,:,50)));colormap(jet);title('oROI RESHARP image');axis equal
>> figure;imagesc(squeeze(iROI_RESHARP(:,:,50)));colormap(jet);title('iROI RESHARP Intrinsic limit image');axis equal
>> figure;imagesc(squeeze(oROI_PDF(:,:,50)));colormap(jet);title('oROI PDF image');axis equal
>> figure;imagesc(squeeze(iROI_PDF(:,:,50)));colormap(jet);title('iROI PDF Intrinsic limit image');axis equal
>> figure;imagesc(squeeze(structure.vol(:,44,:)));colormap(jet);title('T1-wighted structure image');axis equal
>> figure;imagesc(squeeze(Fieldmap_brain(:,44,:)));colormap(jet);title('Original image');axis equal
>> figure;imagesc(squeeze(oROI_vSHARP(:,44,:)));colormap(jet);title('oROI vSHARP image');axis equal
>> figure;imagesc(squeeze(iROI_vSHARP(:,44,:)));colormap(jet);title('Intrinsic limit image');axis equal
>> figure;imagesc(squeeze(oROI_LBV(:,44,:)));colormap(jet);title('oROI LBV image');axis equal
>> figure;imagesc(squeeze(iROI_LBV(:,44,:)));colormap(jet);title('iROI LBV Intrinsic limit image');axis equal
>> figure;imagesc(squeeze(oROI_RESHARP(:,44,:)));colormap(jet);title('oROI RESHARP image');axis equal
>> figure;imagesc(squeeze(iROI_RESHARP(:,44,:)));colormap(jet);title('iROI_RESHARP Intrinsic limit image');axis equal
>> figure;imagesc(squeeze(oROI_PDF(:,44,:)));colormap(jet);title('oROI PDF image');axis equal
>> figure;imagesc(squeeze(iROI_PDF(:,44,:)));colormap(jet);title('iROI PDF Intrinsic limit image');axis equal
>> figure;imagesc(squeeze(structure.vol(44,:,:)));colormap(jet);title('T1-wighted structure image');axis equal
>> figure;imagesc(squeeze(Fieldmap_brain(44,:,:)));colormap(jet);title('Original image');axis equal
>> figure;imagesc(squeeze(oROI_vSHARP(44,:,:)));colormap(jet);title('oROI vSHARP image');axis equal
>> figure;imagesc(squeeze(iROI_vSHARP(44,:,:)));colormap(jet);title('Intrinsic limit image');axis equal
>> figure;imagesc(squeeze(oROI_LBV(44,:,:)));colormap(jet);title('oROI LBV image');axis equal
>> figure;imagesc(squeeze(iROI_LBV(44,:,:)));colormap(jet);title('iROI LBV Intrinsic limit image');axis equal
>> figure;imagesc(squeeze(oROI_RESHARP(44,:,:)));colormap(jet);title('oROI RESHARP image');axis equal
>> figure;imagesc(squeeze(iROI_RESHARP(44,:,:)));colormap(jet);title('iROI RESHARP Intrinsic limit image');axis equal
>> figure;imagesc(squeeze(oROI_PDF(44,:,:)));colormap(jet);title('oROI PDF image');axis equal
>> figure;imagesc(squeeze(iROI_PDF(44,:,:)));colormap(jet);title('iROI PDF Intrinsic limit image');axis equal
