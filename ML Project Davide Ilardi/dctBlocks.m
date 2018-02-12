function blocksResult = dctBlocks(blocks)
    
    [m,n,o,p] = size(blocks);
    blocksResult = zeros(m,n,o,p);
    for i=1:o
        for j=1:p
            blocksResult(:,:,i,j)= dct2(blocks(:,:,i,j));
        end
    end
end