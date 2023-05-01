image1 = imread('Tesela.jpeg');
image11 = double(rgb2gray(image1));
[tx1 ty1] = size(image11);
signal1 = reshape(image11,1,tx1*ty1);

image2 = imread('Lena.jpeg');
image22 = double(rgb2gray(image2));
[tx1 ty1] = size(image22);
signal2 = reshape(image22,1,tx1*ty1);

s = [signal1 ;signal2];
%A =rand(2);
A = [0.0669,0.0182;0.9394,0.6838]
% A = [1,2;1,-1]
x =  A*s;
v = centered_data(x);
[ica mixed unmixed] = ica1(x);
x1Imagen = reshape(ica(1,:),tx1,ty1); %Convierte la mezcla 1 en una matriz 
x2Imagen = reshape(ica(2,:),tx1,ty1);%Convierte la mezcla 2 en una matriz
subplot(1,2,1); imagesc(x1Imagen);axis square; 
colormap bone; %Hay diferente tipo de colores predefinidos
subplot(1,2,2); imagesc(x2Imagen); axis square; 
colormap bone; %Hay diferente tipo de colores predefinidos



function [A] = centered_data(signal)
[n p] = size(signal);
mean_signal = mean(signal');
% B = (eye(n) - 1/n * ones(n))*signal;
% A = B';
A = signal' - ones(p,1)*mean_signal;
[n m] = size(A)
end 

function [ica,A,W] = ica1(signal)
centered_signal = centered_data(signal);
covariance = cov(centered_signal);
[C,D] = eig(covariance); %C vectors and D values
data_whitening = D^-0.5*C';
data_nonwhitening = C*D^0.5;
X = data_whitening*centered_signal';
[rows columns] = size(X);
aux = zeros(rows);
for i=1:rows
    w = randn(rows,1) %generates arrays of random numbers z(0,1)
    w = w - aux*aux'*w;
    w = w/norm(w);
    w2 = ones(rows,1);
    k = 0;
    while k<10
        w2 = w;
%        w = (X*((X'*w).^3))/columns -3*w;
         w = mean(X * tanh(X' * w),2) - mean(X*(sech(X')).^2*w);
        w = w/norm(w);
        B(:,i) = w;
        A(:,i) = data_nonwhitening*w;
        W(i,:) = w'*data_whitening;
        k = k+1;
    end 
end 
ica = W*signal;
end 




