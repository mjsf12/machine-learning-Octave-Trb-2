clear all;
clc;
%% Carregar os dados
L = load("alunos.txt"); 
X = L(:,1);
m=mean(X);
X_m = X.-m;
X_m_s = X_m./std(X);
X=X_m_s;
%X = (X.­-m)./std(X);
X1 = L(:,2);
m=mean(X1);
X_m = X.-m;
X_m_s = X_m./std(X1);
X1=X_m_s;
%X1 = (X1.-­mean(X1))./std(X1)
Y = L(:,3);
Apr = 0.1;
th = [0 ;0;0]; %% W inicial
A = [X X1 X.^0]; %% A 
E0 =0;
out = 0;
%% Loop da interação
for i = 1:10000
  Y_S=A*th;
  Y_S=1./((e.^(Y_S.*-1)).+1);
  Y_out = Y_S - Y;
  C_som = sum(Y_out);
  B_som = sum(Y_out.*X1);
  A_som = sum(Y_out.*X);
  NA = [A_som  B_som  C_som];
  NA = NA./length(Y);
  NA = NA*Apr;
  th = th - NA';
endfor
%ver no console
O = [Y Y_S];
th;
e =  Y - Y_S;
E = sum(e.^2)/length(X) ;
X11=X1;%fix feio
% Mostrar o Grafico 3d
X1 = linspace(-2,2);
Y1 = linspace(-4,2);
[ XX, YY ] = meshgrid(X1,Y1);
Z_plano = th(3) + th(2).*YY +th(1).*XX;
%Z_plano=1./((e.^(Z_plano.*-1)).+1) ;
figure;
hold on;
mesh(XX,YY,Z_plano);
hold on;
plot3(X,X11,Y,'o');
