# B0 maps preprocessing

Created by:
Pei-Yan, Li.
Institute of Biomedical Engineering, 
National Taiwan University.
d05548014@ntu.edu.tw

This README file decribes the preprocess of a measured raw data before further analyses.

Processing environments: 
1. Matlab (R2018a, at Win10-64 bits, https://www.mathworks.com/?s_tid=gn_logo), 
2. FSL toolbox (FSL 5.0.10, at Linux/MAC, https://fsl.fmrib.ox.ac.uk/fsl/fslwiki), 
3. Freesurfer toolbox (centos4_x86_64-stable-v4.0.2-20071215, https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki)

Step 1
1. meas_sample_AdjGre.dat can be downloaded at here: https://goo.gl/aotPQr and https://goo.gl/gZ1ZgZ
2. @ Linux/MAC/Win10, by Matlab
3. >> off_resonance(1,'meas_sample_AdjGre',32,0.002,0.00446,0,0,0); 

Step 2 @Linux shell
1. >> chmod 755 Freesurfer_source.sh
2. >> source Freesurfer_source.sh
3. >> chmod 755 Step2_1.sh
4. >> chmod 755 Step2_2.sh
5. >> ./Step2_1.sh
6. >> ./Step2_2.sh

Step 3
1. @ Linux/MAC/Win10, by Matlab
2. >> off_resonance(0,'meas_sample_AdjGre',32,0.002,0.00446,1,0,1);

Step 4 @Linux shell
1. >> chmod 755 Step4.sh
2. >> ./Step4.sh

Step 5 @Linux shell
1. >> chmod 755 Step5.sh
2. >> ./Step5.sh

Step 6 @Matlab
1. >> Step6_orientation;

Step 7, 8 @Linux shell
1. >> chmod 755 Step7.sh
2. >> chmod 755 Step8.sh
3. >> ./Step7.sh
4. >> ./Step8.sh

Step 9
1. @ Linux/MAC/Win10, by Matlab
>> analyze_offresonance_sources('rFieldmap_translated','rrT1_2mm_translated.nii','small_mask');
