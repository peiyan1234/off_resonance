function SVDpatterned_MCshim(MCsubjshim,coilmat)

% Do SVD on MC shim current that generates the shim field for an off-resonance field of a subject

load(sprintf('%s.mat',coilmat),'b1_z');

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


load(sprintf('%s.mat',MCsubjshim),'e_currents');

currents=e_currents;

for group=1:size(currents,2)
    G=-currents;
    G(:,group)=[];
    [U,S,V]=svd(-G,0);
    rank_S=rank(S);
    s_values(1:rank_S,group)=(diag(S));
    SVD_patterns(:,1:rank_S,group)=U(:,1:rank_S).*repmat(transpose(s_values(1:rank_S,group)).*mean((V(:,1:rank_S)),1),size(U,1),1);
    
    for patterns=1:rank_S
        fprintf(sprintf('This is %d SVD current pattern for %d group ...\n',patterns,group));
        a=b1_z_o*SVD_patterns(:,patterns,group);       
        SVD_patterns_fields(:,patterns,group)=a;
    end
    
end

filename=sprintf('SVDpatterned_MCshim_by_%s',MCsubjshim);
fprintf(sprintf('Saving the results in %s.mat ...\n',filename));
eval(sprintf('save %s SVD_patterns SVD_patterns_fields s_values -v7.3',filename));

end