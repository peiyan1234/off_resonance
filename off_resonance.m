function off_resonance(flag_raw,raw_name,N,TE1,TE2,flag_brainmask,flag_BESTPATH_unwrap,flag_Laplacian_unwrap)

% off_resonance(flag_raw,raw_name,N,TE1,TE2,flag_brainmask,flag_BESTPATH_unwrap,flag_Laplacian_unwrap)
% ex: >>off_resonance(1,'meas_sample_AdjGre',32,0.002,0.00446,1,0,1);
% flag_raw == 0 or 1; Solving raw data, or not.
% raw_name; e.g. 'meas_XXX' (without ".dat").
% N; the number of channels of RF recievers.
% TE1; the first echo time.
% TE2; the second echo time.
% flag_brainmask == 0 or 1; Give a brain mask, or not.
% flag_BESTPATH_unwrap == 0 or 1; Using BEST-PATH phase unwrapping algorithm, or not.
% flag_Laplacian_unwrap == 0 or 1; Using Laplacian phase unwrapping algorithm, or not.
% Either BEST-PATH unwrapping algorithm or Laplacian unwrapping algorithm,
% do not use both of them at the same time.
% Created by:
%   Pei-Yan, Li
%   Institute of Biomedical Engineering,
%   National Taiwan University
%   d05548014@ntu.edu.tw


%%%%%%Solving Raw.data%%%%%%
if flag_raw~=0
    fprintf('%%%%%%Solving Raw.data ...%%%%%%\r');
    ice_master_vd11('file_raw',sprintf('%s.dat',raw_name),'flag_3d',1,'flag_sege',1,'flag_regrid',0,'flag_phase_cor',0);
    fprintf('%%%%%%Done.%%%%%%\r');
    fprintf('\r');
end

%%%%%%Loading Multi-channel Signal%%%%%%
fprintf('%%%%%%Loading Multi-channel Signal ...%%%%%%\r');
fprintf('\r');
fprintf('Setting parameters\r');

GyromagneticRatio = 42.58*10^6;
echo1_1m=zeros(128,128,96);
echo2_1m=zeros(128,128,96);
echo1_2m=zeros(128,128,96);
echo2_2m=zeros(128,128,96);
fieldmap=zeros(128,128,96);

record1_1=zeros(128,128,96,N);
record2_1=zeros(128,128,96,N);
record1_2=zeros(128,128,96,N);
record2_2=zeros(128,128,96,N);

n_amp1_1=zeros(1,N);
n_amp2_1=zeros(1,N);
n_amp1_2=zeros(1,N);
n_amp2_2=zeros(1,N);
deltaTE=TE2-TE1;

for channel=1:N
    %load each channel signal
    fprintf(sprintf('loading meas_chan%03d.mat ...\r',channel));
    load(sprintf('meas_chan%03d.mat',channel));
    
    % collect each channel signal and weighted each channel for magnitude
    fprintf('Calculating 3D magnitude images ...\r');
    echo1_1m=echo1_1m+power(abs(data(:,:,:,1,1)),2);
    echo2_1m=echo2_1m+power(abs(data(:,:,:,2,1)),2);
    echo1_2m=echo1_2m+power(abs(data(:,:,:,1,2)),2);
    echo2_2m=echo2_2m+power(abs(data(:,:,:,2,2)),2);
    
    % collect each channel signal
    fprintf('Calculating weighted coefficient for each channel ...\r');
    littlecub1_1=power(abs(data(1:10,1:10,1:10,1,1)),2);
    littlecub2_1=power(abs(data(1:10,1:10,1:10,2,1)),2);
    littlecub1_2=power(abs(data(1:10,1:10,1:10,1,2)),2);
    littlecub2_2=power(abs(data(1:10,1:10,1:10,2,2)),2);
    
    n_amp1_1(:,channel)=(sum(sum(sum(littlecub1_1,3),2),1)/N);
    n_amp2_1(:,channel)=(sum(sum(sum(littlecub2_1,3),2),1)/N);
    n_amp1_2(:,channel)=(sum(sum(sum(littlecub1_2,3),2),1)/N);
    n_amp2_2(:,channel)=(sum(sum(sum(littlecub2_2,3),2),1)/N);
    
    fprintf('Recoding complex information from raw.data ...\r');
    record1_1(:,:,:,channel)=data(:,:,:,1,1);
    record2_1(:,:,:,channel)=data(:,:,:,2,1);
    record1_2(:,:,:,channel)=data(:,:,:,1,2);
    record2_2(:,:,:,channel)=data(:,:,:,2,2);
end

% sum of square for magnitude

fprintf('Calculating sum of square of magnitude images ...\r');
echo1_1m=sqrt(echo1_1m);
echo2_1m=sqrt(echo2_1m);
echo1_2m=sqrt(echo1_2m);
echo2_2m=sqrt(echo2_2m);

% calculate the fieldmap
fprintf('Calculating fieldmap of each echo ...\r');
vector1=zeros(128,128,96);
vector2=zeros(128,128,96);
parfor k=1:N
    w1=sum(n_amp2_1,2)/(N*n_amp2_1(:,k));
    w2=sum(n_amp2_2,2)/(N*n_amp2_2(:,k));
    vector1 = vector1 + (record2_1(:,:,:,k).*conj(record1_1(:,:,:,k)))*w1;
    vector2 = vector2 + (record2_2(:,:,:,k).*conj(record1_2(:,:,:,k)))*w2;
end


if (flag_BESTPATH_unwrap==1 & flag_Laplacian_unwrap==0)
    %%%%%%Unwrapping phase images by BEST-PATH algorithm%%%%%%
    fprintf('%%%%%%Unwrapping phase images by BEST-PATH algorithm%%%%%%\r');
    fprintf('Preparing for phase unwrapping\r');
    
    gradient_x1 = zeros(128,128,96);
    gradient_y1 = zeros(128,128,96);
    gradient_z1 = zeros(128,128,96);
    gradient_x1(1:127,:,:) = angle(vector1(2:128,:,:).*conj(vector1(1:127,:,:)));
    gradient_y1(:,1:127,:) = angle(vector1(:,2:128,:).*conj(vector1(:,1:127,:)));
    gradient_z1(:,:,1:95) = angle(vector1(:,:,2:96).*conj(vector1(:,:,1:95)));
    qualitymap1=zeros(128,128,96);
    
    gradient_x2 = zeros(128,128,96);
    gradient_y2 = zeros(128,128,96);
    gradient_z2 = zeros(128,128,96);
    gradient_x2(1:127,:,:) = angle(vector2(2:128,:,:).*conj(vector2(1:127,:,:)));
    gradient_y2(:,1:127,:) = angle(vector2(:,2:128,:).*conj(vector2(:,1:127,:)));
    gradient_z2(:,:,1:95) = angle(vector2(:,:,2:96).*conj(vector2(:,:,1:95)));
    qualitymap2=zeros(128,128,96);
    
    m=3:126;
    n=3:126;
    l=3:94;
    
    fprintf('Calculating Quality Maps for phase images\r');
    [qualitymap1,qualitymap2]=qualitymap(m,n,l,gradient_x1,gradient_y1,gradient_z1,qualitymap1,gradient_x2,gradient_y2,gradient_z2,qualitymap2);
    
    fprintf('Loading brain mask ...\r');
    if flag_brainmask~=0
        bm=MRIread('big_mask.nii');
        brain_mask=bm.vol;
        vector1=vector1.*brain_mask;
        vector2=vector2.*brain_mask;
    else
        fprintf('There is no any given brain mask ...\r');
        fprintf('Calculation will be continued ...\r');
    end
    
    edge1=zeros(128,128,96,3);
    edge2=zeros(128,128,96,3);
    
    edge1(1:127,:,:,1)=qualitymap1(1:127,:,:)+qualitymap1(2:128,:,:);
    edge1(:,1:127,:,2)=qualitymap1(:,1:127,:)+qualitymap1(:,2:128,:);
    edge1(:,:,1:95,3)=qualitymap1(:,:,1:95)+qualitymap1(:,:,2:96);
    
    edge2(1:127,:,:,1)=qualitymap2(1:127,:,:)+qualitymap2(2:128,:,:);
    edge2(:,1:127,:,2)=qualitymap2(:,1:127,:)+qualitymap2(:,2:128,:);
    edge2(:,:,1:95,3)=qualitymap2(:,:,1:95)+qualitymap2(:,:,2:96);
    
    r_edge1=reshape(edge1,[128*128*96*3 1]);
    r_edge2=reshape(edge2,[128*128*96*3 1]);
    
    [s_edge1,index_r_edge1]=sort(r_edge1,'descend');
    [s_edge2,index_r_edge2]=sort(r_edge2,'descend');
    
    index1=zeros(128*128*96*3,4);
    index2=zeros(128*128*96*3,4);
    
    fprintf('Calculating the best uwrapping path ...\r');
    [index1,index2]=bestpath(edge1,edge2,r_edge1,r_edge2,s_edge1,index_r_edge1,s_edge2,index_r_edge2,index1,index2);
    
    phase1=angle(vector1);
    phase2=angle(vector2);
    gmap1=zeros(128,128,96);
    gmap2=zeros(128,128,96);
    gnumber1=1;
    gnumber2=1;
    
    fprintf('Unwrapping phase images according to the best unwrapping path ...\r');
    [phase1,phase2,vector1,vector2]=unwrapping_BEST(phase1,phase2,gmap1,gmap2,gnumber1,gnumber2,index1,index2,vector1,vector2);
    
    fprintf('Done. \r');
    fprintf('%%%%%%Saving the results%%%%%%\r');
    
    if flag_brainmask==0
        fieldmap = ((phase1./(2*pi*deltaTE*GyromagneticRatio)+phase2./(2*pi*deltaTE*GyromagneticRatio))./2);
        fprintf('save qualitymap qualitymap1 qualitymap2\r');
        save qualitymap qualitymap1 qualitymap2
        fprintf('save Fieldmap_data fieldmap echo1_1m echo2_1m echo1_2m echo2_2m vector1 vector2 phase1 phase2 gmap1 gmap2\r');
        magnitude_image=echo1_1m;
        fprintf('save Magnitude magnitude_image\r');
        save Magnitude magnitude_image
        fprintf('save Fieldmap fieldmap\r');
        save Fieldmap fieldmap
        tempmat = load('Fieldmap.mat');
        fieldmap = tempmat.fieldmap;
        tempnii = MRIread('big_mask.nii');
        tempnii.vol = fieldmap;
        MRIwrite(tempnii,'Fieldmap.nii','double');
        fprintf('Fieldmap.nii has been saved.\r');

    else
        fieldmap_BESTPATH_masked = ((phase1./(2*pi*deltaTE*GyromagneticRatio)+phase2./(2*pi*deltaTE*GyromagneticRatio))./2).*brain_mask;
        fprintf('save Fieldmap_data fieldmap_BESTPATH_masked echo1_1m echo2_1m echo1_2m echo2_2m vector1 vector2 phase1 phase2 gmap1 gmap2\r');
        save Fieldmap_data fieldmap_BESTPATH_masked echo1_1m echo2_1m echo1_2m echo2_2m vector1 vector2 phase1 phase2 gmap1 gmap2
        fprintf('save Fieldmap fieldmap_BESTPATH_masked\r');
        save Fieldmap fieldmap_BESTPATH_masked
        tempmat = load('Fieldmap.mat');
        fieldmap_BESTPATH_masked = tempmat.fieldmap_BESTPATH_masked;
        tempnii = MRIread('big_mask.nii');
        tempnii.vol = fieldmap_BESTPATH_masked;
        MRIwrite(tempnii,'Fieldmap.nii','double');
        fprintf('Fieldmap.nii has been saved.\r');
    end
    
    fprintf('%%%%%%Finished without Errors%%%%%%\r');
    
elseif (flag_Laplacian_unwrap==1 & flag_BESTPATH_unwrap==0)
    %%%%%%Unwrapping phase images by Laplacian algorithm%%%%%%
    fprintf('%%%%%%Unwrapping phase images by Laplacian algorithm%%%%%%\r');
    fprintf('Preparing for phase unwrapping\r');
    if flag_brainmask==0
        fprintf('ERROR !\r');
        fprintf('No mask file!\r');
        fprintf('Shut Down.\r');
    else
        fprintf('Loading brain mask ...\r');
        bm=MRIread('big_mask.nii');
        brain_mask=bm.vol;
        vector1=vector1.*brain_mask;
        vector2=vector2.*brain_mask;
        phase1=angle(vector1);
        phase2=angle(vector2);
        [phase1,phaseLaplacianFiltered_1]=laplacianUnwrap(phase1, brain_mask);
        [phase2,phaseLaplacianFiltered_2]=laplacianUnwrap(phase2, brain_mask);
        fprintf('Done. \r');
        fprintf('%%%%%%Saving the results%%%%%%\r');
        fieldmap_Laplacian_masked = ((phase1./(2*pi*deltaTE*GyromagneticRatio)+phase2./(2*pi*deltaTE*GyromagneticRatio))./2).*brain_mask;
        fprintf('save Fieldmap_data fieldmap_Laplacian_masked echo1_1m echo2_1m echo1_2m echo2_2m vector1 vector2 phase1 phase2\r');
        save Fieldmap_data fieldmap_Laplacian_masked echo1_1m echo2_1m echo1_2m echo2_2m vector1 vector2 phase1 phase2
        fprintf('save Fieldmap fieldmap_Laplacian_masked\r');
        save Fieldmap fieldmap_Laplacian_masked
        tempmat = load('Fieldmap.mat');
        fieldmap_Laplacian_masked = tempmat.fieldmap_Laplacian_masked;
        tempnii = MRIread('big_mask.nii');
        tempnii.vol = fieldmap_Laplacian_masked;
        MRIwrite(tempnii,'Fieldmap.nii','double');
        fprintf('Fieldmap.nii has been saved.\r');
        fprintf('%%%%%%Finished without Errors%%%%%%\r');
    end
    
elseif (flag_BESTPATH_unwrap==1 & flag_Laplacian_unwrap==1)
    fprintf('ERROR!\r');
    fprintf('BEST-PATH and Laplacian unwrapping algorithms can not be used at the same time!\r');
    fprintf('Shut Down.\r');
else
    fprintf('No Unwrapping processes ...\r');
    fprintf('Loading brain mask ...\r');
    if flag_brainmask~=0
        bm=MRIread('big_mask.nii');
        brain_mask=bm.vol;
        vector1=vector1.*brain_mask;
        vector2=vector2.*brain_mask;
    else
        fprintf('There is no any given brain mask ...\r');
        fprintf('Calculation will be continued ...\r');
    end
    phase1=angle(vector1);
    phase2=angle(vector2);
    
    fprintf('%%%%%%Saving the results%%%%%%\r');
    if flag_brainmask==0
        fieldmap = ((phase1./(2*pi*deltaTE*GyromagneticRatio)+phase2./(2*pi*deltaTE*GyromagneticRatio))./2);
        fprintf('save Magnitude magnitude_image\r');
        magnitude_image=echo1_1m;
        save Magnitude magnitude_image
        tempmat = load('Magnitude.mat');
        magnitude_image = tempmat.magnitude_image;
        tempnii = MRIread('NIItemplate.nii');
        tempnii.vol = magnitude_image;
        MRIwrite(tempnii,'magnitude_image.nii','double');
        fprintf('magnitude_image.nii has been saved.\r');
%         fprintf('save Fieldmap fieldmap\r');
%         save Fieldmap fieldmap
    else
        fieldmap_masked = ((phase1./(2*pi*deltaTE*GyromagneticRatio)+phase2./(2*pi*deltaTE*GyromagneticRatio))./2).*brain_mask;
        fprintf('save masked Magnitude magnitude_image\r');
        magnitude_image_masked=echo1_1m.*brain_mask;
        save Magnitude magnitude_image_masked
        fprintf('save masked Fieldmap fieldmap\r');
        save Fieldmap fieldmap_masked
        tempmat = load('Fieldmap.mat');
        fieldmap_masked = tempmat.fieldmap_masked;
        tempnii = MRIread('big_mask.nii');
        tempnii.vol = fieldmap_masked;
        MRIwrite(tempnii,'Fieldmap.nii','double');
        fprintf('Fieldmap.nii has been saved.\r');
    end
    
end