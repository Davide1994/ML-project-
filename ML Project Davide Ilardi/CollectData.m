function CollectData(N,SE,FE,r,s1)
    %     pixelX is the x dimension of the image we are going to process
    %     pixelY is the y dimension of the image we are going to process
    %     sx is the x dimension desired for each block 
    %     sy is the y dimension desired for each block 
    %     SE is the starting eigenvalue
    %     FE is the final eigenvalue
    %     r is the number of plates' labels in the DataSet
    %     s1 is the string containing the URL to the data we have to collect
    s2 = 'imm'; 
    s4 = '.jpg';
    sx = 8;
    sy = 8;
    pixelX = 200;
    pixelY = 80;
    nBlocks = (pixelX/sx)*(pixelY/sy);

    nEigenvalues = FE - SE + 1;
    X = zeros(N,(nBlocks*nEigenvalues));

    h = waitbar(0,'Collecting Data...');
    steps = N;
    step = 1;

    for i = 1:N 
        s3 = num2str(i);
        str = strcat(s1,s2,s3,s4);
        RGB = imread(str); 

        [x,y,z] = size(RGB);                                        
        if(z==3)
            IMM = rgb2gray(RGB);  
        else
            IMM = RGB;
        end

        blocks = splitImm(IMM,sx,sy);
        DCTblocks = dctBlocks(blocks);

        [m,n,o,p] = size(blocks);
        m = 1;
        for l = 1:o
            for j = 1:p
                temp = sort(real(eig(DCTblocks(:,:,l,j))),'descend');
                X(i,m:m+(nEigenvalues-1)) = temp(SE:FE);
                m = m+nEigenvalues;
            end
        end
       
        step = step+1;
        waitbar(step / steps)
    end
    
    close(h)
    
    save('X.mat','X');
    
    if(~isnan(r))
        for i = 1:N
            if(i<=r)
                Y(i,1) = 1;
            else
                Y(i,1) = -1;
            end
        end
        
        save('Y.mat','Y');
    end    
end