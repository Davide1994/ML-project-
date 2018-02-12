function w = regularizedLSTrain(Xtr, Ytr, lambda)
	n = size(Xtr,1);
    d = size(Xtr,2);
    I = eye(d);
    %temp = (Xtr*Xtr' + lambda*I)\1;
    w = (Xtr'*Xtr + lambda*I)\Xtr'*Ytr;
    % complete here, check the backslash command
end