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
>> %@ Linux/MAC/Win10, Matlab
>> off_resonance(1,'meas_sample_AdjGre',32,0.002,0.00446,0,0,0);
>> %where meas_sample_AdjGre.dat can be download at here: URL

Step 2
>> %@ Linux/MAC, using FSL toolbox
>> bet magnitude_image.nii magnitude_image_bet_Af01mt -A -f 0.1 -m -t
>> %@ Linux, using Freesurfer toolbox
>> mri_convert magnitude_image_bet_Af01mt_mask.nii.gz big_mask.nii

Step 3
>> %@ MAC/Win10/Linux, Matlab
>> off_resonance(0,'meas_sample_AdjGre',32,0.002,0.00446,1,0,1);

Step 4
