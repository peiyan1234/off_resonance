clear all;clc;
% Group analyses
num=input('Enter the number of subjects: ');

if num<0
    fprintf('n<0, Error!');
else
    
    % Variable List %
    slice_RMS_FM=zeros(88,num);
    slice_RMS_iLBV=zeros(88,num);
    slice_RMS_oLBV=zeros(88,num);
    slice_RMS_ssiLBV=zeros(88,num);
    slice_RMS_ssoLBV=zeros(88,num);
    slice_RMS_ssmLBV=zeros(88,num);
    slice_improvement=zeros(88,num);
    RMS_wholebrain=zeros(num,1);
    RMS_iROI_LBV=zeros(num,1);
    RMS_oROI_LBV=zeros(num,1);
    RMS_Global_shim=zeros(num,11);
    RMS_Global_shim_T=zeros(num,11);
    r_ssiLBV=zeros(88,99,88);
    r_ssoLBV=zeros(88,99,88);
    Nn=zeros(88,1);
    brain_vol=zeros(num,17);
    Global_shim=zeros(88,88,99,11,num);
    Global_shim_T=zeros(88,88,99,11,num);
    S_g=zeros(88,88,99,11,num);
    S_g_T=zeros(88,88,99,11,num);
    Similarity=zeros(37,11);
    Similarity_T=zeros(37,11);
    Resting_level=zeros(37,11);
    Resting_level_T=zeros(37,11);
    Slice_shim=zeros(1,88,99,88,11,num);
    Slice_shim_T=zeros(1,88,99,88,11,num);
    S_s=zeros(1,88,99,88,11,num);
    S_s_T=zeros(1,88,99,88,11,num);
    
    % ----------------------- %
    for s=1:num
        eval(sprintf('cd subj%d',s));
        % analzing the limitation slice-by-slice.
        load('Fieldmap_brain.mat');
        load('iROI_LBV.mat');
        load('oROI_LBV.mat');
  
        small_nii=MRIread(sprintf('%s.nii','small_mask'));
        small_msk=small_nii.vol;
        T1=MRIread(sprintf('%s.nii','T1_2mm'));
        T1m=(T1.vol).*small_msk;
        Nnz=nnz(small_msk);
        for Z=87:-1:2
            M=Fieldmap_brain(Z+1:-1:Z-1,:,:);
            matrix_size=size(M);
            msk=small_msk(Z+1:-1:Z-1,:,:);
            Nn(Z)=nnz(T1m(Z,:,:));
            M_int2=LBV(M,msk,matrix_size,[2,2,2],1e-9,8,0);
            ssoROI_LBV=(M-M_int2).*msk;
            ssiROI_LBV=M_int2.*msk;
            ssmROI_LBV=iROI_LBV(Z,:,:)-ssiROI_LBV(2,:,:);
            if Nn(Z)==0
                Nn(Z);
            else
                cor_n=sqrt((88*99)/Nn(Z));
                slice_RMS_FM(89-Z,s)=rms(reshape(squeeze(Fieldmap_brain(Z,:,:)),[88*99,1]))*cor_n;
                slice_RMS_iLBV(89-Z,s)=rms(reshape(squeeze(iROI_LBV(Z,:,:)),[88*99,1]))*cor_n;
                slice_RMS_oLBV(89-Z,s)=rms(reshape(squeeze(oROI_LBV(Z,:,:)),[88*99,1]))*cor_n;
                slice_RMS_ssiLBV(89-Z,s)=rms(reshape(squeeze(ssiROI_LBV(2,:,:)),[88*99,1]))*cor_n;
                slice_RMS_ssoLBV(89-Z,s)=rms(reshape(squeeze(ssoROI_LBV(2,:,:)),[88*99,1]))*cor_n;
                slice_RMS_ssmLBV(89-Z,s)=rms(reshape(squeeze(ssmROI_LBV),[88*99,1]))*cor_n;
                slice_improvement(89-Z,s)=slice_RMS_iLBV(89-Z,s)-slice_RMS_ssiLBV(89-Z,s);
                r_ssiLBV(:,:,Z)=ssiROI_LBV(2,:,:);
                r_ssoLBV(:,:,Z)=ssoROI_LBV(2,:,:);
            end
            
            %Slice-selecting shimming for B_L_s%
            As=zeros(1,88,99,1);
            Ts=zeros(1,88,99,1);
            for Order=0:10
                degree=-Order:2:Order;
                for nd=degree
                    SHfield_slice=Spherical_Harmonics_Generator(size(oROI_LBV,2),size(oROI_LBV,3),1,[1 -1 -1],[2,2,2],Order,nd,'Dynamic');
                    p_A=(Order*(Order+1)/2+find(degree==nd));
                    As(1,:,:,p_A)=shiftdim(SHfield_slice,-1).*msk(2,:,:);
                    p_T=(Order*(Order+1)/2+find(degree==nd));
                    Ts(1,:,:,p_T)=shiftdim(SHfield_slice,-1).*msk(2,:,:);
                end
                As=reshape(As,[88*99,(Order+1)*(Order+2)/2]);
                Ts=reshape(Ts,[88*99,(Order+1)*(Order+2)/2]);
                Best_proj_slice=-lsqminnorm(As,reshape(ssoROI_LBV(2,:,:),[88*99,1]),1e-9);
                Slice_shim(1,:,:,Z,Order+1,s)=reshape(As*Best_proj_slice,[1,88,99]);
                S_s(1,:,:,Z,Order+1,s)=M(2,:,:)+Slice_shim(:,:,:,Z,Order+1,s);
                As=reshape(As,[1,88,99,(Order+1)*(Order+2)/2]);
                
                Best_proj_slice_T=-lsqminnorm(Ts,reshape(M(2,:,:),[88*99,1]),1e-9);
                Slice_shim_T(1,:,:,Z,Order+1,s)=reshape(Ts*Best_proj_slice,[1,88,99]);
                S_s_T(1,:,:,Z,Order+1,s)=M(2,:,:)+Slice_shim_T(:,:,:,Z,Order+1,s);
                Ts=reshape(Ts,[1,88,99,(Order+1)*(Order+2)/2]);
            end
        end
        
        RMS_wholebrain(s,1)=sqrt(sum(reshape(Fieldmap_brain.*Fieldmap_brain,[88*88*99,1]))/Nnz);
        RMS_iROI_LBV(s,1)=sqrt(sum(reshape(iROI_LBV.*iROI_LBV,[88*88*99,1]))/Nnz);
        RMS_oROI_LBV(s,1)=sqrt(sum(reshape(oROI_LBV.*oROI_LBV,[88*88*99,1]))/Nnz);
        
        RMS_ssiROI_LBV(s,1)=sqrt(sum(reshape(r_ssiLBV.*r_ssiLBV,[88*88*99,1]))/Nnz);
        RMS_ssoROI_LBV(s,1)=sqrt(sum(reshape(r_ssoLBV.*r_ssoLBV,[88*88*99,1]))/Nnz);
        
        %Global Shim Simulation for B_L and B%
        B_L=reshape(oROI_LBV,[88*88*99,1]);
        B=reshape(Fieldmap_brain,[88*88*99,1]);
        A=zeros(88,88,99,1);
        T=zeros(88,88,99,1);
        for Order=0:10
            for degree=-Order:Order
                SHfield=Spherical_Harmonics_Generator(size(oROI_LBV,2),size(oROI_LBV,3),size(oROI_LBV,1),[1 -1 -1],[2,2,2],Order,degree,'Global');
                A(:,:,:,((Order-1)+1)^2+degree+Order+1)=shiftdim(SHfield,2).*small_msk;
                T(:,:,:,((Order-1)+1)^2+degree+Order+1)=shiftdim(SHfield,2).*small_msk;
            end
            A=reshape(A,[88*88*99,(Order+1)^2]);
            T=reshape(T,[88*88*99,(Order+1)^2]);
            Best_proj=-lsqminnorm(A,B_L,1e-9);
            Global_shim(:,:,:,Order+1,s)=(reshape(A*Best_proj,[88,88,99]));
            S_g(:,:,:,Order+1,s)=Fieldmap_brain+Global_shim(:,:,:,Order+1,s);
            RMS_Global_shim(s,Order+1)=sqrt(sum(reshape(S_g(:,:,:,Order+1,s).*S_g(:,:,:,Order+1,s),[88*88*99,1]))/Nnz);
            A=reshape(A,[88,88,99,(Order+1)^2]);
            Similarity(s,Order+1)=abs(dot(reshape(Global_shim(:,:,:,Order+1,s),[88*88*99,1]),B_L))/(norm(reshape(Global_shim(:,:,:,Order+1,s),[88*88*99,1]))*norm(B_L));
            Resting_level(s,Order+1)=1-abs(dot(reshape(Global_shim(:,:,:,Order+1,s),[88*88*99,1]),B))/(norm(reshape(Global_shim(:,:,:,Order+1,s),[88*88*99,1]))*norm(B));            
            
            Best_proj_T=-lsqminnorm(T,B,1e-9);
            Global_shim_T(:,:,:,Order+1,s)=(reshape(T*Best_proj_T,[88,88,99]));
            S_g_T(:,:,:,Order+1,s)=Fieldmap_brain+Global_shim_T(:,:,:,Order+1,s);
            RMS_Global_shim_T(s,Order+1)=sqrt(sum(reshape(S_g_T(:,:,:,Order+1,s).*S_g_T(:,:,:,Order+1,s),[88*88*99,1]))/Nnz);
            T=reshape(T,[88,88,99,(Order+1)^2]);          
            Similarity_T(s,Order+1)=abs(dot(reshape(Global_shim_T(:,:,:,Order+1,s),[88*88*99,1]),B_L))/(norm(reshape(Global_shim_T(:,:,:,Order+1,s),[88*88*99,1]))*norm(B_L));
            Resting_level_T(s,Order+1)=1-abs(dot(reshape(Global_shim_T(:,:,:,Order+1,s),[88*88*99,1]),B))/(norm(reshape(Global_shim_T(:,:,:,Order+1,s),[88*88*99,1]))*norm(B));
            
        end
        
        eval('cd ..');
    end
    
    std_Resting_level=std(Resting_level,0,1);
    mean_Resting_level=mean(Resting_level,1);
    
    std_Resting_level_T=std(Resting_level_T,0,1);
    mean_Resting_level_T=mean(Resting_level_T,1);
    
    std_Similarity=std(Similarity,0,1);
    mean_Similarity=mean(Similarity,1);
    
    std_Similarity_T=std(Similarity_T,0,1);
    mean_Similarity_T=mean(Similarity_T,1);
    
    RMS_std_Global_shim=std(RMS_Global_shim,0,1);
    RMS_mean_Global_shim=mean(RMS_Global_shim,1);
    
    RMS_std_Global_shim_T=std(RMS_Global_shim_T,0,1);
    RMS_mean_Global_shim_T=mean(RMS_Global_shim_T,1);
    
    RMS_std_wholebrain=std(RMS_wholebrain,0,1);
    RMS_mean_wholebrain=mean(RMS_wholebrain);
    
    RMS_std_iROI_LBV=std(RMS_iROI_LBV,0,1);
    RMS_mean_iROI_LBV=mean(RMS_iROI_LBV);
    
    RMS_std_oROI_LBV=std(RMS_oROI_LBV,0,1);
    RMS_mean_oROI_LBV=mean(RMS_oROI_LBV);
    
    RMS_std_ssiROI_LBV=std(RMS_ssiROI_LBV,0,1);
    RMS_mean_ssiROI_LBV=mean(RMS_ssiROI_LBV);  

    RMS_std_ssoROI_LBV=std(RMS_ssoROI_LBV,0,1);
    RMS_mean_ssoROI_LBV=mean(RMS_ssoROI_LBV);       
    
    % analzing the limitation slice-by-slice.
    slice_std_FM=std(slice_RMS_FM,0,2);
    slice_mean_FM=mean(slice_RMS_FM,2);
    
    slice_std_iLBV=std(slice_RMS_iLBV,0,2);
    slice_mean_iLBV=mean(slice_RMS_iLBV,2);
    slice_std_oLBV=std(slice_RMS_oLBV,0,2);
    slice_mean_oLBV=mean(slice_RMS_oLBV,2);
    
    slice_std_siLBV=std(slice_RMS_ssiLBV,0,2);
    slice_mean_siLBV=mean(slice_RMS_ssiLBV,2);
    slice_std_soLBV=std(slice_RMS_ssoLBV,0,2);
    slice_mean_soLBV=mean(slice_RMS_ssoLBV,2);
    
    slice_std_smLBV=std(slice_RMS_ssmLBV,0,2);
    slice_mean_smLBV=mean(slice_RMS_ssmLBV,2);
    
    slice_std_improvement=std(slice_improvement,0,2);
    slice_mean_improvement=mean(slice_improvement,2);

    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    figure
    x=1:1:88;
    err1=slice_std_FM;
    e1=errorbar(x,slice_mean_FM,err1,'-',...
        'LineWidth',1);
    hold on
    ax=gca;
    box off
    xlabel('Z-direction (slices)')
    ylabel('RMS (ppm)')
    err2=slice_std_iLBV;
    e2=errorbar(x,slice_mean_iLBV,err2,'-^',...
        'MarkerSize',5,'MarkerEdgeColor','k','LineWidth',1);
    err5=slice_std_siLBV;
    e5=errorbar(x,slice_mean_siLBV,err5,'-o',...
        'MarkerSize',5,'MarkerEdgeColor','k','LineWidth',1);
    err6=slice_std_smLBV;
    e6=errorbar(x,slice_mean_smLBV,err6,'-*',...
        'MarkerSize',5,'MarkerEdgeColor','k','LineWidth',1);
    ax.XLim=[1 88];
    ax.YLim=[0 0.5];
    ax.XTick=[1 10 20 30 40 50 60 70 80 88];
    ax.YTick=[0 0.05 0.10 0.15 0.20 0.3 0.4 0.5];
    ax.YMinorTick='on';
    ax.FontSize=25;
    legend('B','B_P WholeBrain','B_P_,_s SingleSlice','B_P_L SingleSlice');
    
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    figure
    x=1:1:88;
    err1=slice_std_FM;
    e1=errorbar(x,slice_mean_FM,err1,'-',...
        'LineWidth',1);
    hold on
    ax=gca;
    box off
    xlabel('Z-direction (slices)')
    ylabel('RMS (ppm)')
    err3=slice_std_oLBV;
    e3=errorbar(x,slice_mean_oLBV,err3,'-v',...
        'MarkerSize',5,'MarkerEdgeColor','k','LineWidth',1);
    err4=slice_std_soLBV;
    e4=errorbar(x,slice_mean_soLBV,err4,'-o',...
        'MarkerSize',5,'MarkerEdgeColor','k','LineWidth',1,'MarkerFaceColor','k');
    ax.XLim=[1 88];
    ax.YLim=[0 0.5];
    ax.XTick=[1 10 20 30 40 50 60 70 80 88];
    ax.YTick=[0 0.05 0.10 0.15 0.20 0.3 0.4 0.5];
    ax.YMinorTick='on';
    ax.FontSize=25;
    legend('B','B_L WholeBrain','B_L_,_s SingleSlice');
    
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    
    figure
    x=1:1:88;
    err7=slice_std_improvement;
    e7=errorbar(x,slice_mean_improvement,err7,'-o',...
        'MarkerSize',5,'MarkerEdgeColor','k','LineWidth',1);
    hold on
    ax=gca;
    box off
    xlabel('Z-direction (slices)')
    ylabel('ppm')
    ax.XLim=[1 88];
    ax.YLim=[0 0.11];
    ax.XTick=[1 10 20 30 40 50 60 70 80 88];
    ax.YTick=[0 0.01 0.03 0.05 0.07 0.1];
    ax.YMinorTick='on';
    ax.FontSize=25;
    legend('RMS(B_P)-RMS(B_P_,_s)');
    
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    
    figure
    x=0:10;
    err8=std_Similarity*100;
    e8=errorbar(x,mean_Similarity*100,err8,'-o',...
        'MarkerSize',5,'MarkerEdgeColor','k','LineWidth',1);
    hold on
    err9=std_Similarity_T*100;
    e9=errorbar(x,mean_Similarity_T*100,err9,'-d',...
        'MarkerSize',5,'MarkerEdgeColor','k','LineWidth',1);    
    ax=gca;
    box off
    xlabel('SH order')
    ylabel('Absolute normalized inner product (%)')
    ax.YMinorTick='on';
    ax.FontSize=25;
    legend('Fit B_S_H to B_L','Fit B_S_H to B','Location','northwest');    
    
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    
    figure
    x=0:10;
    err10=std_Resting_level*100;
    e10=errorbar(x,mean_Resting_level*100,err10,'-o',...
        'MarkerSize',5,'MarkerEdgeColor','k','LineWidth',1);
    hold on
    err11=std_Resting_level_T*100;
    e11=errorbar(x,mean_Resting_level_T*100,err11,'-d',...
        'MarkerSize',5,'MarkerEdgeColor','k','LineWidth',1);    
    ax=gca;
    box off
    xlabel('SH order')
    ylabel('Residue of Off-resonance (%)')
    ax.YMinorTick='on';
    ax.FontSize=25;
    legend('Fit B_S_H to B_L','Fit B_S_H to B');    

    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%    
    
end