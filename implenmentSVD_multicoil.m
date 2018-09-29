function [mimicfield,currents]=implenmentSVD_multicoil(coilmat,N,kflag,direction,subject_field)

% Mulit coils shimming slice-by-slice applied to subjects of a group.
% <<INPUT>>
% N: the number of subjects particular in a specific file directions.
% direction: the string specify where is the data of subject_field in your computer. 
% ex: 'subj'. Note that file directions will be called in number-wise manner. ex: cd subj1, cd subj2, cd subj3, ...
% kflag=0 or 1: the ridge regression paramter k is determined automatically based on
% http://dx.doi.org/10.1016/j.jaubas.2013.03.005 and https://doi.org/10.1080/00401706.1970.10488634
% coilmat: a 2D matrix consists of shim fields (per Ampere) aligned in columns. One column for one coil.
% sujbect_field: a 3D matrix named Fieldmap_brain consists of off-resonance field map of a subject.
%
% << OUTPUT >>
% mimicfield: mimicked_field-by-mode-by-group, a 3D matrix.
% currents: coilcurrents-by-mode-by-group, a 3D matrix.
%
% Created by 
%   Pei-Yan, Li
%   National Taiwan University
%   d05548014@ntu.edu.tw

%% Data Loading

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
    Group(:,n)=Target;
    brainmsk_nii=MRIread(sprintf('%s.nii','small_mask'));
    msk(:,n)=reshape(brainmsk_nii.vol,[numel(brainmsk_nii.vol),1]);
    
    feval(@cd,'..');
end

%% mimic SVD modes of a group ( N groups)

if kflag<0
    error('k=0 or 1.\n');
end

if kflag==0
    s_values=zeros(N,N);
    currents=zeros(size(b1_z_o,2),N-1,N);
    mimicfield=zeros(size(b1_z_o,1),N-1,N);
    for group=1:N
        gp=Group;
        gp(:,group)=[];
        [U,S,V]=svd(gp,0);
        rank_S=rank(S);
        s_values(1:rank_S,group)=(diag(S));
        
%         SVD_modes(:,1:rank_S)=U(:,1:rank_S).*repmat(transpose(s_values(1:rank_S,group)).*mean((V(:,1:rank_S)),1),size(U,1),1);
        SVD_modes(:,1:rank_S)=U(:,1:rank_S);
        ave_Group=mean(Group,2);
        if dot(ave_Group,U(:,1))<0
            SVD_modes(:,1)=SVD_modes(:,1)*(-1);
        end
        
        gmsk=msk;
        gmsk(:,group)=[];
        bmsk=(sum(gmsk,2)>0);
        
        for mode=1:rank_S
            feval(@fprintf,feval(@sprintf,'Implenmenting the %d SVD mode of %d group  ...\n',mode,group));
            b0=(b1_z_o).*repmat(bmsk,1,size(b1_zf,4));
            currentst=lsqminnorm(b0,SVD_modes(:,mode),1e-9);
            currents(1:size(currentst,1),mode,group)=currentst;
            mimicfield(:,mode,group)=b0*currentst;
        end
    end
    
    %% Save the results
    filename=sprintf('implenmentSVD_multicoil_%dgroup_by%s',N,coilmat);
    fprintf(sprintf('Saving the results in %s.mat ...\n',filename));
    eval(sprintf('save %s currents mimicfield -v7.3',filename));
    fprintf(sprintf('The results have been save in %s.mat\n',filename));
    
elseif kflag>0
    matfilename=sprintf('implenmentSVD_multicoil_%dgroup_by%s',N,coilmat);
    load(matfilename,'currents');
    feval(@fprintf,feval(@sprintf,'The ridge regression is applied to solve the linear system of MC shimming.\n'));
    feval(@fprintf,feval(@sprintf,'The ridge parameter will be determined automatically.\n'));
    s_values=zeros(N,N);
    e_currents=zeros(size(b1_z_o,2),N-1,N);
    e_mimicfield=zeros(size(b1_z_o,1),N-1,N);
    for group=23
        gp=Group;
        gp(:,group)=[];
        [U,S,V]=svd(gp,0);
        rank_S=rank(S);
        s_values(1:rank_S,group)=(diag(S));
        %             SVD_modes(:,1:rank_S)=U(:,1:rank_S).*repmat(transpose(s_values(1:rank_S,group)).*mean((V(:,1:rank_S)),1),size(U,1),1);
        SVD_modes_reference(:,1:rank_S)=U(:,1:rank_S);
        ave_Group=mean(Group,2);
        if dot(ave_Group,U(:,1))<0
            SVD_modes_reference(:,1)=U(:,1)*(-1);
        end
    end   
    
    for group=1:N       
        gp=Group;
        gp(:,group)=[];
        [U,S,V]=svd(gp,0);
        rank_S=rank(S);
        s_values(1:rank_S,group)=(diag(S));
        
%         SVD_modes(:,1:rank_S)=U(:,1:rank_S).*repmat(transpose(s_values(1:rank_S,group)).*mean((V(:,1:rank_S)),1),size(U,1),1);
        for check=1:rank_S
            if dot(U(:,check),SVD_modes_reference(:,check))<0
                SVD_modes(:,check)=U(:,check)*(-1);
            else
                SVD_modes(:,check)=U(:,check);
            end
        end
        
        gmsk=msk;
        gmsk(:,group)=[];
        bmsk=(sum(gmsk,2)>0);
        
        for mode=1:rank_S
            feval(@fprintf,feval(@sprintf,'Implenmenting the %d SVD mode of %d group  ...\n',mode,group));
            X=(b1_z_o).*repmat(bmsk,1,size(b1_zf,4));
            k=0.05*svds(X,1);
            W=transpose(X)*X+k*eye(size(X,2));
            Target=SVD_modes(:,mode);
            e_currentst=W\(transpose(X)*Target); 
            e_currents(1:size(e_currentst,1),mode,group)=e_currentst;
            e_mimicfield(:,mode,group)=X*e_currentst;
        end
    end
    
    %% Save the results
    filename=sprintf('e_implenmentSVD_multicoil_%dgroup_by%s',N,coilmat);
    fprintf(sprintf('Saving the results in %s.mat ...\n',filename));
    eval(sprintf('save %s e_currents e_mimicfield -v7.3',filename));
    fprintf(sprintf('The results have been save in %s.mat\n',filename));        
end
end