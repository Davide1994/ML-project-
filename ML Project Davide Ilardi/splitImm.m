function blocks = splitImm(image,sx,sy)
    
    [m,n] = size(image);
    dim1 = floor(m/sy);
    dim2 = floor(n/sx);
    blocks = uint8(zeros(sy,sx,dim1,dim2));
    
    for i=1:dim1
        for j=1:dim2
            for k=(i*sy-(sy-1)):(i*sy)
                for w=(j*sx-(sx-1)):(j*sx)
                     blocks((sy+k-i*sy),(sx+w-j*sx),i,j)=image(k,w);
                end
            end
        end
    end
end  

