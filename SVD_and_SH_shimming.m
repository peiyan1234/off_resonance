clear all; clc;

% SVD shimming & spherical harmonic shimming
% Created by 
%	 Pei-Yan, Li
%	 National Taiwan University

num=input('Enter the number of subjects you have:	');

if (num<0 | abs(num-floor(num))<0)
	Error('Come on! The number of subjects can only be a postive integer. Wake up!***');
end

clc;
fprintf('The calculation is ready to run...\n');
fprintf('Gook Luck!\n');

fprintf('***Spherical harmonic shimming***\n');

% Variables List %

G_SHshimfield=zeros(88,88,99,11,num);
G_SHshimming=zeros(88,88,99,11,num);
subjects_B=zeros(88*88*99,num);
subjects_Bs=zeros(88,99,88,num);
SS_SHshimfield=zeros(1,88,99,88,1,num);
SS_SHshimming=zeros(1,88,99,88,1,num);
	
% -------------- %

for s=1:num
	eval(sprintf('cd subj%d',s));
	load('Fieldmap_brain.mat');
	brainmsk_nii=MRIread(sprintf('%s.nii','small_mask'));
	brainmsk=brainmsk_nii.vol;
	
	if s==1;
	fprintf(sprintf('This is %d-st subject.\n',s));
	end
	if s==2;
	fprintf(sprintf('This is %d-ed subject.\n',s));
	end
	if s>2;
	fprintf(sprintf('This is %d-th subject.\n',s));
	end
	fprintf('Global spherical harmonic shimming is going to run.\n');
	
	% Globally spherical harmonic shimming %
	B=reshape(Fieldmap_brain,[size(Fieldmap_brain,1)*size(Fieldmap_brain,2)*size(Fieldmap_brain,3),1]);
	
	G_SHmatrix=zeros([size(Fieldmap_brain),1]);
	for order=0:12
		fprintf(sprintf('%d order\n',order));
		for degree=-order:order
			G_SHfield=Spherical_Harmonics_Generator(size(Fieldmap_brain,2),size(Fieldmap_brain,3),size(Fieldmap_brain,1),[1,-1,-1],[2,2,2],order,degree,'Global');
			G_SHmatrix(:,:,:,((order-1)+1)^2+degree+order+1)=shiftdim(G_SHfield,2).*brainmsk;
		end
		
		A=reshape(G_SHmatrix,[size(Fieldmap_brain,1)*size(Fieldmap_brain,2)*size(Fieldmap_brain,3),(order+1)^2]);
		G_SHshimfield(:,:,:,order+1,s)=reshape(-A*lsqminnorm(A,B,1e-9),[size(Fieldmap_brain)]);
		G_SHshimming(:,:,:,order+1,s)=Fieldmap_brain+G_SHshimfield(:,:,:,order+1,s);
	end
	
	fprintf('Slice-selecting spherical harmonic shimming is going to run.\n');
	% Slice-selecting spherical harmonic shimming %
	
	for Z=size(Fieldmap_brain,1):-1:1
		fprintf(sprintf('%d slice\n',size(Fieldmap_brain,1)-Z+1));
		Bs=reshape(Fieldmap_brain(Z,:,:),[size(Fieldmap_brain,2)*size(Fieldmap_brain,3),1]);
		SS_SHmatrix=zeros(1,size(Fieldmap_brain,2),size(Fieldmap_brain,3),1);
		for order=0:12
			fprintf(sprintf('%d order\n',order));
			round=0;
			for degree=-order:2:order
				round=round+1;
				SS_SHfield=Spherical_Harmonics_Generator(size(Fieldmap_brain,2),size(Fieldmap_brain,3),1,[1 -1 -1],[2,2,2],order,degree,'Dynamic');
				SS_SHmatrix(1,:,:,(order*(order+1)/2+round))=shiftdim(SS_SHfield,-1).*brainmsk(Z,:,:);
			end
			
			As=reshape(SS_SHmatrix,[size(Fieldmap_brain,2)*size(Fieldmap_brain,3),(order+1)*(order+2)/2]);
			SS_SHshimfield(1,:,:,Z,order+1,s)=reshape(-As*lsqminnorm(As,Bs,1e-9),[1,size(Fieldmap_brain,2),size(Fieldmap_brain,3)]);
			SS_SHshimming(1,:,:,Z,order+1,s)=reshape(Bs,[1,size(Fieldmap_brain,2),size(Fieldmap_brain,3)])+SS_SHshimfield(1,:,:,Z,order+1,s);
		end
		
		subjects_Bs(:,:,Z,s)=reshape(Bs,[1,size(Fieldmap_brain,2),size(Fieldmap_brain,3)]);
	end
	
	subjects_B(:,s)=B;
	
	eval(sprintf('cd ..'));
end

save Spherical_harmonic_shimming.mat G_SHshimfield G_SHshimming SS_SHshimfield SS_SHshimming -v7.3
save subjects_data.mat subjects_B subjects_Bs -v7.3
clear A As B brainmsk brainmsk_nii Bs degree G_SHfield G_SHmatrix G_SHshimfield G_SHshimming order

fprintf('***SVD shimming***\n');
fprintf('Cross-validation is used to analyze the variation of SVD shimming among subjetcs.\n');

% Variables List %

U=zeros([size(subjects_B,1),num-1,num]);
S=zeros(num-1,num-1,num);
V=zeros(num-1,num-1,num);
s_values=zeros(num-1,num);
rank_subjects_B=zeros(1,num);
max_mode=zeros(1,num);

% -------------- %

fprintf('During SVD analyzing...\n');
for s=1:num
    if s==1;
        fprintf(sprintf('For %d-st group.\n',s));
    end
    if s==2;
        fprintf(sprintf('For %d-ed group.\n',s));
    end
    if s>2;
        fprintf(sprintf('For %d-th group.\n',s));
    end
    
    Group=subjects_B;
    Group(:,s)=[];
    [U(:,:,s),S(:,:,s),V(:,:,s)]=svd(Group,0);
    s_values(:,s)=diag(S(:,:,s));
    rank_subjects_B(:,s)=nnz(s_values(:,s));
    
    if (rank_subjects_B(:,s))>=12
        max_mode(:,s)=12;
    elseif (rank_subjects_B(:,s))<12
        max_mode(:,s)=rank_subjects_B(:,s);
    end
end

% Variables List %

G_SVDmatrix=zeros(size(U,1),1);
SVD_modes=zeros(size(U,1),1,num);
G_SVDshimfield=zeros([size(Fieldmap_brain),1,num]);
G_SVDshimming=zeros([size(Fieldmap_brain),1,num]);
SS_SVDshimfield=zeros(1,size(Fieldmap_brain,2),size(Fieldmap_brain,3),size(Fieldmap_brain,1),1,num);
SS_SVDshimming=zeros(1,size(Fieldmap_brain,2),size(Fieldmap_brain,3),size(Fieldmap_brain,1),1,num);

% -------------- %

for s=1:num
    if s==1;
        fprintf(sprintf('This is %d-st subject.\n',s));
    end
    if s==2;
        fprintf(sprintf('This is %d-ed subject.\n',s));
    end
    if s>2;
        fprintf(sprintf('This is %d-th subject.\n',s));
    end
    
    for mode=1:max_mode(:,s)
        G_SVDmatrix(:,mode)=U(:,mode,s)*s_values(mode,s)*mean(transpose(V(:,mode,s)),2);
        SVD_modes(:,mode,s)=G_SVDmatrix(:,mode);
    end
    
	fprintf('Global SVD shimming is going to run.\n');
	
	% Global SVD shimming %
	for mode=1:max_mode(:,s)
		fprintf(sprintf('%d mode\n',mode));
		G_SVDshimfield(:,:,:,mode,s)=reshape(-G_SVDmatrix(:,1:mode)*lsqminnorm(G_SVDmatrix(:,1:mode),subjects_B(:,s),1e-9),[size(Fieldmap_brain)]);
		G_SVDshimming(:,:,:,mode,s)=reshape(subjects_B(:,s),size(Fieldmap_brain))+G_SVDshimfield(:,:,:,mode,s);
	end
	
	fprintf('Slice-selecting SVD shimming is going to run.\n');
	% Slice-selecting SVD shimming %
	
	SS_SVDmatrix=zeros(1,size(Fieldmap_brain,2),size(Fieldmap_brain,3),1);	
	for Z=size(Fieldmap_brain,1):-1:1
		fprintf(sprintf('%d slice\n',size(Fieldmap_brain,1)-Z+1));
		Bs=reshape(subjects_Bs(:,:,Z,s),[size(Fieldmap_brain,2)*size(Fieldmap_brain,3),1]);
		for mode=1:max_mode(:,s)
			fprintf(sprintf('%d mode\n',mode));
			SS_SVDfield=reshape(G_SVDmatrix(:,mode),[size(Fieldmap_brain)]);
			SS_SVDmatrix(1,:,:,mode)=SS_SVDfield(Z,:,:);
			As=reshape(SS_SVDmatrix(1,:,:,1:mode),[size(Fieldmap_brain,2)*size(Fieldmap_brain,3),mode]);
			SS_SVDshimfield(1,:,:,Z,mode,s)=reshape(-As*lsqminnorm(As,Bs,1e-9),[1,size(Fieldmap_brain,2),size(Fieldmap_brain,3)]);
			SS_SVDshimming(1,:,:,Z,mode,s)=reshape(Bs,[1,size(Fieldmap_brain,2),size(Fieldmap_brain,3)])+SS_SVDshimfield(1,:,:,Z,mode,s);
		end
	end
end

fprintf('Cooling down...\n')
save SVD_shimming.mat G_SVDshimfield G_SVDshimming SS_SVDshimfield SS_SVDshimming -v7.3

fprintf('Finished without Errors!\nCongrat!\n');
fprintf('The results have been saved in your computer. Check it!\n\n\n');
fprintf('Now, I am going to visualize the results for you\n');


%*************************************************************************%
%*************************************************************************%
%                           Visualizing Results                           %
%*************************************************************************%
%*************************************************************************%

fprintf('*************************************************************************\n');
fprintf('*************************************************************************\n');
fprintf('                           Visualizing Results                           \n');
fprintf('*************************************************************************\n');
fprintf('*************************************************************************\n');

fprintf('The power spectrum of SVD modes\n\n');

% Figure 1 %
% The power spectrum of SVD modes %

for s=1:num
    In_power(:,s)=(s_values(:,s).^2)/sum(s_values(:,s).^2,1);
end
Cum_power=cumsum(In_power);

mean_In_power=mean(In_power,2);
std_In_power=std(Cum_power,0,2);
mean_Cum_power=mean(Cum_power,2);
std_Cum_power=std(std_In_power,0,2);

save Figure1_data mean_In_power std_In_power mean_Cum_power std_Cum_power -v7.3

figure
x=1:(num-1);
f1=bar(x,mean_In_power*100);
hold on
box off
ax=gca;
xlabel('SVD mode');
ylabel('Individual Power (%)');
ax.XTick=[1 3 8 15 24 35];
ax.YMinorTick='on';
ax.FontSize=25;
yyaxis right
err=std_Cum_power*100;
f2=errorbar(x,mean_Cum_power*100,err,'-o');
ylabel('Cumulative power (%)');
legend('Individual','Cumulative','Location','east');
ax.YMinorTick='on';
text(1,50,'49.3%','Color','r','FontSize',15);
text(3,62,'61.3%','Color','r','FontSize',15);
text(8,75,'74.6%','Color','r','FontSize',15);
text(15,84,'84.1%','Color','r','FontSize',15);
text(24,92,'92.4%','Color','r','FontSize',15);
text(35,99.3,'99.5%','Color','r','FontSize',15);

fprintf('Generating Nifti files of individual SVD modes...\n\n');
% Generating Nifti files of individual SVD modes %

average_fieldmap=reshape(mean(subjects_B,2),size(Fieldmap_brain));
tempnii2 = MRIread('template.nii');
tempnii2.vol = average_fieldmap;
MRIwrite(tempnii2,'average_fieldmap.nii','double');
fprintf('average_fieldmap.nii has been saved.\n\n');

average_modes=mean(SVD_modes,3);
for mode=1:12
    eval(sprintf('average_mode%d=reshape(average_modes(:,1),[size(Fieldmap_brain)]);',mode));
    eval(sprintf('tempnii2.vol = average_mode%d;',mode));
    MRIwrite(tempnii2,sprintf('average_mode%d.nii',mode),'double');
    fprintf(sprintf('average_mode%d.nii has been saved.\n\n',mode));
end

clear all;
fprintf('Data loading...\n');
load('Spherical_harmonic_shimming.mat')
load('subjects_data.mat')
load('SVD_shimming.mat')

% Figure 2 %

Fieldmap_brain=zeros(size(G_SHshimfield,1),size(G_SHshimfield,2),size(G_SHshimfield,3));
num=size(G_SHshimfield,5);
for mode=1:12
    for s=1:num
        DOT_GSVD(mode,s)=abs(dot(subjects_B(:,s),reshape(G_SVDshimfield(:,:,:,mode,s),[size(Fieldmap_brain,1)*size(Fieldmap_brain,2)*size(Fieldmap_brain,3),1]))./(norm(subjects_B(:,s))*norm(reshape(G_SVDshimfield(:,:,:,mode,s),[size(Fieldmap_brain,1)*size(Fieldmap_brain,2)*size(Fieldmap_brain,3),1]))));
        DOT_GSH(mode,s)=abs(dot(subjects_B(:,s),reshape(G_SHshimfield(:,:,:,mode,s),[size(Fieldmap_brain,1)*size(Fieldmap_brain,2)*size(Fieldmap_brain,3),1]))./(norm(subjects_B(:,s))*norm(reshape(G_SHshimfield(:,:,:,mode,s),[size(Fieldmap_brain,1)*size(Fieldmap_brain,2)*size(Fieldmap_brain,3),1]))));
    end
end

mean_DOT_GSVD=mean(DOT_GSVD,2);
std_DOT_GSVD=std(DOT_GSVD,0,2);
mean_DOT_GSH=mean(DOT_GSH,2);
std_DOT_GSH=std(DOT_GSH,0,2);

for mode=1:12
    for s=1:num
        for r=1:88
            a(r,:,:)=SS_SVDshimfield(1,:,:,r,mode,s);
            b(r,:,:)=SS_SHshimfield(1,:,:,r,mode,s);
        end
        DOT_SS_SVD(mode,s)=abs(dot(subjects_B(:,s),reshape(a,[88*88*99,1]))/(norm(subjects_B(:,s))*norm(reshape(a,[88*88*99,1]))));
        DOT_SS_SH(mode,s)=abs(dot(subjects_B(:,s),reshape(b,[88*88*99,1]))/(norm(subjects_B(:,s))*norm(reshape(b,[88*88*99,1]))));
    end
end

mean_DOT_SS_SVD=mean(DOT_SS_SVD,2);
std_DOT_SS_SVD=std(DOT_SS_SVD,0,2);
mean_DOT_SS_SH=mean(DOT_SS_SH,2);
std_DOT_SS_SH=std(DOT_SS_SH,0,2);


save Figure2_data mean_DOT_GSVD std_DOT_GSVD mean_DOT_GSH std_DOT_GSH mean_DOT_SS_SVD std_DOT_SS_SVD mean_DOT_SS_SH std_DOT_SS_SH -v7.3

figure
x=1:12;
err=std_DOT_GSVD*100;
f1=errorbar(x,mean_DOT_GSVD*100,err,'-s','Color','k','LineWidth',1,'MarkerSize',6);
hold on
box off
ax=gca;
ax.XTick=[1 2 3 4 5 6 7 8 9 10 11 12];
ax.XLim=[1,12];
xlabel('SVD mode / SH order');
ylabel('Absolute normalized inner product (%)');
ax.YMinorTick='on';
ax.FontSize=25;
err=std_DOT_GSH*100;
f2=errorbar(x,mean_DOT_GSH*100,err,'-o','Color','k','LineWidth',1,'MarkerSize',6);
err=std_DOT_SS_SVD*100;
f3=errorbar(x,mean_DOT_SS_SVD*100,err,'--s','Color','r','LineWidth',1,'MarkerSize',6);
err=std_DOT_SS_SH*100;
f4=errorbar(x,mean_DOT_SS_SH*100,err,'--o','Color','r','LineWidth',1,'MarkerSize',6);
legend('Global SVD shimming','Global SH shimming','Slice-selecting SVD shimming','Slice-selecting SH shimming','Location','east');


% Figure 3 %

for mode=1:12
    for s=1:num
        N1(mode,s)=nnz(G_SHshimming(:,:,:,mode+1,s));
        RMS_GSHshimming(mode,s)=sqrt(sum((reshape(G_SHshimming(:,:,:,mode+1,s),[88*88*99,1]).*reshape(G_SHshimming(:,:,:,mode+1,s),[88*88*99,1])))/N1(mode,s));
        N2(mode,s)=nnz(G_SVDshimming(:,:,:,mode,s));
        RMS_GSVDshimming(mode,s)=sqrt(sum((reshape(G_SVDshimming(:,:,:,mode,s),[88*88*99,1]).*reshape(G_SVDshimming(:,:,:,mode,s),[88*88*99,1])))/N2(mode,s));
    end
end

mean_RMS_GSVDshimming=mean(RMS_GSVDshimming,2);
std_RMS_GSVDshimming=std(RMS_GSVDshimming,0,2);
mean_RMS_GSHshimming=mean(RMS_GSHshimming,2);
std_RMS_GSHshimming=std(RMS_GSHshimming,0,2);

for mode=1:12
    for s=1:num
        for r=1:88
            a(r,:,:)=SS_SVDshimming(1,:,:,r,mode,s);
            b(r,:,:)=SS_SHshimming(1,:,:,r,mode,s);
        end
        N1(mode,s)=nnz(b);
        RMS_SS_SHshimming(mode,s)=sqrt(sum((reshape(b,[88*88*99,1]).*reshape(b,[88*88*99,1])))/N1(mode,s));
        N2(mode,s)=nnz(a);
        RMS_SS_SVDshimming(mode,s)=sqrt(sum((reshape(a,[88*88*99,1]).*reshape(a,[88*88*99,1])))/N2(mode,s));
    end
end

mean_RMS_SS_SVDshimming=mean(RMS_SS_SVDshimming,2);
std_RMS_SS_SVDshimming=std(RMS_SS_SVDshimming,0,2);
mean_RMS_SS_SHshimming=mean(RMS_SS_SHshimming,2);
std_RMS_SS_SHshimming=std(RMS_SS_SHshimming,0,2);

save Figure3_data mean_RMS_GSVDshimming std_RMS_GSVDshimming mean_RMS_GSHshimming std_RMS_GSHshimming mean_RMS_SS_SVDshimming std_RMS_SS_SVDshimming mean_RMS_SS_SHshimming std_RMS_SS_SHshimming -v7.3

figure
x=1:12;
err=std_RMS_GSVDshimming;
f1=errorbar(x,mean_RMS_GSVDshimming,err,'-s','Color','k','LineWidth',1,'MarkerSize',6);
hold on
box off
ax=gca;
ax.XTick=[1 2 3 4 5 6 7 8 9 10 11 12];
ax.XLim=[1,12];
xlabel('SVD mode / SH order');
ylabel('Residual off-resonance (ppm)');
ax.YMinorTick='on';
ax.FontSize=25;
err=std_RMS_GSHshimming;
f2=errorbar(x,mean_RMS_GSHshimming,err,'-o','Color','k','LineWidth',1,'MarkerSize',6);
err=std_RMS_SS_SVDshimming;
f3=errorbar(x,mean_RMS_SS_SVDshimming,err,'--s','Color','r','LineWidth',1,'MarkerSize',6);
err=std_RMS_SS_SHshimming;
f4=errorbar(x,mean_RMS_SS_SHshimming,err,'--o','Color','r','LineWidth',1,'MarkerSize',6);
legend('Global SVD shimming','Global SH shimming','Slice-selecting SVD shimming','Slice-selecting SH shimming');

% Simulated Shimming results %

for mode=1:7 % a representive result (subject 23)
    a=G_SHshimming(:,:,:,mode+1,23); 
    eval(sprintf('rG_SHshimming_%dorder=a;',mode));
    eval(sprintf('tempnii2.vol = rG_SHshimming_%dorder;',mode));
    MRIwrite(tempnii2,sprintf('rG_SHshimming_%dorder.nii',mode),'double');
    fprintf(sprintf('rG_SHshimming_%dorder.nii has been saved.\n\n',mode));
    
    b=G_SVDshimming(:,:,:,mode,23);
    eval(sprintf('rG_SVDshimming_%dmode=b;',mode));
    eval(sprintf('tempnii2.vol = rG_SVDshimming_%dmode;',mode));
    MRIwrite(tempnii2,sprintf('rG_SVDshimming_%dmode.nii',mode),'double');
    fprintf(sprintf('rG_SVDshimming_%dmode.nii has been saved.\n\n',mode));   
    
    for r=1:88
        c(r,:,:)=SS_SHshimming(1,:,:,r,mode+1,23);
    end
    eval(sprintf('rSS_SHshimming_%dorder=c;',mode));
    eval(sprintf('tempnii2.vol = rSS_SHshimming_%dorder;',mode));
    MRIwrite(tempnii2,sprintf('rSS_SHshimming_%dorder.nii',mode),'double');
    fprintf(sprintf('rSS_SHshimming_%dorder.nii has been saved.\n\n',mode));    

    for r=1:88
        d(r,:,:)=SS_SVDshimming(1,:,:,r,mode,23);
    end
    eval(sprintf('rSS_SVDshimming_%dorder=d;',mode));
    eval(sprintf('tempnii2.vol = rSS_SVDshimming_%dorder;',mode));
    MRIwrite(tempnii2,sprintf('rSS_SVDshimming_%dorder.nii',mode),'double');
    fprintf(sprintf('rSS_SVDshimming_%dorder.nii has been saved.\n\n',mode));  
end



