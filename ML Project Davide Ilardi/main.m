function main(Ntr,nPhoto)  
    % Ntr is the number of elements in the DataSet
    % nPhoto is the number of photos we want to process
    load('SE.mat');
    load('FE.mat');
    % SE and FE are the starting and final eigenvalues of every block we 
    % are going to divide our 200x80 subimages
    
    %% Collecting data from the Training Set
    s1 = '..\ML Project Davide Ilardi\DataSet\';
    r = 179;
    % r is the number of plates' labels in the DataSet
    CollectData(Ntr,SE,FE,r,s1);
    load('X.mat');
    load('Y.mat');
    Xtr = X;
    Ytr = Y;
    %% Collecting photo to be analized 
    for n = 1:nPhoto
        s1 = '..\ML Project Davide Ilardi\PhotoToBeProcessed\';
        s2 = 'photo';
        color = -1;
        IMM = CollectPhoto(s1,s2,n,color);
        %% Convolve photo and save the 200x80 images obtained in "Convolution" folder
        % dx and dy are the number of pixels we are going to overlap during
        % the convolution
        % sx and sy are the images' size
        sx = 200;
        sy = 80;
        dx = 160;
        dy = 60;
        [blocks,dim1,dim2] = Convolution(IMM,sx,sy,dx,dy);
        [q,t,o,p] = size(blocks);

        cd '..\ML Project Davide Ilardi\Convolution\';
        h = waitbar(0,'Writing images in "Convolution" folder...');
        steps = o*p;
        step = 1;
        N = 1;
        for j = 1:o
            for k = 1:p
                s2 = 'imm'; 
                s3 = num2str(N);
                s4 = '.jpg';
                str = strcat(s2,s3,s4);
                imwrite(blocks(:,:,j,k),str);
                N = N+1;
                
                step = step+1;
                waitbar(step / steps)
            end
        end
        
        close(h)
        %% Collecting images from "Convolution" folder
        cd ..\;
        s1 = '..\ML Project Davide Ilardi\Convolution\';
        r = NaN;
        CollectData(N-1,SE,FE,r,s1);
        load('X.mat');
        %% Classification based on Kernel Regularized Least Squares
        load('sigmaKRLS.mat');
        load('lambdaKRLS');
        c = regularizedKernLSTrain(Xtr, Ytr, 'gaussian', s, l);

        Y = regularizedKernLSTest(c, Xtr, 'gaussian', s, X);

        save('Y.mat','Y');

        k = find(Y>0);
        q = size(k,1);
        
        s1 = '..\ML Project Davide Ilardi\Convolution\';
        s2 = 'imm';
        s4 = '.jpg';  
        color = -1;
        for i = 1:q            
            IMM = CollectPhoto(s1,s2,k(i),color);
            str = strcat(s2,num2str(k(i)),s4);
            cd '..\ML Project Davide Ilardi\PlatesIdentified\';
            imwrite(IMM,str);
            cd ..\;
        end

        %% Display plates' recognition inside the photo
        s1 = '..\ML Project Davide Ilardi\PhotoToBeProcessed\';
        s2 = 'photo';
        color = 1;
        IMM = CollectPhoto(s1,s2,n,color);
        subplot(2,3,n)
        imshow(IMM);
        for i = 1:q
            row = floor(k(i)/dim1);
            column = k(i) - dim1*row;
            pos = [(column-1)*(sx-dx) (row)*(sy-dy) sx sy];
            rectangle('Position',pos,'EdgeColor','r');
        end
    end
end
