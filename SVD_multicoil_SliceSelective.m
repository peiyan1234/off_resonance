function SVD_multicoil_SliceSelective(SVD_modes,N,kflag,direction,subject_field,brain_msk)

% Dynamic shimming
% <<INPUT>>
% SVD_modes: implemented by particular multicoil, a .mat file.
% N: the number of subjects particular in a specific file directions.
% kflag: have been used ridge regression or not (k=0,or 1).
% direction: the string specify where is the data of subject_field in your computer. 
% ex: 'subj'. Note that file directions will be called in number-wise manner. ex: cd subj1, cd subj2, cd subj3, ...
% sujbect_field: a 3D matrix named Fieldmap_brain consists of off-resonance field map of a subject.
% brain_msk: a nifti file contains a 3D matrix specifying the voxels of the brain of a subject.
%
% << OUTPUT >>
% SS_shimmed_results: shimmed_results-by-slice-by-mode-by-subject, a 4D matrix.
% SS_currents_coef: coilcurrents_coef-by-slice-by-mode-by-subject, a 4D matrix.
% SS_mimicfield: mimicked_field-by-slice-by-mode-by-subject, a 4D matrix.
%
% Created by 
%   Pei-Yan, Li
%   National Taiwan University
%   d05548014@ntu.edu.tw


if kflag==0
    %% Data Loading
    
    fprintf('Loading the data ...\n');
    fprintf(sprintf('load(%s.mat) ...\n',SVD_modes));
    SVD_modest=sprintf('%s.mat',SVD_modes);
    load(SVD_modest,'mimicfield');
    
    %% Core
    
    feval(@cd,feval(@sprintf,'%s%d',direction,1));
    subject_fieldt=sprintf('%s.mat',subject_field);
    a=load(subject_fieldt);
    feval(@cd,'..');
    
    SS_shimmed_results=zeros(size(a.Fieldmap_brain,2)*size(a.Fieldmap_brain,3),size(a.Fieldmap_brain,1),size(mimicfield,2),N);
    SS_currents_coef=zeros(size(mimicfield,2),size(a.Fieldmap_brain,1),size(mimicfield,2),N);
    SS_mimicfield=zeros(size(SS_shimmed_results));
    
    for n=1:N
        feval(@cd,feval(@sprintf,'%s%d',direction,n));
        if n==1
            feval(@fprintf,feval(@sprintf,'This is the %d-st subject ...\n',n));
        elseif n==2
            feval(@fprintf,feval(@sprintf,'This is the %d-nd subject ...\n',n));
        elseif n==3
            feval(@fprintf,feval(@sprintf,'This is the %d-rd subject ...\n',n));
        elseif n>3
            feval(@fprintf,feval(@sprintf,'This is the %d-th subject ...\n',n));
        end
        %% Data Loading
        feval(@fprintf,feval(@sprintf,'load(%s.mat) ...\n',subject_field));
        subject_fieldt=sprintf('%s.mat',subject_field);
        a=load(subject_fieldt);
        brainmsk_nii=MRIread(sprintf('%s.nii',brain_msk));
        
        %% SVD-based MC Slice-selective Shimming
        
        b0_z=reshape(mimicfield(:,:,n),[size(brainmsk_nii.vol),size(mimicfield,2)]);
        
        for slice=1:size(brainmsk_nii.vol,1)
            
            if slice==1
                feval(@fprintf,feval(@sprintf,'Doing the SVD-based MC slice-selective shimming for the %d-st slice ...\n',slice));
            end
            if slice==2
                feval(@fprintf,feval(@sprintf,'Doing the SVD-based MC slice-selective shimming for the %d-nd slice ...\n',slice));
            end
            if slice==3
                feval(@fprintf,feval(@sprintf,'Doing the SVD-based MC slice-selective shimming for the %d-rd slice ...\n',slice));
            end
            if slice>3
                feval(@fprintf,feval(@sprintf,'Doing the SVD-based MC slice-selective shimming for the %d-th slice ...\n',slice));
            end
            
            msk=reshape(brainmsk_nii.vol(slice,:,:),[size(brainmsk_nii.vol,2)*size(brainmsk_nii.vol,3),1]);
            if nnz(msk)~=0
                Target=reshape(a.Fieldmap_brain(slice,:,:),[size(brainmsk_nii.vol,2)*size(brainmsk_nii.vol,3),1]);
                
                for mode=1:size(mimicfield,2)
                    b0=reshape(b0_z(slice,:,:,1:mode),[size(msk,1),mode]);
                    X=b0.*repmat(msk,1,mode);
                    
                    SS_shimfield=-X*lsqminnorm(X,Target,1e-9);
                    SS_mimicfield(:,slice,mode,n)=-SS_shimfield;
                    SS_shimmed_results(:,slice,mode,n)=Target+SS_shimfield;
                end
            end
        end
        
        feval(@cd,'..');
    end
    
    %% Save the results
    filename=sprintf('SVD_multicoil_SliceSelective%dsubjects_by%s',N,SVD_modes);
    fprintf(sprintf('Saving the results in %s.mat ...\n',filename));
    eval(sprintf('save %s SS_shimmed_results SS_currents_coef SS_mimicfield -v7.3',filename));
    fprintf(sprintf('The results have been save in %s.mat\n',filename));
    
elseif kflag==1
    %% Data Loading
    
    fprintf('Loading the data ...\n');
    fprintf(sprintf('load(%s.mat) ...\n',SVD_modes));
    SVD_modest=sprintf('%s.mat',SVD_modes);
    load(SVD_modest,'e_mimicfield');
    
    %% Core
    
    feval(@cd,feval(@sprintf,'%s%d',direction,1));
    subject_fieldt=sprintf('%s.mat',subject_field);
    a=load(subject_fieldt);
    feval(@cd,'..');
    
    SS_shimmed_results=zeros(size(a.Fieldmap_brain,2)*size(a.Fieldmap_brain,3),size(a.Fieldmap_brain,1),size(e_mimicfield,2),N);
    SS_currents_coef=zeros(size(e_mimicfield,2),size(a.Fieldmap_brain,1),size(e_mimicfield,2),N);
    SS_mimicfield=zeros(size(SS_shimmed_results));
    
    for n=1:N
        feval(@cd,feval(@sprintf,'%s%d',direction,n));
        if n==1
            feval(@fprintf,feval(@sprintf,'This is the %d-st subject ...\n',n));
        elseif n==2
            feval(@fprintf,feval(@sprintf,'This is the %d-nd subject ...\n',n));
        elseif n==3
            feval(@fprintf,feval(@sprintf,'This is the %d-rd subject ...\n',n));
        elseif n>3
            feval(@fprintf,feval(@sprintf,'This is the %d-th subject ...\n',n));
        end
        %% Data Loading
        feval(@fprintf,feval(@sprintf,'load(%s.mat) ...\n',subject_field));
        subject_fieldt=sprintf('%s.mat',subject_field);
        a=load(subject_fieldt);
        brainmsk_nii=MRIread(sprintf('%s.nii',brain_msk));
        
        %% SVD-based MC Slice-selective Shimming
        
        b0_z=reshape(e_mimicfield(:,:,n),[size(brainmsk_nii.vol),size(e_mimicfield,2)]);
        
        for slice=1:size(brainmsk_nii.vol,1)
            
            if slice==1
                feval(@fprintf,feval(@sprintf,'Doing the SVD-based MC slice-selective shimming for the %d-st slice ...\n',slice));
            end
            if slice==2
                feval(@fprintf,feval(@sprintf,'Doing the SVD-based MC slice-selective shimming for the %d-nd slice ...\n',slice));
            end
            if slice==3
                feval(@fprintf,feval(@sprintf,'Doing the SVD-based MC slice-selective shimming for the %d-rd slice ...\n',slice));
            end
            if slice>3
                feval(@fprintf,feval(@sprintf,'Doing the SVD-based MC slice-selective shimming for the %d-th slice ...\n',slice));
            end
            
            msk=reshape(brainmsk_nii.vol(slice,:,:),[size(brainmsk_nii.vol,2)*size(brainmsk_nii.vol,3),1]);
            if nnz(msk)~=0
                Target=reshape(a.Fieldmap_brain(slice,:,:),[size(brainmsk_nii.vol,2)*size(brainmsk_nii.vol,3),1]);
                
                for mode=1:size(e_mimicfield,2)
                    b0=reshape(b0_z(slice,:,:,1:mode),[size(msk,1),mode]);
                    X=b0.*repmat(msk,1,mode);
                    
%                     SS_shimfield=-X*lsqminnorm(X,Target,1e-9);
                    SS_shimfield=-X*(X\Target);
                    SS_mimicfield(:,slice,mode,n)=-SS_shimfield;
                    SS_shimmed_results(:,slice,mode,n)=Target+SS_shimfield;
                end
            end
        end
        
        feval(@cd,'..');
    end
    
    %% Save the results
    filename=sprintf('e_SVD_multicoil_SliceSelective%dsubjects_by%s',N,SVD_modes);
    fprintf(sprintf('Saving the results in %s.mat ...\n',filename));
    eval(sprintf('save %s SS_shimmed_results SS_currents_coef SS_mimicfield -v7.3',filename));
    fprintf(sprintf('The results have been save in %s.mat\n',filename));
end

end