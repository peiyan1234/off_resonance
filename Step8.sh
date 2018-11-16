cd subj1
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj2
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj3
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj4
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj5
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj6
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj7
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj8
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj9
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj10
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj11
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj12
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj13
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj14
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj15
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj16
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj17
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj18
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj19
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj20
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj21
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj22
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj23
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj24
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj25
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj26
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj27
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj28
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj29
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj30
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj31
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj32
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj33
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj34
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj35
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj36
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
cd subj37
flirt -in rrT1_2mm.nii.gz -ref MNI305_T1_2mm.nii -out rrT1_2mm_translated.nii.gz -omat rrT1_2mm_translated.mat -bins 256 -cost corratio -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 6 -schedule /usr/local/fsl/etc/flirtsch/sch3Dtrans_3dof  -interp trilinear
flirt -in rFieldmap.nii -applyxfm -init rrT1_2mm_translated.mat -out rFieldmap_translated.nii -paddingsize 0.0 -interp trilinear -ref rrT1_2mm.nii.gz
bet rrT1_2mm_translated rrT1_2mm_brain -R -f 0.5 -g 0 -m -t
mri_convert rrT1_2mm_brain.nii.gz rrT1_2mm_brain.nii
mri_convert rrT1_2mm_brain_mask.nii.gz small_mask.nii
mri_convert rFieldmap_translated.nii.gz rFieldmap_translated.nii
mri_convert rrT1_2mm_translated.nii.gz rrT1_2mm_translated.nii
cd ..
