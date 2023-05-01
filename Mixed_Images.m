
clear all 
clc 
%IMAGEN 1
imagen1 = imread('Tesela.jpeg');%Matriz de tres dimensiones
%imshow(imagen1) %Mostrar imagenes
%[fil1, col1] = size(imagen1);%Tamaño de las imagenes
%valor =  imresize(imagen1,0.5);%Cambiar tamño de la imagen 
%B = imrotate(imagen1,30);
imagen11 = double(rgb2gray(imagen1));%Quita colores 
[tx1 ty1] = size(imagen11);
u1 = reshape(imagen11,1,tx1*ty1);%Convierte en un vector 
%-----------------------------------------------------------------------------
%IMAGEN 2
imagen2 = imread('Lena.jpeg'); %Matriz de tres dimensiones
%[fil2, col2, ban] = size(imagen2);%Tamaño de las imagenes
%imshow(imagen2)
imagen22 = double(rgb2gray(imagen2));
[tx2 ty2] = size(imagen22); %Tamaño de la matriz
u2 = reshape(imagen22,1,tx2*ty2);%Convierte en un vector 
%----------------------------------------------------------------------------
%MOSTRAR IMAGENES ORGINALES
%imagesc() muestras las imagenes en una escala de colores 
figure;
subplot(1,2,1); imshow(rgb2gray(imagen1));axis square; 
colormap bone;
subplot(1,2,2); imshow(rgb2gray(imagen2));axis square;  
colormap bone;
%----------------------------------------------------------------------------
%Fuentes y mezclado 
s = [u1 ;u2];
A = [300,350;700,900];
x =  A*s;%Señales mezcladas 
%---------------------------------------------------------------------------
%Imgagenes mezcladas
%imagesc() muestras las imagenes en una escala de colores 
x1Imagen = reshape(x(1,:),tx1,ty1); %Convierte la mezcla 1 en una matriz 
x2Imagen = reshape(x(2,:),tx2,ty2);%Convierte la mezcla 2 en una matriz
figure;
subplot(1,2,1); imagesc(x1Imagen);axis square; 
colormap bone; 
subplot(1,2,2); imagesc(x2Imagen);axis square;
colormap bone; 
%Hay diferente tipo de colores predefinidos
%----------------------------------------------------------------------------
%GRAFICO DE DISPERSION DE LAS MEZCLAS
x1 = x(1,:);
x2 = x(2,:);
figure;
scatter(x1,x2,'.')
title('Scatter diagram of mix data')
%--------------------------------------------------------------------------
%Datos centrados
figure;
[fx cx] = size(x)
xb = mean(x')%media de los datos
xcen = x'-ones(cx,1)*xb; %datos centrados
scatter(xcen(:,1),xcen(:,2),'.')%Diagrama de dispersion de los datos centrados
title('Scatter diagram of centered data')
x1Centrado = reshape(xcen(:,1),tx1,ty1);
x2Centrado = reshape(xcen(:,1),tx2,ty2);
%-------------------------------------------------------------------------
%Imagen centrada y mezclada
figure;
subplot(1,2,1); imagesc(x1Centrado); title('Centered Mix 1');axis square; 
subplot(1,2,2); imagesc(x2Centrado); title('Centered Mix 2');axis square;
colormap gray 
%-------------------------------------------------------------------------
% Blanquamiento de los datos 
covx = cov(xcen);
[C D] = eig(covx);
xblan = D^-0.5*C'*x;
x1blan = xblan(1,:);
x2blan = xblan(2,:);
figure 
scatter(x1blan,x2blan,'.')
title('Scatter diagram of whitening data')
cov(xblan')
%--------------------------------------------------------------------------
%Imagen mezclada y blanqueda 
x1Blanqueda = reshape(xblan(1,:),tx1,ty1);
x2Blanqueda = reshape(xblan(2,:),tx2,ty2);
figure;
subplot(1,2,1); imagesc(x1Blanqueda); title('Whitening Mix 1');axis square; 
subplot(1,2,2); imagesc(x2Blanqueda); title('Whitening Mix 2');axis square;
colormap gray
%-------------------------------------------------------------------------
%Datos aplicando PCA 
ianv = pca(x);

