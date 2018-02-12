s1 = '..\ML Project Davide Ilardi\OtherElements\';
s2 = 'imm'; 
s4 = '.jpg';
l = 180;
N = 14;
%     pixelX is the x dimension of the image we are going to process
%     pixelY is the y dimension of the image we are going to process
%     sx is the x dimension desired for each block 
%     sy is the y dimension desired for each block 
h = waitbar(0,'Please wait...');
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

    blocks = splitImm(IMM,200,80);

    [m,n,o,p] = size(blocks);


    for j = 1:o
        for k = 1:p
            s3 = num2str(l);
            str = strcat(s2,s3,s4);
            imwrite(blocks(:,:,j,k),str);
            l = l+1;
        end
    end
    
    step = step+1;
    waitbar(step / steps)
end

close(h)
clear