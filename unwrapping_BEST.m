function [phase1,phase2,vector1,vector2]=unwrapping_BEST(phase1,phase2,gmap1,gmap2,gnumber1,gnumber2,index1,index2,vector1,vector2)

for q=1:128*128*96*3
    switch index1(q,4)
        case 1
		if index1(q,1)<128
            if gmap1(index1(q,1)+1,index1(q,2),index1(q,3))==0 & gmap1(index1(q,1),index1(q,2),index1(q,3))==0
                if (phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))>pi
                    phase1(index1(q,1)+1,index1(q,2),index1(q,3))=phase1(index1(q,1)+1,index1(q,2),index1(q,3))-2*pi;
                    gmap1(index1(q,1)+1,index1(q,2),index1(q,3))=gnumber1;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gnumber1;
                    gnumber1=gnumber1+1;
                elseif (phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))<-pi
                    phase1(index1(q,1)+1,index1(q,2),index1(q,3))=phase1(index1(q,1)+1,index1(q,2),index1(q,3))+2*pi;
                    gmap1(index1(q,1)+1,index1(q,2),index1(q,3))=gnumber1;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gnumber1;
                    gnumber1=gnumber1+1;
                elseif abs((phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3))))<=pi
                    gmap1(index1(q,1)+1,index1(q,2),index1(q,3))=gnumber1;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gnumber1;
                    gnumber1=gnumber1+1;
                end
            elseif gmap1(index1(q,1)+1,index1(q,2),index1(q,3))~=0 & gmap1(index1(q,1),index1(q,2),index1(q,3))==0
                if (phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))>pi
					int=round((phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                    phase1(index1(q,1),index1(q,2),index1(q,3))=phase1(index1(q,1),index1(q,2),index1(q,3))+2*pi*int;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gmap1(index1(q,1)+1,index1(q,2),index1(q,3));
                elseif (phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))<-pi
					int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1)+1,index1(q,2),index1(q,3)))/(2*pi));
                    phase1(index1(q,1),index1(q,2),index1(q,3))=phase1(index1(q,1),index1(q,2),index1(q,3))-2*pi*int;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gmap1(index1(q,1)+1,index1(q,2),index1(q,3));
                elseif abs((phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3))))<=pi
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gmap1(index1(q,1)+1,index1(q,2),index1(q,3));
                end
            elseif gmap1(index1(q,1)+1,index1(q,2),index1(q,3))==0 & gmap1(index1(q,1),index1(q,2),index1(q,3))~=0
                if (phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))>pi
					int=round((phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                    phase1(index1(q,1)+1,index1(q,2),index1(q,3))=phase1(index1(q,1)+1,index1(q,2),index1(q,3))-2*pi*int;
                    gmap1(index1(q,1)+1,index1(q,2),index1(q,3))=gmap1(index1(q,1),index1(q,2),index1(q,3));
                elseif (phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))<-pi
					int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1)+1,index1(q,2),index1(q,3)))/(2*pi));
                    phase1(index1(q,1)+1,index1(q,2),index1(q,3))=phase1(index1(q,1)+1,index1(q,2),index1(q,3))+2*pi*int;
                    gmap1(index1(q,1)+1,index1(q,2),index1(q,3))=gmap1(index1(q,1),index1(q,2),index1(q,3));
                elseif abs((phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3))))<=pi
                    gmap1(index1(q,1)+1,index1(q,2),index1(q,3))=gmap1(index1(q,1),index1(q,2),index1(q,3));
                end
            elseif gmap1(index1(q,1)+1,index1(q,2),index1(q,3))~=gmap1(index1(q,1),index1(q,2),index1(q,3))
                groupsize_a=nnz(gmap1(gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))));
                groupsize_b=nnz(gmap1(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))));
                if (phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))>pi
                    if groupsize_a>groupsize_b
						int=round((phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                        phase1=phase1+(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(2*pi*int);
                        gmap1=gmap1+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1)+1,index1(q,2),index1(q,3))-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a<groupsize_b
						int=round((phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                        phase1=phase1-(gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*(2*pi*int);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*gmap1(index1(q,1)+1,index1(q,2),index1(q,3))+...
                            (gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a==groupsize_b
                        int=round((phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                        which=(gmap1(index1(q,1)+1,index1(q,2),index1(q,3))>=gmap1(index1(q,1),index1(q,2),index1(q,3)));
                        phase1=phase1+((-1)^which)*(gmap1==gmap1(index1(q,1)+1*which,index1(q,2),index1(q,3))).*(2*pi*int);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*(gmap1(index1(q,1)+1,index1(q,2),index1(q,3))*which)+...
                            (gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*which);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*(1-which))+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1)+1,index1(q,2),index1(q,3))*(1-which));
                    end
                elseif (phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))<-pi
                    if groupsize_a>groupsize_b
						int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1)+1,index1(q,2),index1(q,3)))/(2*pi));
                        phase1=phase1-(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(2*pi*int);
                        gmap1=gmap1+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1)+1,index1(q,2),index1(q,3))-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a<groupsize_b
						int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1)+1,index1(q,2),index1(q,3)))/(2*pi));
                        phase1=phase1+(gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*(2*pi*int);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*gmap1(index1(q,1)+1,index1(q,2),index1(q,3))+...
                            (gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a==groupsize_b
						int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1)+1,index1(q,2),index1(q,3)))/(2*pi));
                        which=(gmap1(index1(q,1)+1,index1(q,2),index1(q,3))>=gmap1(index1(q,1),index1(q,2),index1(q,3)));
                        phase1=phase1-((-1)^which)*(gmap1==gmap1(index1(q,1)+1*which,index1(q,2),index1(q,3))).*(2*pi*int);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*(gmap1(index1(q,1)+1,index1(q,2),index1(q,3))*which)+...
                            (gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*which);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*(1-which))+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1)+1,index1(q,2),index1(q,3))*(1-which));
                    end
                elseif abs((phase1(index1(q,1)+1,index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3))))<=pi
                    if groupsize_a>groupsize_b
                        gmap1=gmap1+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1)+1,index1(q,2),index1(q,3))-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a<groupsize_b
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*gmap1(index1(q,1)+1,index1(q,2),index1(q,3))+...
                            (gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a==groupsize_b
                        which=(gmap1(index1(q,1)+1,index1(q,2),index1(q,3))>=gmap1(index1(q,1),index1(q,2),index1(q,3)));
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*(gmap1(index1(q,1)+1,index1(q,2),index1(q,3))*which)+...
                            (gmap1==gmap1(index1(q,1)+1,index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*which);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*(1-which))+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1)+1,index1(q,2),index1(q,3))*(1-which));
                    end
                end
            end
		end
        case 2
		if index1(q,2)<128
            if gmap1(index1(q,1),index1(q,2)+1,index1(q,3))==0 & gmap1(index1(q,1),index1(q,2),index1(q,3))==0
                if (phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))>pi
                    phase1(index1(q,1),index1(q,2)+1,index1(q,3))=phase1(index1(q,1),index1(q,2)+1,index1(q,3))-2*pi;
                    gmap1(index1(q,1),index1(q,2)+1,index1(q,3))=gnumber1;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gnumber1;
                    gnumber1=gnumber1+1;
                elseif (phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))<-pi
                    phase1(index1(q,1),index1(q,2)+1,index1(q,3))=phase1(index1(q,1),index1(q,2)+1,index1(q,3))+2*pi;
                    gmap1(index1(q,1),index1(q,2)+1,index1(q,3))=gnumber1;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gnumber1;
                    gnumber1=gnumber1+1;
                elseif abs((phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3))))<=pi
                    gmap1(index1(q,1),index1(q,2)+1,index1(q,3))=gnumber1;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gnumber1;
                    gnumber1=gnumber1+1;
                end
            elseif gmap1(index1(q,1),index1(q,2)+1,index1(q,3))~=0 & gmap1(index1(q,1),index1(q,2),index1(q,3))==0
                if (phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))>pi
					int=round((phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                    phase1(index1(q,1),index1(q,2),index1(q,3))=phase1(index1(q,1),index1(q,2),index1(q,3))+2*pi*int;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gmap1(index1(q,1),index1(q,2)+1,index1(q,3));
                elseif (phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))<-pi
					int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2)+1,index1(q,3)))/(2*pi));
                    phase1(index1(q,1),index1(q,2),index1(q,3))=phase1(index1(q,1),index1(q,2),index1(q,3))-2*pi*int;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gmap1(index1(q,1),index1(q,2)+1,index1(q,3));
                elseif abs((phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3))))<=pi
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gmap1(index1(q,1),index1(q,2)+1,index1(q,3));
                end
            elseif gmap1(index1(q,1),index1(q,2)+1,index1(q,3))==0 & gmap1(index1(q,1),index1(q,2),index1(q,3))~=0
                if (phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))>pi
					int=round((phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                    phase1(index1(q,1),index1(q,2)+1,index1(q,3))=phase1(index1(q,1),index1(q,2)+1,index1(q,3))-2*pi*int;
                    gmap1(index1(q,1),index1(q,2)+1,index1(q,3))=gmap1(index1(q,1),index1(q,2),index1(q,3));
                elseif (phase1(index1(q,1),index1(q,2)+1,index1(q,3))-vector1(index1(q,1),index1(q,2),index1(q,3)))<-pi
					int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2)+1,index1(q,3)))/(2*pi));
                    phase1(index1(q,1),index1(q,2)+1,index1(q,3))=phase1(index1(q,1),index1(q,2)+1,index1(q,3))+2*pi*int;
                    gmap1(index1(q,1),index1(q,2)+1,index1(q,3))=gmap1(index1(q,1),index1(q,2),index1(q,3));
                elseif abs((phase1(index1(q,1),index1(q,2)+1,index1(q,3))-vector1(index1(q,1),index1(q,2),index1(q,3))))<=pi
                    gmap1(index1(q,1),index1(q,2)+1,index1(q,3))=gmap1(index1(q,1),index1(q,2),index1(q,3));
                end
            elseif gmap1(index1(q,1),index1(q,2)+1,index1(q,3))~=gmap1(index1(q,1),index1(q,2),index1(q,3))
                groupsize_a=nnz(gmap1(gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))));
                groupsize_b=nnz(gmap1(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))));
                if (phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))>pi
                    if groupsize_a>groupsize_b
						int=round((phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                        phase1=phase1+(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(2*pi*int);
                        gmap1=gmap1+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2)+1,index1(q,3))-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a<groupsize_b
						int=round((phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                        phase1=phase1-(gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*(2*pi*int);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*gmap1(index1(q,1),index1(q,2)+1,index1(q,3))+...
                            (gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a==groupsize_b
                        int=round((phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                        which=(gmap1(index1(q,1),index1(q,2)+1,index1(q,3))>=gmap1(index1(q,1),index1(q,2),index1(q,3)));
                        phase1=phase1+((-1)^which)*(gmap1==gmap1(index1(q,1),index1(q,2)+1*which,index1(q,3))).*(2*pi*int);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*(gmap1(index1(q,1),index1(q,2)+1,index1(q,3))*which)+...
                            (gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*which);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*(1-which))+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2)+1,index1(q,3))*(1-which));
                    end
                elseif (phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)))<-pi
                    if groupsize_a>groupsize_b
						int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2)+1,index1(q,3)))/(2*pi));
                        phase1=phase1-(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(2*pi*int);
                        gmap1=gmap1+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2)+1,index1(q,3))-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a<groupsize_b
						int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2)+1,index1(q,3)))/(2*pi));
                        phase1=phase1+(gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*(2*pi*int);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*gmap1(index1(q,1),index1(q,2)+1,index1(q,3))+...
                            (gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a==groupsize_b
                        int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2)+1,index1(q,3)))/(2*pi));
                        which=(gmap1(index1(q,1),index1(q,2)+1,index1(q,3))>=gmap1(index1(q,1),index1(q,2),index1(q,3)));
                        phase1=phase1-((-1)^which)*(gmap1==gmap1(index1(q,1),index1(q,2)+1*which,index1(q,3))).*(2*pi*int);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*(gmap1(index1(q,1),index1(q,2)+1,index1(q,3))*which)+...
                            (gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*which);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*(1-which))+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2)+1,index1(q,3))*(1-which));
                    end
                elseif abs((phase1(index1(q,1),index1(q,2)+1,index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3))))<=pi
                    if groupsize_a>groupsize_b
                        gmap1=gmap1+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2)+1,index1(q,3))-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a<groupsize_b
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*gmap1(index1(q,1),index1(q,2)+1,index1(q,3))+...
                            (gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a==groupsize_b
                        which=(gmap1(index1(q,1),index1(q,2)+1,index1(q,3))>=gmap1(index1(q,1),index1(q,2),index1(q,3)));
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*(gmap1(index1(q,1),index1(q,2)+1,index1(q,3))*which)+...
                            (gmap1==gmap1(index1(q,1),index1(q,2)+1,index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*which);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*(1-which))+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2)+1,index1(q,3))*(1-which));
                    end
                end
            end
		end
        case 3
		if index1(q,3)<96
            if gmap1(index1(q,1),index1(q,2),index1(q,3)+1)==0 & gmap1(index1(q,1),index1(q,2),index1(q,3))==0
                if (phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))>pi
                    phase1(index1(q,1),index1(q,2),index1(q,3)+1)=phase1(index1(q,1),index1(q,2),index1(q,3)+1)-2*pi;
                    gmap1(index1(q,1),index1(q,2),index1(q,3)+1)=gnumber1;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gnumber1;
                    gnumber1=gnumber1+1;
                elseif (phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))<-pi
                    phase1(index1(q,1),index1(q,2),index1(q,3)+1)=phase1(index1(q,1),index1(q,2),index1(q,3)+1)+2*pi;
                    gmap1(index1(q,1),index1(q,2),index1(q,3)+1)=gnumber1;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gnumber1;
                    gnumber1=gnumber1+1;
                elseif abs((phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3))))<=pi
                    gmap1(index1(q,1),index1(q,2),index1(q,3)+1)=gnumber1;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gnumber1;
                    gnumber1=gnumber1+1;
                end
            elseif gmap1(index1(q,1),index1(q,2),index1(q,3)+1)~=0 & gmap1(index1(q,1),index1(q,2),index1(q,3))==0
                if (phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))>pi
					int=round((phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                    phase1(index1(q,1),index1(q,2),index1(q,3))=phase1(index1(q,1),index1(q,2),index1(q,3))+2*pi;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gmap1(index1(q,1),index1(q,2),index1(q,3)+1);
                elseif (phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))<-pi
                    int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)+1))/(2*pi));
					phase1(index1(q,1),index1(q,2),index1(q,3))=phase1(index1(q,1),index1(q,2),index1(q,3))-2*pi*int;
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gmap1(index1(q,1),index1(q,2),index1(q,3)+1);
                elseif abs((phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3))))<=pi
                    gmap1(index1(q,1),index1(q,2),index1(q,3))=gmap1(index1(q,1),index1(q,2),index1(q,3)+1);
                end
            elseif gmap1(index1(q,1),index1(q,2),index1(q,3)+1)==0 & gmap1(index1(q,1),index1(q,2),index1(q,3))~=0
                if (phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))>pi
					int=round((phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                    phase1(index1(q,1),index1(q,2),index1(q,3)+1)=phase1(index1(q,1),index1(q,2),index1(q,3)+1)-2*pi*int;
                    gmap1(index1(q,1),index1(q,2),index1(q,3)+1)=gmap1(index1(q,1),index1(q,2),index1(q,3));
                elseif (phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))<-pi
                    phase1(index1(q,1),index1(q,2),index1(q,3)+1)=phase1(index1(q,1),index1(q,2),index1(q,3)+1)+2*pi;
                    gmap1(index1(q,1),index1(q,2),index1(q,3)+1)=gmap1(index1(q,1),index1(q,2),index1(q,3));
                elseif abs((phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3))))<=pi
                    gmap1(index1(q,1),index1(q,2),index1(q,3)+1)=gmap1(index1(q,1),index1(q,2),index1(q,3));
                end
            elseif gmap1(index1(q,1),index1(q,2),index1(q,3)+1)~=gmap1(index1(q,1),index1(q,2),index1(q,3))
                groupsize_a=nnz(gmap1(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)));
                groupsize_b=nnz(gmap1(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))));
                if (phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))>pi
                    if groupsize_a>groupsize_b
						int=round((phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                        phase1=phase1+(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(2*pi*int);
                        gmap1=gmap1+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3)+1)-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a<groupsize_b
						int=round((phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                        phase1=phase1-(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*(2*pi*int);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*gmap1(index1(q,1),index1(q,2),index1(q,3)+1)+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a==groupsize_b
                        int=round((phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))/(2*pi));
                        which=(gmap1(index1(q,1),index1(q,2),index1(q,3)+1)>=gmap1(index1(q,1),index1(q,2),index1(q,3)));
                        phase1=phase1+((-1)^which)*(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1*which)).*(2*pi*int);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*(gmap1(index1(q,1),index1(q,2),index1(q,3)+1)*which)+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*which);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*(1-which))+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3)+1)*(1-which));
                    end
                elseif (phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3)))<-pi
                    if groupsize_a>groupsize_b
						int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)+1))/(2*pi));
                        phase1=phase1-(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(2*pi*int);
                        gmap1=gmap1+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3)+1)-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a<groupsize_b
						int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)+1))/(2*pi));
                        phase1=phase1+(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*(2*pi*int);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*gmap1(index1(q,1),index1(q,2),index1(q,3)+1)+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a==groupsize_b
                        int=round((phase1(index1(q,1),index1(q,2),index1(q,3))-phase1(index1(q,1),index1(q,2),index1(q,3)+1))/(2*pi));
                        which=(gmap1(index1(q,1),index1(q,2),index1(q,3)+1)>=gmap1(index1(q,1),index1(q,2),index1(q,3)));
                        phase1=phase1-((-1)^which)*(gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1*which)).*(2*pi*int);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*(gmap1(index1(q,1),index1(q,2),index1(q,3)+1)*which)+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*which);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*(1-which))+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3)+1)*(1-which));
                    end
                elseif abs((phase1(index1(q,1),index1(q,2),index1(q,3)+1)-phase1(index1(q,1),index1(q,2),index1(q,3))))<=pi
                    if groupsize_a>groupsize_b
                        gmap1=gmap1+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3)+1)-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a<groupsize_b
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*gmap1(index1(q,1),index1(q,2),index1(q,3)+1)+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*gmap1(index1(q,1),index1(q,2),index1(q,3));
                    elseif groupsize_a==groupsize_b
                        which=(gmap1(index1(q,1),index1(q,2),index1(q,3)+1)>=gmap1(index1(q,1),index1(q,2),index1(q,3)));
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*(gmap1(index1(q,1),index1(q,2),index1(q,3)+1)*which)+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3)+1)).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*which);
                        gmap1=gmap1-...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3))*(1-which))+...
                            (gmap1==gmap1(index1(q,1),index1(q,2),index1(q,3))).*(gmap1(index1(q,1),index1(q,2),index1(q,3)+1)*(1-which));
                    end
                end
            end
		end
    end

	switch index2(q,4)
		case 1
		if index2(q,1)<128
			if gmap2(index2(q,1)+1,index2(q,2),index2(q,3))==0 & gmap2(index2(q,1),index2(q,2),index2(q,3))==0
				if (phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))>pi
					phase2(index2(q,1)+1,index2(q,2),index2(q,3))=phase2(index2(q,1)+1,index2(q,2),index2(q,3))-2*pi;
					gmap2(index2(q,1)+1,index2(q,2),index2(q,3))=gnumber2;
					gmap2(index2(q,1),index2(q,2),index2(q,3))=gnumber2;
					gnumber2=gnumber2+1;
				elseif (phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))<-pi
					phase2(index2(q,1)+1,index2(q,2),index2(q,3))=phase2(index2(q,1)+1,index2(q,2),index2(q,3))+2*pi;
					gmap2(index2(q,1)+1,index2(q,2),index2(q,3))=gnumber2;
					gmap2(index2(q,1),index2(q,2),index2(q,3))=gnumber2;
					gnumber2=gnumber2+1;
                elseif abs((phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3))))<=pi
                    gmap2(index2(q,1)+1,index2(q,2),index2(q,3))=gnumber2;
                    gmap2(index2(q,1),index2(q,2),index2(q,3))=gnumber2;
                    gnumber2=gnumber2+1;
				end
			elseif gmap2(index2(q,1)+1,index2(q,2),index2(q,3))~=0 & gmap2(index2(q,1),index2(q,2),index2(q,3))==0
				if (phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))>pi
					int=round((phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
					phase2(index2(q,1),index2(q,2),index2(q,3))=phase2(index2(q,1),index2(q,2),index2(q,3))+2*pi*int;
					gmap2(index2(q,1),index2(q,2),index2(q,3))=gmap2(index2(q,1)+1,index2(q,2),index2(q,3));
				elseif (phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index1(q,1),index2(q,2),index2(q,3)))<-pi
					int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1)+1,index2(q,2),index2(q,3)))/(2*pi));
					phase2(index2(q,1),index2(q,2),index2(q,3))=phase2(index2(q,1),index2(q,2),index2(q,3))-2*pi*int;
					gmap2(index2(q,1),index2(q,2),index2(q,3))=gmap2(index2(q,1)+1,index2(q,2),index2(q,3));
                elseif abs((phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index1(q,1),index2(q,2),index2(q,3))))<=pi
                    gmap2(index2(q,1),index2(q,2),index2(q,3))=gmap2(index2(q,1)+1,index2(q,2),index2(q,3));
				end
			elseif gmap2(index2(q,1)+1,index2(q,2),index2(q,3))==0 & gmap2(index2(q,1),index2(q,2),index2(q,3))~=0
				if (phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))>pi
					int=round((phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
					phase2(index2(q,1)+1,index2(q,2),index2(q,3))=phase2(index2(q,1)+1,index2(q,2),index2(q,3))-2*pi*int;
					gmap2(index2(q,1)+1,index2(q,2),index2(q,3))=gmap2(index2(q,1),index2(q,2),index2(q,3));
				elseif (phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))<-pi
					int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1)+1,index2(q,2),index2(q,3)))/(2*pi));
					phase2(index2(q,1)+1,index2(q,2),index2(q,3))=phase2(index2(q,1)+1,index2(q,2),index2(q,3))+2*pi*int;
					gmap2(index2(q,1)+1,index2(q,2),index2(q,3))=gmap2(index2(q,1),index2(q,2),index2(q,3));
                elseif abs((phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3))))<=pi
                    gmap2(index2(q,1)+1,index2(q,2),index2(q,3))=gmap2(index2(q,1),index2(q,2),index2(q,3));
				end
			elseif gmap2(index2(q,1)+1,index2(q,2),index2(q,3))~=gmap2(index2(q,1),index2(q,2),index2(q,3))
				groupsize_a=nnz(gmap2(gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))));
				groupsize_b=nnz(gmap2(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))));
				if (phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))>pi
					if groupsize_a>groupsize_b
						int=round((phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
						phase2=phase2+(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(2*pi*int);
						gmap2=gmap2+...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1)+1,index2(q,2),index2(q,3))-...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
					elseif groupsize_a<groupsize_b
						int=round((phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
						phase2=phase2-(gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*(2*pi*int);
                        gmap2=gmap2-...
							(gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*gmap2(index2(q,1)+1,index2(q,2),index2(q,3))+...
							(gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
                    elseif groupsize_a==groupsize_b
                        int=round((phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
                        which=(gmap2(index2(q,1)+1,index2(q,2),index2(q,3))>=gmap2(index2(q,1),index2(q,2),index2(q,3)));
                        phase2=phase2+((-1)^which)*(gmap2==gmap2(index2(q,1)+1*which,index2(q,2),index2(q,3))).*(2*pi*int);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*(gmap2(index2(q,1)+1,index2(q,2),index2(q,3))*which)+...
                            (gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*which);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*(1-which))+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1)+1,index2(q,2),index2(q,3))*(1-which));
					end
				elseif (phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))<-pi
					if groupsize_a>groupsize_b
						int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1)+1,index2(q,2),index2(q,3)))/(2*pi));
						phase2=phase2-(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(2*pi*int);
						gmap2=gmap2+...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1)+1,index2(q,2),index2(q,3))-...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
					elseif groupsize_a<groupsize_b
						int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1)+1,index2(q,2),index2(q,3)))/(2*pi));
						phase2=phase2+(gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*(2*pi*int);
						gmap2=gmap2-...
							(gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*gmap2(index2(q,1)+1,index2(q,2),index2(q,3))+...
							(gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
                    elseif groupsize_a==groupsize_b
                        int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1)+1,index2(q,2),index2(q,3)))/(2*pi));
                        which=(gmap2(index2(q,1)+1,index2(q,2),index2(q,3))>=gmap2(index2(q,1),index2(q,2),index2(q,3)));
                        phase2=phase2-((-1)^which)*(gmap2==gmap2(index2(q,1)+1*which,index2(q,2),index2(q,3))).*(2*pi*int);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*(gmap2(index2(q,1)+1,index2(q,2),index2(q,3))*which)+...
                            (gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*which);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*(1-which))+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1)+1,index2(q,2),index2(q,3))*(1-which));
					end
                elseif abs((phase2(index2(q,1)+1,index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3))))<=pi
                    if groupsize_a>groupsize_b
                        gmap2=gmap2+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1)+1,index2(q,2),index2(q,3))-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
                    elseif groupsize_a<groupsize_b
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*gmap2(index2(q,1)+1,index2(q,2),index2(q,3))+...
                            (gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
                    elseif groupsize_a==groupsize_b
                        which=(gmap2(index2(q,1)+1,index2(q,2),index2(q,3))>=gmap2(index2(q,1),index2(q,2),index2(q,3)));
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*(gmap2(index2(q,1)+1,index2(q,2),index2(q,3))*which)+...
                            (gmap2==gmap2(index2(q,1)+1,index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*which);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*(1-which))+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1)+1,index2(q,2),index2(q,3))*(1-which));
                    end
				end
			end
		end
		case 2
		if index2(q,2)<128
			if gmap2(index2(q,1),index2(q,2)+1,index2(q,3))==0 & gmap2(index2(q,1),index2(q,2),index2(q,3))==0
				if (phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))>pi
					phase2(index2(q,1),index2(q,2)+1,index2(q,3))=phase2(index2(q,1),index2(q,2)+1,index2(q,3))-2*pi;
					gmap2(index2(q,1),index2(q,2)+1,index2(q,3))=gnumber2;
					gmap2(index2(q,1),index2(q,2),index2(q,3))=gnumber2;
					gnumber2=gnumber2+1;
				elseif (phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))<-pi
					phase2(index2(q,1),index2(q,2)+1,index2(q,3))=phase2(index2(q,1),index2(q,2)+1,index2(q,3))+2*pi;
					gmap2(index2(q,1),index2(q,2)+1,index2(q,3))=gnumber2;
					gmap2(index2(q,1),index2(q,2),index2(q,3))=gnumber2;
					gnumber2=gnumber2+1;
                elseif abs((phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3))))<=pi
                    gmap2(index2(q,1),index2(q,2)+1,index2(q,3))=gnumber2;
                    gmap2(index2(q,1),index2(q,2),index2(q,3))=gnumber2;
                    gnumber2=gnumber2+1;
				end
			elseif gmap2(index2(q,1),index2(q,2)+1,index2(q,3))~=0 & gmap2(index2(q,1),index2(q,2),index2(q,3))==0
				if (phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))>pi
					int=round((phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
					phase2(index2(q,1),index2(q,2),index2(q,3))=phase2(index2(q,1),index2(q,2),index2(q,3))+2*pi*int;
					gmap2(index2(q,1),index2(q,2),index2(q,3))=gmap2(index2(q,1),index2(q,2)+1,index2(q,3));
				elseif (phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))<-pi
					int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2)+1,index2(q,3)))/(2*pi));
					phase2(index2(q,1),index2(q,2),index2(q,3))=phase2(index2(q,1),index2(q,2),index2(q,3))-2*pi*int;
					gmap2(index2(q,1),index2(q,2),index2(q,3))=gmap2(index2(q,1),index2(q,2)+1,index2(q,3));
                elseif abs((phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3))))<=pi
                    gmap2(index2(q,1),index2(q,2),index2(q,3))=gmap2(index2(q,1),index2(q,2)+1,index2(q,3));
				end
			elseif gmap2(index2(q,1),index2(q,2)+1,index2(q,3))==0 & gmap2(index2(q,1),index2(q,2),index2(q,3))~=0
				if (phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))>pi
					int=round((phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
					phase2(index2(q,1),index2(q,2)+1,index2(q,3))=phase2(index2(q,1),index2(q,2)+1,index2(q,3))-2*pi*int;
					gmap2(index2(q,1),index2(q,2)+1,index2(q,3))=gmap2(index2(q,1),index2(q,2),index2(q,3));
				elseif (phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))<-pi
					int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2)+1,index2(q,3)))/(2*pi));
					phase2(index2(q,1),index2(q,2)+1,index2(q,3))=phase2(index2(q,1),index2(q,2)+1,index2(q,3))+2*pi*int;
					gmap2(index2(q,1),index2(q,2)+1,index2(q,3))=gmap2(index2(q,1),index2(q,2),index2(q,3));
                elseif abs((phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3))))<=pi
                    gmap2(index2(q,1),index2(q,2)+1,index2(q,3))=gmap2(index2(q,1),index2(q,2),index2(q,3));
				end
			elseif gmap2(index2(q,1),index2(q,2)+1,index2(q,3))~=gmap2(index2(q,1),index2(q,2),index2(q,3))
				groupsize_a=nnz(gmap2(gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))));
				groupsize_b=nnz(gmap2(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))));
				if (phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))>pi
					if groupsize_a>groupsize_b
						int=round((phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
						phase2=phase2+(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(2*pi*int);
						gmap2=gmap2+...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2)+1,index2(q,3))-...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
					elseif groupsize_a<groupsize_b
						int=round((phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
						phase2=phase2-(gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*(2*pi*int);
						gmap2=gmap2-...
							(gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*gmap2(index2(q,1),index2(q,2)+1,index2(q,3))+...
							(gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
                    elseif groupsize_a==groupsize_b
                        int=round((phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
                        which=(gmap2(index2(q,1),index2(q,2)+1,index2(q,3))>=gmap2(index2(q,1),index2(q,2),index2(q,3)));
                        phase2=phase2+((-1)^which)*(gmap2==gmap2(index2(q,1),index2(q,2)+1*which,index2(q,3))).*(2*pi*int);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*(gmap2(index2(q,1),index2(q,2)+1,index2(q,3))*which)+...
                            (gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*which);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*(1-which))+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2)+1,index2(q,3))*(1-which));
					end
				elseif (phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)))<-pi
					if groupsize_a>groupsize_b
						int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2)+1,index2(q,3)))/(2*pi));
						phase2=phase2-(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(2*pi*int);
						gmap2=gmap2+...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2)+1,index2(q,3))-...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
					elseif groupsize_a<groupsize_b
						int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2)+1,index2(q,3)))/(2*pi));
						phase2=phase2+(gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*(2*pi*int);
						gmap2=gmap2-...
							(gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*gmap2(index2(q,1),index2(q,2)+1,index2(q,3))+...
							(gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
                    elseif groupsize_a==groupsize_b
                        int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2)+1,index2(q,3)))/(2*pi));
                        which=(gmap2(index2(q,1),index2(q,2)+1,index2(q,3))>=gmap2(index2(q,1),index2(q,2),index2(q,3)));
                        phase2=phase2-((-1)^which)*(gmap2==gmap2(index2(q,1),index2(q,2)+1*which,index2(q,3))).*(2*pi*int);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*(gmap2(index2(q,1),index2(q,2)+1,index2(q,3))*which)+...
                            (gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*which);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*(1-which))+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2)+1,index2(q,3))*(1-which));
					end
                elseif abs((phase2(index2(q,1),index2(q,2)+1,index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3))))<=pi
                    if groupsize_a>groupsize_b
                        gmap2=gmap2+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2)+1,index2(q,3))-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
                    elseif groupsize_a<groupsize_b
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*gmap2(index2(q,1),index2(q,2)+1,index2(q,3))+...
                            (gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
                    elseif groupsize_a==groupsize_b
                        which=(gmap2(index2(q,1),index2(q,2)+1,index2(q,3))>=gmap2(index2(q,1),index2(q,2),index2(q,3)));
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*(gmap2(index2(q,1),index2(q,2)+1,index2(q,3))*which)+...
                            (gmap2==gmap2(index2(q,1),index2(q,2)+1,index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*which);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*(1-which))+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2)+1,index2(q,3))*(1-which));
                    end
				end
			end
		end
		case 3
		if index2(q,3)<96
			if gmap2(index2(q,1),index2(q,2),index2(q,3)+1)==0 & gmap2(index2(q,1),index2(q,2),index2(q,3))==0
				if (phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))>pi
					phase2(index2(q,1),index2(q,2),index2(q,3)+1)=phase2(index2(q,1),index2(q,2),index2(q,3)+1)-2*pi;
					gmap2(index2(q,1),index2(q,2),index2(q,3)+1)=gnumber2;
					gmap2(index2(q,1),index2(q,2),index2(q,3))=gnumber2;
					gnumber2=gnumber2+1;
				elseif (phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))<-pi
					phase2(index2(q,1),index2(q,2),index2(q,3)+1)=phase2(index2(q,1),index2(q,2),index2(q,3)+1)+2*pi;
					gmap2(index2(q,1),index2(q,2),index2(q,3)+1)=gnumber2;
					gmap2(index2(q,1),index2(q,2),index2(q,3))=gnumber2;
					gnumber2=gnumber2+1;
                elseif abs((phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3))))<=pi
                    gmap2(index2(q,1),index2(q,2),index2(q,3)+1)=gnumber2;
                    gmap2(index2(q,1),index2(q,2),index2(q,3))=gnumber2;
                    gnumber2=gnumber2+1;
				end
			elseif gmap2(index2(q,1),index2(q,2),index2(q,3)+1)~=0 & gmap2(index2(q,1),index2(q,2),index2(q,3))==0
				if (phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))>pi
					int=round((phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
					phase2(index2(q,1),index2(q,2),index2(q,3))=phase2(index2(q,1),index2(q,2),index2(q,3))+2*pi*int;
					gmap2(index2(q,1),index2(q,2),index2(q,3))=gmap2(index2(q,1),index2(q,2),index2(q,3)+1);
				elseif (phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))<-pi
					int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)+1))/(2*pi));
					phase2(index2(q,1),index2(q,2),index2(q,3))=phase2(index2(q,1),index2(q,2),index2(q,3))-2*pi*int;
					gmap2(index2(q,1),index2(q,2),index2(q,3))=gmap2(index2(q,1),index2(q,2),index2(q,3)+1);
                elseif abs((phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3))))<=pi
                    gmap2(index2(q,1),index2(q,2),index2(q,3))=gmap2(index2(q,1),index2(q,2),index2(q,3)+1);
				end
			elseif gmap2(index2(q,1),index2(q,2),index2(q,3)+1)==0 & gmap2(index2(q,1),index2(q,2),index2(q,3))~=0
				if (phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))>pi
					int=round((phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
					phase2(index2(q,1),index2(q,2),index2(q,3)+1)=phase2(index2(q,1),index2(q,2),index2(q,3)+1)-2*pi*int;
					gmap2(index2(q,1),index2(q,2),index2(q,3)+1)=gmap2(index2(q,1),index2(q,2),index2(q,3));
				elseif (phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))<-pi
					int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)+1))/(2*pi));
					phase2(index2(q,1),index2(q,2),index2(q,3)+1)=phase2(index2(q,1),index2(q,2),index2(q,3)+1)+2*pi*int;
					gmap2(index2(q,1),index2(q,2),index2(q,3)+1)=gmap2(index2(q,1),index2(q,2),index2(q,3));
                elseif abs((phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3))))<=pi
                    gmap2(index2(q,1),index2(q,2),index2(q,3)+1)=gmap2(index2(q,1),index2(q,2),index2(q,3));
				end
			elseif gmap2(index2(q,1),index2(q,2),index2(q,3)+1)~=gmap2(index2(q,1),index2(q,2),index2(q,3))
				groupsize_a=nnz(gmap2(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)));
				groupsize_b=nnz(gmap2(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))));
				if (phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))>pi
					if groupsize_a>groupsize_b
						int=round((phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
						phase2=phase2+(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(2*pi*int);
						gmap2=gmap2+...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3)+1)-...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
					elseif groupsize_a<groupsize_b
						int=round((phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
						phase2=phase2-(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*(2*pi*int);
						gmap2=gmap2-...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*gmap2(index2(q,1),index2(q,2),index2(q,3)+1)+...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*gmap2(index2(q,1),index2(q,2),index2(q,3));
                    elseif groupsize_a==groupsize_b
                        int=round((phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))/(2*pi));
                        which=(gmap2(index2(q,1),index2(q,2),index2(q,3)+1)>=gmap2(index2(q,1),index2(q,2),index2(q,3)));
                        phase2=phase2+((-1)^which)*(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1*which)).*(2*pi*int);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*(gmap2(index2(q,1),index2(q,2),index2(q,3)+1)*which)+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*which);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*(1-which))+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3)+1)*(1-which));
					end
				elseif (phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3)))<-pi
					if groupsize_a>groupsize_b
						int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)+1))/(2*pi));
						phase2=phase2-(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(2*pi*int);
						gmap2=gmap2+...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3)+1)-...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
					elseif groupsize_a<groupsize_b
						int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)+1))/(2*pi));
						phase2=phase2+(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*(2*pi*int);
						gmap2=gmap2-...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*gmap2(index2(q,1),index2(q,2),index2(q,3)+1)+...
							(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*gmap2(index2(q,1),index2(q,2),index2(q,3));
                    elseif groupsize_a==groupsize_b
                        int=round((phase2(index2(q,1),index2(q,2),index2(q,3))-phase2(index2(q,1),index2(q,2),index2(q,3)+1))/(2*pi));
                        which=(gmap2(index2(q,1),index2(q,2),index2(q,3)+1)>=gmap2(index2(q,1),index2(q,2),index2(q,3)));
                        phase2=phase2-((-1)^which)*(gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1*which)).*(2*pi*int);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*(gmap2(index2(q,1),index2(q,2),index2(q,3)+1)*which)+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*which);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*(1-which))+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3)+1)*(1-which));
					end
                elseif abs((phase2(index2(q,1),index2(q,2),index2(q,3)+1)-phase2(index2(q,1),index2(q,2),index2(q,3))))<=pi
                    if groupsize_a>groupsize_b
                        gmap2=gmap2+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3)+1)-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*gmap2(index2(q,1),index2(q,2),index2(q,3));
                    elseif groupsize_a<groupsize_b
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*gmap2(index2(q,1),index2(q,2),index2(q,3)+1)+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*gmap2(index2(q,1),index2(q,2),index2(q,3));
                    elseif groupsize_a==groupsize_b
                        which=(gmap2(index2(q,1),index2(q,2),index2(q,3)+1)>=gmap2(index2(q,1),index2(q,2),index2(q,3)));
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*(gmap2(index2(q,1),index2(q,2),index2(q,3)+1)*which)+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3)+1)).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*which);
                        gmap2=gmap2-...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3))*(1-which))+...
                            (gmap2==gmap2(index2(q,1),index2(q,2),index2(q,3))).*(gmap2(index2(q,1),index2(q,2),index2(q,3)+1)*(1-which));
                    end
				end
			end
		end
	end
end

end