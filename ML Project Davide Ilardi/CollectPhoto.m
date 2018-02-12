function IMM = CollectPhoto(s1,s2,n,color)
    % n is the numerical identifier of the photo
    % s1 is the string containing the URL to the photo we want to collect
    % s2 is the alphabetical identifier of the photo
    % color is the variable whose values can be 1 or -1 and specifies if we
    % want to process a coloured image or a grayscale one
    s4 = '.jpg';
    s3 = num2str(n);
    str = strcat(s1,s2,s3,s4);
    RGB = imread(str); 

    [x,y,z] = size(RGB);    
    
    if(color == -1)
        if(z==3)
            IMM = rgb2gray(RGB);  
        else
            IMM = RGB;
        end
    else
        IMM = RGB;
    end
end