clear all 
[z1,F1s] = audioread('audio1.wav');
y1 = z1(1:300000,1);
sound(y1,F1s);
% figure()
% plot(y1,'b')
[z2,F2s] = audioread('audio2.wav');
y2 = z2(1:300000,1);
% figure()
% plot(y2,'g')
% sound(y2,F2s);
[z3,F3s] = audioread('audio3.wav');
y3 = z3(1:300000,1);
% figure()
% plot(y3,'r')
% sound(y3,F3s);
s1 = [y1';y2';y3'];
A = [1,-1,1;0,1,1;-1,-1,1];
x =  A*s1;





[ica mixed unmixed] = ica1(x);
sound(ica(1,:),F1s)
figure ()
subplot(3,1,1)
plot(x(1,:),'b')
title('First mixed signal')
subplot(3,1,2)
plot(x(2,:),'g')
title('Second mixed signal')
subplot(3,1,3)
plot(x(3,:),'r')
title ('third mixed signal')
figure()
subplot(3,1,1)
plot(ica(1,:),'b')
title('First original signal')
subplot(3,1,2)
plot(ica(2,:),'g')
title('Second original signal')
subplot(3,1,3)
plot(ica(3,:),'r')
title('Third original signal')
sound(ica(1,:),F1s)


% 
% 
% 
% 
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
       w = (X*((X'*w).^3))/columns -3*w;
%         w = mean(X * tanh(X' * w),2) - mean(X*(sech(X')).^2*w);
        w = w/norm(w);
        B(:,i) = w;
        A(:,i) = data_nonwhitening*w;
        W(i,:) = w'*data_whitening;
        k = k+1;
    end 
end 
ica = W*signal;
end 
