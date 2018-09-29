function SVDpatterned_MCshim_Global(SVD_patterns,N,direction,subject_field,brain_msk)

%% Data Loading

fprintf('Loading the data ...\n');
fprintf(sprintf('load(%s.mat) ...\n',SVD_patterns));
load(sprintf('%s.mat',SVD_patterns),'SVD_patterns_fields');

%% Core

G_currents_coef=zeros(size(SVD_patterns_fields,2),size(SVD_patterns_fields,2),size(SVD_patterns_fields,3));
G_mimicfield=zeros(size(SVD_patterns_fields));
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
    msk=reshape(brainmsk_nii.vol,[numel(brainmsk_nii.vol),1]);
    feval(@cd,'..');
        
    Smax=size(SVD_patterns_fields,2);

    for mode=1:Smax
        feval(@fprintf,feval(@sprintf,'This is Global shimming for the %d subject by %d SVD patterns ...\n',n,mode));
        A=-SVD_patterns_fields(:,1:mode,n).*repmat(msk,1,mode);     
        G_currents_coeft=lsqminnorm(A,Target,1e-9);
        G_currents_coef(1:size(G_currents_coeft,1),mode,n)=G_currents_coeft;
        G_mimicfield(:,mode,n)=A*G_currents_coeft;
        G_shimmed_results(:,mode,n)=Target-G_mimicfield(:,mode,n);
        Nb=nnz(msk);
        PPM_SH(mode,n)=sqrt(sum((G_shimmed_results(:,mode,n)).^2)/Nb);
        Similarity(mode,n)=abs(dot(Target,G_mimicfield(:,mode,n))/(norm(Target)*norm(G_mimicfield(:,mode,n))));
    end
    
    
end

%% Save the results
filename=sprintf('SVDpatterned_MCshim_Global_%dsubjects_by%s',N,SVD_patterns);
fprintf(sprintf('Saving the results in %s.mat ...\n',filename));
eval(sprintf('save %s G_shimmed_results G_currents_coef G_mimicfield PPM_SH Similarity -v7.3',filename));
fprintf(sprintf('The results have been save in %s.mat\n',filename));

end