function Reg_mat2nii(Fn,T1Fn)

tempmat = load(sprintf('%s.mat',Fn));
Mode6 = tempmat.Mode6;
tempnii = MRIread('new_standard_brain.nii');
tempnii.vol = Mode6;
tempt1 = MRIread(sprintf('%s.nii',T1Fn));
for i = 1:3
    tempnii.vox2ras(i,4) = tempt1.vox2ras(i,4);
    tempnii.vox2ras0(i,4) = tempt1.vox2ras0(i,4);
    tempnii.vox2ras1(i,4) = tempt1.vox2ras1(i,4);
    tempnii.niftihdr.sform(i,4) = tempt1.niftihdr.sform(i,4);
    tempnii.niftihdr.qform(i,4) = tempt1.niftihdr.qform(i,4);
    tempnii.niftihdr.vox2ras(i,4) = tempt1.niftihdr.vox2ras(i,4);
end
tempnii.niftihdr.quatern_x = tempt1.niftihdr.quatern_x;
tempnii.niftihdr.quatern_y = tempt1.niftihdr.quatern_y;
tempnii.niftihdr.quatern_z = tempt1.niftihdr.quatern_z;
tempnii.niftihdr.srow_x(4) = tempt1.niftihdr.srow_x(4);
tempnii.niftihdr.srow_y(4) = tempt1.niftihdr.srow_y(4);
tempnii.niftihdr.srow_z(4) = tempt1.niftihdr.srow_z(4);
MRIwrite(tempnii,'Mode6.nii','double');
fprintf('Done %s.mat NII conversion!\n\n', Fn);