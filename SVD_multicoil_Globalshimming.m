function SVD_multicoil_Globalshimming(SVD_modes,N,kflag,direction,subject_field,brain_msk)

% Gobal shimming
% <<INPUT>>
% SVD_modes: implemented by particular multicoil, a .mat file.
% N: the number of subjects particular in a specific file directions.
% kflag: have been used ridge regression or not (k=0,or 1).
% direction: the string specify where is the data of subject_field in your computer. 
% ex: 'subj'. Note that file directions will be called in number-wise manner. ex: cd subj1, cd subj2, cd subj3, ...
% sujbect_field: a 3D matrix named Fieldmap_brain consists of off-resonance field map of a subject.
%
% << OUTPUT >>
% G_shimmed_results: shimmed_results-by-mode-by-subject, a 3D matrix.
% G_currents_coef: coilcurrents_coef-by-mode-by-subject, a 3D matrix.
% G_mimicfield: mimicked_field-by-mode-by-subject, a 3D matrix.
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
    
    G_currents_coef=zeros(size(mimicfield,2),size(mimicfield,2),size(mimicfield,3));
    G_mimicfield=zeros(size(mimicfield));
    G_shimmed_results=zeros(size(G_mimicfield));
    
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
        feval(@fprintf,feval(@sprintf,'load(%s.mat) ...\n',subject_field));
        
        subject_fieldt=sprintf('%s.mat',subject_field);
        a=load(subject_fieldt);
        Target=reshape(a.Fieldmap_brain,[numel(a.Fieldmap_brain),1]);
        
        brainmsk_nii=MRIread(sprintf('%s.nii',brain_msk));
        msk=reshape(brainmsk_nii.vol,[numel(a.Fieldmap_brain),1]);
        
        feval(@cd,'..');
             
        Smax=size(mimicfield,2);
        %     Smax=1;
        for mode=1:Smax
            feval(@fprintf,feval(@sprintf,'This is Global shimming for the %d subject by %d SVD mode ...\n',n,mode));
            SVD_fields=mimicfield(:,1:mode,n).*repmat(msk,1,mode);
            G_currents_coeft=-lsqminnorm(SVD_fields,Target,1e-9);
            G_currents_coef(1:size(G_currents_coeft),mode,n)=G_currents_coeft;
            G_mimicfield(:,mode,n)=-SVD_fields*G_currents_coeft;
            G_shimmed_results(:,mode,n)=Target-G_mimicfield(:,mode,n);
        end                
    end
    
    %% Save the results
    filename=sprintf('SVD_multicoil_Globalshimming_%dsubjects_by%s',N,SVD_modes);
    fprintf(sprintf('Saving the results in %s.mat ...\n',filename));
    eval(sprintf('save %s G_shimmed_results G_currents_coef G_mimicfield -v7.3',filename));
    fprintf(sprintf('The results have been save in %s.mat\n',filename));
    
elseif kflag==1
    %% Data Loading
    
    fprintf('Loading the data ...\n');
    fprintf(sprintf('load(%s.mat) ...\n',SVD_modes));
    SVD_modest=sprintf('%s.mat',SVD_modes);
    load(SVD_modest,'e_mimicfield');
    
    %% Core
    
    G_currents_coef=zeros(size(e_mimicfield,2),size(e_mimicfield,2),size(e_mimicfield,3));
    G_mimicfield=zeros(size(e_mimicfield));
    G_shimmed_results=zeros(size(G_mimicfield));
    
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
        feval(@fprintf,feval(@sprintf,'load(%s.mat) ...\n',subject_field));
        
        subject_fieldt=sprintf('%s.mat',subject_field);
        a=load(subject_fieldt);
        Target=reshape(a.Fieldmap_brain,[numel(a.Fieldmap_brain),1]);
        
        brainmsk_nii=MRIread(sprintf('%s.nii',brain_msk));
        msk=reshape(brainmsk_nii.vol,[numel(a.Fieldmap_brain),1]);
        
        feval(@cd,'..');
       
        Smax=size(e_mimicfield,2);

        for mode=1:Smax
            feval(@fprintf,feval(@sprintf,'This is Global shimming for the %d subject by %d SVD mode ...\n',n,mode));
            SVD_fields=e_mimicfield(:,1:mode,n).*repmat(msk,1,mode);
            G_currents_coeft=-lsqminnorm(SVD_fields,Target,1e-9);
            G_currents_coef(1:size(G_currents_coeft),mode,n)=G_currents_coeft;
            G_mimicfield(:,mode,n)=-SVD_fields*G_currents_coeft;
            G_shimmed_results(:,mode,n)=Target-G_mimicfield(:,mode,n);
        end
    end    
    
    %% Save the results
    filename=sprintf('e_SVD_multicoil_Globalshimming_%dsubjects_by%s',N,SVD_modes);
    fprintf(sprintf('Saving the results in %s.mat ...\n',filename));
    eval(sprintf('save %s G_shimmed_results G_currents_coef G_mimicfield -v7.3',filename));
    fprintf(sprintf('The results have been save in %s.mat\n',filename));    
end

end


