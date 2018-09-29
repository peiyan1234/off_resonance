function [shimmed_results,currents,mimicfield]=multicoilshim(N,kflag,direction,coilmat,subject_field,brain_msk)

% Mulit coils shimming applied to subjects of a group.
% <<INPUT>>
% N: the number of subjects particular in a specific file directions.
% kflag=0 or 1: the ridge regression paramter k is determined automatically based on
% http://dx.doi.org/10.1016/j.jaubas.2013.03.005 and https://doi.org/10.1080/00401706.1970.10488634
% direction: the string specify where is the data of subject_field in your computer. 
% ex: 'subj'. Note that file directions will be called in number-wise manner. ex: cd subj1, cd subj2, cd subj3, ...
% coilmat: a 2D matrix consists of shim fields (per Ampere) aligned in columns. One column for one coil.
% sujbect_field: a 3D matrix named Fieldmap_brain consists of off-resonance field map of a subject.
% brain_msk: a nifti file contains a 3D matrix specifying the voxels of the brain of a subject.
%
% << OUTPUT >>
% shimed_results: a 2D matrix consists of shimmed fields aligned in columns according to the sequance of subjects being called.
% currents: a 2D matrix consists of the current applied in each coil for each subjects. (coilcurrents-by-subject).
% mimicfield: The mimicked fields fit by the multi coils to the off-resonance of subjects. (mimicfield-by-subject)
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

b1_z_o=reshape(b1_zf,[size(b1_zf,1)*size(b1_zf,2)*size(b1_zf,3),size(b1_zf,4)]);
mimicfield=zeros(size(b1_z_o,1),N);
currents=zeros(size(b1_z_o,2),N);
shimmed_results=zeros(size(mimicfield));
b0=zeros(size(b1_z_o));

%% Main part

if kflag<0
    error('k=0 or 1.\n');
end

if kflag==0    
    for n=1:N
        %% Data Loading
        feval(@cd,feval(@sprintf,'%s%d',direction,n));
        fprintf(sprintf('load(%s.mat) ...\n',subject_field));
        subject_fieldt=sprintf('%s.mat',subject_field);
        a=load(subject_fieldt);
        Target=reshape(a.Fieldmap_brain,[numel(a.Fieldmap_brain),1]);
        fprintf(sprintf('MRIread(sprintf(%s.nii)) ...\n',brain_msk));
        brainmsk_nii=MRIread(sprintf('%s.nii',brain_msk));
        msk=reshape(brainmsk_nii.vol,[numel(brainmsk_nii.vol),1]);
        
        feval(@cd,'..');
        %% Shimming
        fprintf(sprintf('Mimicking the off-resonance field by using %s.\n',coilmat));
        
        for msking=1:size(b1_z_o,2)
            b0(:,msking)=b1_z_o(:,msking).*msk;
        end
        
        feval(@fprintf,feval(@sprintf,'Doing the MC shimming on %d subject ...\n',n));
        
        currentst=-lsqminnorm(b0,Target,1e-9);
        currents(:,n)=currentst;
        mimicfield(:,n)=-b0*currentst;
        shimmed_results(:,n)=Target-mimicfield(:,n);

        %% End
    end
    
    %% Save the results
    filename=sprintf('Shimming_%dsubjects_by%s',N,coilmat);
    fprintf(sprintf('Saving the results in %s.mat ...\n',filename));
    eval(sprintf('save %s shimmed_results currents mimicfield -v7.3',filename));
    fprintf(sprintf('The results have been save in %s.mat\n',filename));
    
elseif kflag>0
    feval(@fprintf,feval(@sprintf,'Doing the ridge regression for solving the linear system of MC shimming.\n'));
    feval(@fprintf,feval(@sprintf,'The ridge parameter is determined automatically.\n'));
    for n=1:N
        %% Data Loading
        feval(@cd,feval(@sprintf,'%s%d',direction,n));
        fprintf(sprintf('load(%s.mat) ...\n',subject_field));
        subject_fieldt=sprintf('%s.mat',subject_field);
        a=load(subject_fieldt);
        Target=reshape(a.Fieldmap_brain,[numel(a.Fieldmap_brain),1]);
        fprintf(sprintf('MRIread(sprintf(%s.nii)) ...\n',brain_msk));
        brainmsk_nii=MRIread(sprintf('%s.nii',brain_msk));
        msk=reshape(brainmsk_nii.vol,[numel(brainmsk_nii.vol),1]);
        
        feval(@cd,'..');
        
        %% Shimming
        fprintf(sprintf('Mimicking the off-resonance field by using %s.\n',coilmat));
        
        for msking=1:size(b1_z_o,2)
            X(:,msking)=b1_z_o(:,msking).*msk;
        end
        
        feval(@fprintf,feval(@sprintf,'Doing the MC shimming on %d subject ...\n',n));
        k=0.05*svds(X,1);
        W=transpose(X)*X+k*eye(size(X,2));
        e_currentst=-W\(transpose(X)*Target);        
        e_currents(:,n)=e_currentst;
        e_mimicfield(:,n)=-X*e_currentst;
        e_shimmed_results(:,n)=Target-e_mimicfield(:,n);        
    end
        %% Save the results
    filename=sprintf('e_Shimming_%dsubjects_by%s',N,coilmat);
    fprintf(sprintf('Saving the results in %s.mat ...\n',filename));
    eval(sprintf('save %s e_shimmed_results e_currents e_mimicfield -v7.3',filename));
    fprintf(sprintf('The results have been save in %s.mat\n',filename));
end    

end
