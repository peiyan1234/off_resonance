function [index1,index2]=bestpath(edge1,edge2,r_edge1,r_edge2,s_edge1,index_r_edge1,s_edge2,index_r_edge2,index1,index2)

for ind=1:128*128*96*3
    if index_r_edge1(ind)<=128
        index1(ind,1)=index_r_edge1(ind);
        index1(ind,2)=1;
        index1(ind,3)=1;
        index1(ind,4)=1;
    elseif index_r_edge1(ind)<=128*128 & index_r_edge1(ind)>128
        if mod(index_r_edge1(ind),128) == 0
            index1(ind,1)=128;
            index1(ind,2)=index_r_edge1(ind)/128;
        else
            index1(ind,1)=mod(index_r_edge1(ind),128);
            index1(ind,2)=1+(index_r_edge1(ind)-index1(ind,1))/128;
        end
        index1(ind,3)=1;
        index1(ind,4)=1;
    elseif index_r_edge1(ind)<=128*128*96 & index_r_edge1(ind)>128*128
        if mod(index_r_edge1(ind),128) == 0
            index1(ind,1)=128;
            if mod(index_r_edge1(ind),128*128) == 0
                index1(ind,2)=128;
                index1(ind,3)=index_r_edge1(ind)/(128*128);
            else
                index1(ind,2)=1+(mod(index_r_edge1(ind),128*128))/128;
                index1(ind,3)=1+(index_r_edge1(ind)-mod(index_r_edge1(ind),128*128))/(128*128);
            end
        else
            index1(ind,1)=mod(index_r_edge1(ind),128);
            index1(ind,2)=1+(mod(index_r_edge1(ind),128*128)-index1(ind,1))/128;
            index1(ind,3)=1+(index_r_edge1(ind)-mod(index_r_edge1(ind),128*128))/(128*128);
        end
        index1(ind,4)=1;
    elseif index_r_edge1(ind)<=128*128*96*3 & index_r_edge1(ind)>128*128*96
        if mod(index_r_edge1(ind),128)==0
            index1(ind,1)=128;
            if mod(index_r_edge1(ind),128*128)==0
                index1(ind,2)=128;
                if mod(index_r_edge1(ind),128*128*96)==0
                    index1(ind,3)=96;
                    index1(ind,4)=index_r_edge1(ind)/(128*128*96);
                else
                    index1(ind,3)=mod(index_r_edge1(ind),128*128*96)/(128*128);
                    index1(ind,4)=1+(index_r_edge1(ind)-mod(index_r_edge1(ind),128*128*96))/(128*128*96);
                end
            else
                index1(ind,2)=mod(mod(index_r_edge1(ind),128*128*96),128*128)/128;
                index1(ind,3)=1+mod(index_r_edge1(ind)-mod(index_r_edge1(ind),128*128),128*128*96)/(128*128);
                index1(ind,4)=1+(index_r_edge1(ind)-mod(index_r_edge1(ind),128*128*96))/(128*128*96);
            end
        else
            index1(ind,1)=mod(index_r_edge1(ind),128);
            index1(ind,2)=1+(mod(index_r_edge1(ind),128*128)-index1(ind,1))/128;
            index1(ind,3)=1+(mod(index_r_edge1(ind),128*128*96)-mod(index_r_edge1(ind),128*128))/(128*128);
            index1(ind,4)=1+(index_r_edge1(ind)-mod(index_r_edge1(ind),128*128*96))/(128*128*96);
        end
    end
    
    if index_r_edge2(ind)<=128
        index2(ind,1)=index_r_edge2(ind);
        index2(ind,2)=1;
        index2(ind,3)=1;
        index2(ind,4)=1;
    elseif index_r_edge2(ind)<=128*128 & index_r_edge2(ind)>128
        if mod(index_r_edge2(ind),128) == 0
            index2(ind,1)=128;
            index2(ind,2)=index_r_edge2(ind)/128;
        else
            index2(ind,1)=mod(index_r_edge2(ind),128);
            index2(ind,2)=1+(index_r_edge2(ind)-index2(ind,1))/128;
        end
        index2(ind,3)=1;
        index2(ind,4)=1;
    elseif index_r_edge2(ind)<=128*128*96 & index_r_edge2(ind)>128*128
        if mod(index_r_edge2(ind),128) == 0
            index2(ind,1)=128;
            if mod(index_r_edge2(ind),128*128) == 0
                index2(ind,2)=128;
                index2(ind,3)=index_r_edge2(ind)/(128*128);
            else
                index2(ind,2)=1+(mod(index_r_edge2(ind),128*128))/128;
                index2(ind,3)=1+(index_r_edge2(ind)-mod(index_r_edge2(ind),128*128))/(128*128);
            end
        else
            index2(ind,1)=mod(index_r_edge2(ind),128);
            index2(ind,2)=1+(mod(index_r_edge2(ind),128*128)-index2(ind,1))/128;
            index2(ind,3)=1+(index_r_edge2(ind)-mod(index_r_edge2(ind),128*128))/(128*128);
        end
        index2(ind,4)=1;
    elseif index_r_edge2(ind)<=128*128*96*3 & index_r_edge2(ind)>128*128*96
        if mod(index_r_edge2(ind),128)==0
            index2(ind,1)=128;
            if mod(index_r_edge2(ind),128*128)==0
                index2(ind,2)=128;
                if mod(index_r_edge2(ind),128*128*96)==0
                    index2(ind,3)=96;
                    index2(ind,4)=index_r_edge2(ind)/(128*128*96);
                else
                    index2(ind,3)=mod(index_r_edge2(ind),128*128*96)/(128*128);
                    index2(ind,4)=1+(index_r_edge2(ind)-mod(index_r_edge2(ind),128*128*96))/(128*128*96);
                end
            else
                index2(ind,2)=mod(mod(index_r_edge2(ind),128*128*96),128*128)/128;
                index2(ind,3)=1+mod(index_r_edge2(ind)-mod(index_r_edge2(ind),128*128),128*128*96)/(128*128);
                index2(ind,4)=1+(index_r_edge2(ind)-mod(index_r_edge2(ind),128*128*96))/(128*128*96);
            end
        else
            index2(ind,1)=mod(index_r_edge2(ind),128);
            index2(ind,2)=1+(mod(index_r_edge2(ind),128*128)-index2(ind,1))/128;
            index2(ind,3)=1+(mod(index_r_edge2(ind),128*128*96)-mod(index_r_edge2(ind),128*128))/(128*128);
            index2(ind,4)=1+(index_r_edge2(ind)-mod(index_r_edge2(ind),128*128*96))/(128*128*96);
        end
    end
end

end