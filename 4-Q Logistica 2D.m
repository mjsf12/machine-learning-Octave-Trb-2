clear all;
clc;
%% Carregar os dados
L = load("alunos.txt"); 
X = L(:,1);
m=mean(X);
X_m = X.-m;
X_m_s = X_m./std(X);
X=X_m_s;
Y = L(:,3);
Apr = 0.1;
th = [0 ;0]; %% W inicial
A = [X  X.^0]; %% A 
E0 =0
out = 0
%% Loop da interação
for i = 1:200
  Y_S=A*th;
  Y_S=1./((e.^(Y_S.*-1)).+1) 
  Y_out = Y_S - Y;
  C_som = sum(Y_out);
  A_som = sum(Y_out.*X);
  NA = [A_som  C_som];
  NA = NA./length(Y);
  NA = NA*Apr;
  th = th - NA';
endfor
%ver no console
th
O = [Y Y_S];
e =  Y - Y_S;
saida = [Y Y_S];
E = sum(e.^2)/length(X) 
% Mostrar o Grafico 3d
X11 = linspace(-2,2);
y = th(2) +th(1).*X11;
y_=1./((e.^(y.*-1)).+1)

plot(X11,y,'r'); hold on;
plot(X,Y,'o')
