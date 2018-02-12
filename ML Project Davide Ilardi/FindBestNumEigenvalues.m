function FindBestNumEigenvalues(N,Ntr,Nts,r)  
    pixelX = 200;
    pixelY = 80;
    sizeBlock = 8;
    nBlocks = (pixelX/sizeBlock)*(pixelY/sizeBlock);
    err = NaN(sizeBlock);
    n = 1;
    s1 = '..\ML Project Davide Ilardi\DataSet\';
    
    h = waitbar(0,'Classification based on different number of eigs...');
    steps = 720;
    step = 1;
    
    for a = 1:20
        CollectData(N,1,8,r,s1);
        load('X.mat');
        load('Y.mat');
        load('sigmaKRLS');
        load('lambdaKRLS');
        [XtrBig, Ytr, XtsBig, Yts] = randomSplitDataset(X, Y, Ntr, Nts);

        if(Ntr >= Nts)
            for b = 1:sizeBlock
                for k = b:sizeBlock
                    for i = 1:Ntr
                        for m = 0:nBlocks-1
                            Xtr(i,n:n+k-b) = XtrBig(i,(b+sizeBlock*m):(k+sizeBlock*m));
                            if(Nts >= i)
                                Xts(i,n:n+k-b) = XtsBig(i,(b+sizeBlock*m):(k+sizeBlock*m));
                            end
                            n = n+k-b+1;
                        end
                        n = 1;
                    end

                    c = regularizedKernLSTrain(Xtr, Ytr, 'gaussian', s, l);
                    Ypred = regularizedKernLSTest(c, Xtr, 'gaussian', s, Xts);
                    err(k,b) = mean(sign(Ypred)~=sign(Yts));
                    
                    step = step+1;
                    waitbar(step / steps)
                end
            end
        end

        if(Ntr < Nts)
            for b = 1:sizeBlock
                for k = b:sizeBlock
                    for i = 1:Nts
                        for m = 0:nBlocks-1
                            Xts(i,n:n+k-b) = XtsBig(i,(b+sizeBlock*m):(k+sizeBlock*m));
                            if(Ntr >= i)
                                Xtr(i,n:n+k-b) = XtrBig(i,(b+sizeBlock*m):(k+sizeBlock*m));
                            end
                            n = n+k-b+1;
                        end
                        n = 1;
                    end

                    c = regularizedKernLSTrain(Xtr, Ytr, 'gaussian', s, l);
                    Ypred = regularizedKernLSTest(c, Xtr, 'gaussian', s, Xts);
                    err(k,b) = mean(sign(Ypred)~=sign(Yts));
                    
                    step = step+1;
                    waitbar(step / steps)
                end
            end
        end                    

        [A,B] = min(err);
        [C,D] = min(A);
        Starter(a) = D;                           %starter eigenvalue
        Final(a) = B(D);                          %final eigenvalue
    end
    close(h)
    
    j = 1;
    for i = 1:8
        [x,m(1,j)] = size(find(Starter == i));
        j = j+1;
    end
    i = 1:8;
    SEtemp = i(find(m == max(m)));
    if(size(SEtemp,2) > 1)
        SE = SEtemp(1);       
    else
        SE = SEtemp;
    end
    
    l = find(Starter == SE);
    j = 1;
    for k = 1:size(l,2)
        [x,m(1,j)] = size(find(Final(l) == Final(l(k))));
        j = j+1;
    end  
    FEtemp = l(find(m == max(m)));
    if(size(FEtemp,2) > 1)
        FE = Final(FEtemp(1));       
    else
        FE = Final(FEtemp);
    end
    
    save('SE.mat','SE');
    save('FE.mat','FE');
end