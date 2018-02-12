function [blocks,dim1,dim2] = Convolution(image,sx,sy,dx,dy)
    
    [m,n] = size(image);
    dim1 = 1 + floor(((n-sx)/(sx-dx)));
    dim2 = 1 + floor(((m-sy)/(sy-dy)));
    blocks = uint8(zeros(sy,sx,dim2,dim1));
    
    h = waitbar(0,'Convolution');
    steps = dim1*dim2;
    step = 1;

    for i=1:dim2
        for j=1:dim1
            for k=(i*sy-(sy-1)-(i-1)*dy):(i*sy-(i-1)*dy)
                for w=(j*sx-(sx-1)-(j-1)*dx):(j*sx-(j-1)*dx)
                     blocks((sy+k-i*sy+(i-1)*dy),(sx+w-j*sx+(j-1)*dx),i,j)=image(k,w);
                end
            end
            
            step = step+1;
            waitbar(step / steps)
        end
    end
    
    close(h)
end  