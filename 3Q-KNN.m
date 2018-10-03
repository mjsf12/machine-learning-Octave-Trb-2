clear all;
clear;
clc;
pkg load statistics; %% carregar bibliotecas nessesarias
k=3;  %% k  do knn
n=15; % tamanho dos testes
base  = load('base_artificial.txt');
%% Separando em duas partes pelo Y
[i j] = find(base(:,3) == 0);
RC1 =base(i,:);
[i j] = find(base(:,3) == 1);
RC2 =base(i,:);
%% Pegando 15 Alearoios de cada um para teset
idx1=randsample(1:size(RC1,1),n) ;
idx2=randsample(1:size(RC2,1),n) ;
T1 = RC1(idx1,:);
T2 = RC2(idx2,:);
%% Removendo do original os que foram tirado para teste
RC1(idx1,:)=[];
RC2(idx2,:)=[];
%% montando nova base e teste
nbase = [RC1;RC2];
treino = [T1;T2];
%% Separando x1 e x2
x1 = nbase(:,1);
x2 = nbase(:,2);
y  = nbase(:,3);
%% Criar matriz de confusão
conf = zeros(2)
%% loop das linhas dos teste
for x = 1:rows(treino)
  row=treino(x,:); %%pegar linha
  X1 =  ones(50,1)*row(:,1);%%Montando x1 para fazer a distancia
  X2 =  ones(50,1)*row(:,2);%%Montando x2 para fazer a distancia
  Yd = row(:,3); %% salvando Y
  dis_Y = sqrt((X1-x1).^2+(X2-x2).^2);%% Todas as distancias
  Y_prox = sortrows([dis_Y y])(1:k,2); %ordenando
  [V Y_] = max(histc(Y_prox,0:1));% pegando o histograma e pegando o mais  usado
  conf(Yd+1,Y_) = conf(Yd+1,Y_)+1;  %montando a matrix de confusão
endfor
quant = conf(1,1)+conf(2,2);%%  pegando os que deram certo
error = conf(1,2)+conf(2,1); %% os erros
porc = (quant/(quant + error))*100 %% porcentagem
rate = [porc quant]; %% montando o  array
conf %% printando
rate%% printando

