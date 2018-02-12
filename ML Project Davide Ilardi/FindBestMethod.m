function FindBestMethod(Ntr,Nts,r)
    N = Ntr+Nts;
    s1 = '..\ML Project Davide Ilardi\DataSet\';
    load('SE.mat');
    load('FE.mat');
    CollectData(N,SE,FE,r,s1);

    err = zeros(2,20);
    
    h = waitbar(0,'Please wait...');
    steps = 20;
    step = 1;
    for t = 1:20
        load('X.mat');
        load('Y.mat');
        [Xtr, Ytr, Xts, Yts] = randomSplitDataset(X, Y, Ntr, Nts);        
        
        %% Regularized Linear Least Squares
        [l, s, Vm, Vs, Tm, Ts] = holdoutCV('rls', Xtr, Ytr,[], 0.5, 5, logspace(0,-3,12), []);
        w = regularizedLSTrain(Xtr, Ytr, l);
        Y1 = regularizedLSTest(w, Xts);
        err(1,t) = mean(sign(Y1)~=sign(Yts));
        lBestRLS(1,t) = l;
        %% Regularized Kernel Linear Least Squares
        [l, s, Vm, Vs, Tm, Ts] = holdoutCV('krls', Xtr, Ytr,'gaussian', 0.5, 5, logspace(0,-5,12), 4000:500:7000);
        c = regularizedKernLSTrain(Xtr, Ytr, 'gaussian', s, l);
        Y2 = regularizedKernLSTest(c, Xtr, 'gaussian', s, Xts);
        err(2,t) = mean(sign(Y2)~=sign(Yts));
        lBestKRLS(1,t) = l;
        sBestKRLS(1,t) = s;
        %%
        step = step+1;
        waitbar(step / steps)
    end
    
    save('ErrorRLS-KRLS','err');
    
    %% Calculating the best value for lambda using Regularized Least Squares
    j = 1;
    for i = logspace(0,-3,12)
        [x,o(1,j)] = size(find(lBestRLS == i));
        j = j+1;
    end
    i = logspace(0,-3,12);
    lambdaBest = i(find(o == max(o)));
    if(size(lambdaBest,2) > 1)
        l = lambdaBest(1);       
    else
        l = lambdaBest;
    end
    save('lambdaRLS','l');
    
    %% Calculating the best value for sigma using Kernel Regularized Least Squares
    j = 1;
    for i = 4000:500:7000
        [x,n(1,j)] = size(find(sBestKRLS == i));
        j = j+1;
    end
    sigmaBest = 3500+500*find(n == max(n));
    if(size(sigmaBest,2) > 1)
        s = sigmaBest(1);
    else
        s = sigmaBest;
    end
    save('sigmaKRLS','s');
    
    %% Calculating the best value for lambda using Kernel Regularized Least Squares
    j = 1;
    for i = logspace(0,-5,12)
        [x,m(1,j)] = size(find(lBestKRLS == i));
        j = j+1;
    end
    i = logspace(0,-5,12);
    lambdaBest = i(find(m == max(m)));
    if(size(lambdaBest,2) > 1)
        l = lambdaBest(1);       
    else
        l = lambdaBest;
    end
    save('lambdaKRLS','l');
    
    close(h) 
end