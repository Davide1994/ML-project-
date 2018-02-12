s1 = '..\ML Project Davide Ilardi\OtherElements\';
s4 = '.jpg';
l = 180;
%     pixelX is the x dimension of the image we are going to process
%     pixelY is the y dimension of the image we are going to process
%     sx is the x dimension desired for each block 
%     sy is the y dimension desired for each block 

for i = 1:18
    s2 = 'imm'; 
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

    cd '..\ML Project Davide Ilardi\DataSet\';
    for j = 1:o
        for k = 1:p
            s2 = 'imm';
            s3 = num2str(l);
            str = strcat(s2,s3,s4);
            imwrite(blocks(:,:,j,k),str);
            l = l+1;
        end
    end
    cd '..\ML Project Davide Ilardi\OtherElements\';
end