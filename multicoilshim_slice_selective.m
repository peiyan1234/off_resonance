function [shimmed_results,currents,mimicfield]=multicoilshim_slice_selective(N,kflag,direction,coilmat,subject_field,brain_msk)

% Mulit coils shimming slice-by-slice applied to subjects of a group.
% <<INPUT>>
% N: the number of subjects particular in a specific file directions.
% direction: the string specify where is the data of subject_field in your computer. 
% ex: 'subj'. Note that file directions will be called in number-wise manner. ex: cd subj1, cd subj2, cd subj3, ...
% coilmat: a 2D matrix consists of shim fields (per Ampere) aligned in columns. One column for one coil.
% sujbect_field: a 3D matrix named Fieldmap_brain consists of off-resonance field map of a subject.
% brain_msk: a nifti file contains a 3D matrix specifying the voxels of the brain of a subject.
%
% << OUTPUT >>
% shimed_results: shimmed_field-by-slice-by-subject, a 3D matrix.
% currents: currents-by-slice-by-subject, a 3D matrix.
% mimicfield: mimicked_field-by-slice-by-subject, a 3D matrix.
%
% Created by 
%   Pei-Yan, Li
%   National Taiwan University
%   d05548014@ntu.edu.tw

%%  Prepare
fprintf('Loading the data ...\n');
fprintf(sprintf('load(%s.mat) ...\n',coilmat));
coilmatt=sprintf('%s.mat',coilmat);
load(coilmatt);

for lp=1:size(b1_z,4)
    bz=b1_z(:,:,:,lp);
    bz=shiftdim(bz,2);
    bzf=zeros(size(bz));
    for z=1:size(bz,1)
        bzf(size(bz,1)+1-z,:,:)=bz(z,:,:);
    end
    for y=1:size(bz,3)
        bzf(:,:,size(bz,3)+1-y)=bz(:,:,y);
    end
    bz=bzf;
    b1_zf(:,:,:,lp)=bz;
end

b1_z_o=b1_zf;
mimicfield=zeros(size(b1_zf,2)*size(b1_zf,3),size(b1_zf,1),N);
currents=zeros(size(b1_zf,4),size(b1_zf,1),N);
shimmed_results=zeros(size(mimicfield));
e_mimicfield=zeros(size(b1_zf,2)*size(b1_zf,3),size(b1_zf,1),N);
e_currents=zeros(size(b1_zf,4),size(b1_zf,1),N);
e_shimmed_results=zeros(size(e_mimicfield));
b0=zeros(size(b1_zf,2)*size(b1_zf,3),size(b1_zf,4));

%% Main part

if kflag<0
    error('k=0 or 1.\n');
end

if kflag==0  
    for n=1:N
        new_journey=sprintf('cd %s%d',direction,n);
        eval(new_journey);
        fprintf(new_journey);fprintf('\n');
        
        %% Data Loading
        fprintf(sprintf('load(%s.mat) ...\n',subject_field));
        subject_fieldt=sprintf('%s.mat',subject_field);
        a=load(subject_fieldt);
        fprintf(sprintf('MRIread(sprintf(%s.nii)) ...\n',brain_msk));
        brainmsk_nii=MRIread(sprintf('%s.nii',brain_msk));
        
        %% Slice-selective Shimming
        fprintf(sprintf('Mimicking the off-resonance field by using %s.\n',coilmat));
        
        if n==1
            fprintf(sprintf('This is the %d-st subject ...\n',n));
        end
        if n==2
            fprintf(sprintf('This is the %d-nd subject ...\n',n));
        end
        if n==3
            fprintf(sprintf('This is the %d-rd subject ...\n',n));
        end
        if n>3
            fprintf(sprintf('This is the %d-th subject ...\n',n));
        end
        
        for slice=1:size(b1_zf,1)
            
            if slice==1
                fprintf(sprintf('Doing the slice-selective shimming for the %d-st slice ...\n',slice));
            end
            if slice==2
                fprintf(sprintf('Doing the slice-selective shimming for the %d-nd slice ...\n',slice));
            end
            if slice==3
                fprintf(sprintf('Doing the slice-selective shimming for the %d-rd slice ...\n',slice));
            end
            if slice>3
                fprintf(sprintf('Doing the slice-selective shimming for the %d-th slice ...\n',slice));
            end
            
            msk=reshape(brainmsk_nii.vol(slice,:,:),[size(b1_zf,2)*size(b1_zf,3),1]);
            if nnz(msk)~=0
                Target=reshape(a.Fieldmap_brain(slice,:,:),[size(b1_zf,2)*size(b1_zf,3),1]);
                %             Target=Target.*msk;
                b0=reshape(b1_z_o(slice,:,:,:),[size(b1_zf,2)*size(b1_zf,3),size(b1_zf,4)]);
                for msking=1:size(b0,2)
                    b0(:,msking)=b0(:,msking).*msk;
                end
                %             % Speed up by gpu
                %             b0_gpu=gpuArray(b0);
                %             Target_gpu=gpuArray(Target);
                %             currents_gpu=-mldivide(b0_gpu,Target_gpu);
                %             mimicfield_gpu=-b0_gpu*currents_gpu;
                %             shimmed_results_gpu=Target_gpu-mimicfield_gpu;
                
                %             currents(:,slice,n)=gather(currents_gpu);
                %             mimicfield(:,slice,n)=gather(mimicfield_gpu);
                %             shimmed_results(:,slice,n)=gather(shimmed_results_gpu);
                
                currents(:,slice,n)=-mldivide(b0,Target);
                mimicfield(:,slice,n)=-b0*currents(:,slice,n);
                shimmed_results(:,slice,n)=Target-mimicfield(:,slice,n);
                
            end
        end
        
        
        %% End
        gohome='cd ..';
        fprintf(gohome);fprintf('\n');
        eval(gohome);
    end
    
    %% Save the results
    filename=sprintf('Slice_Shimming_%dsubjects_by%s',N,coilmat);
    fprintf(sprintf('Saving the results in %s.mat ...\n',filename));
    eval(sprintf('save %s shimmed_results currents mimicfield -v7.3',filename));
    fprintf(sprintf('The results have been save in %s.mat\n',filename));

elseif kflag>0
    feval(@fprintf,feval(@sprintf,'Doing the ridge regression for solving the linear system of MC slice-selective shimming.\n'));
    feval(@fprintf,feval(@sprintf,'The ridge parameter is determined automatically.\n'));
    for n=1:N
        new_journey=sprintf('cd %s%d',direction,n);
        eval(new_journey);
        fprintf(new_journey);fprintf('\n');
        
        %% Data Loading
        fprintf(sprintf('load(%s.mat) ...\n',subject_field));
        subject_fieldt=sprintf('%s.mat',subject_field);
        a=load(subject_fieldt);
        fprintf(sprintf('MRIread(sprintf(%s.nii)) ...\n',brain_msk));
        brainmsk_nii=MRIread(sprintf('%s.nii',brain_msk));
        
        %% Slice-selective Shimming
        fprintf(sprintf('Mimicking the off-resonance field by using %s.\n',coilmat));
        
        if n==1
            fprintf(sprintf('This is the %d-st subject ...\n',n));
        end
        if n==2
            fprintf(sprintf('This is the %d-nd subject ...\n',n));
        end
        if n==3
            fprintf(sprintf('This is the %d-rd subject ...\n',n));
        end
        if n>3
            fprintf(sprintf('This is the %d-th subject ...\n',n));
        end
        
        for slice=1:size(b1_zf,1)
            
            if slice==1
                fprintf(sprintf('Doing the slice-selective shimming for the %d-st slice ...\n',slice));
            end
            if slice==2
                fprintf(sprintf('Doing the slice-selective shimming for the %d-nd slice ...\n',slice));
            end
            if slice==3
                fprintf(sprintf('Doing the slice-selective shimming for the %d-rd slice ...\n',slice));
            end
            if slice>3
                fprintf(sprintf('Doing the slice-selective shimming for the %d-th slice ...\n',slice));
            end
            
            msk=reshape(brainmsk_nii.vol(slice,:,:),[size(b1_zf,2)*size(b1_zf,3),1]);
            if nnz(msk)~=0
                Target=reshape(a.Fieldmap_brain(slice,:,:),[size(b1_zf,2)*size(b1_zf,3),1]);
                %             Target=Target.*msk;
                b0=reshape(b1_z_o(slice,:,:,:),[size(b1_zf,2)*size(b1_zf,3),size(b1_zf,4)]);
                for msking=1:size(b0,2)
                    X(:,msking)=b0(:,msking).*msk;
                end
                k=0.05*svds(X,1);
                W=transpose(X)*X+k*eye(size(X,2));
                e_currentst=-W\(transpose(X)*Target);  
                e_currents(:,slice,n)=e_currentst;
                e_mimicfield(:,slice,n)=-X*e_currentst;
                e_shimmed_results(:,slice,n)=Target-e_mimicfield(:,slice,n);               
            end
        end
        
        
        %% End
        gohome='cd ..';
        fprintf(gohome);fprintf('\n');
        eval(gohome);
    end
    
    %% Save the results
    filename=sprintf('e_Slice_Shimming_%dsubjects_by%s',N,coilmat);
    fprintf(sprintf('Saving the results in %s.mat ...\n',filename));
    eval(sprintf('save %s e_shimmed_results e_currents e_mimicfield -v7.3',filename));
    fprintf(sprintf('The results have been save in %s.mat\n',filename));
end

end