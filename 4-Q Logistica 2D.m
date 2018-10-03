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
Xline = linspace(1,200,200);
Yline = zeros(1,200);
for i = 1:200
  Y_S=A*th;
  Y_S=1./((e.^(Y_S.*-1)).+1); 
  Y_out = Y_S - Y;
  C_som = sum(Y_out);
  A_som = sum(Y_out.*X);
  NA = [A_som  C_som];
  NA = NA./length(Y);
  NA = NA*Apr;
  th = th - NA';
  error =  Y - Y_S;
  E = sum(error.^2)/length(X);
  Yline(i)=E;
endfor
%ver no console
O = [Y Y_S];
th;
e =  Y - Y_S;
E = sum(e.^2)/length(X) ;
conf = zeros(2);
for x = 1:rows(O)
   row=O(x,:); %%pegar linha
  if(row(:,2) >= 0.5)
    conf(row(:,1)+1,2) = conf(row(:,1)+1,2)+1;  %montando a matrix de confusão
  else
    conf(row(:,1)+1,1) = conf(row(:,1)+1,1)+1;  %montando a matrix de confusão
  endif
endfor
quant = conf(1,1)+conf(2,2);%%  pegando os que deram certo
error = conf(1,2)+conf(2,1); %% os erros
porc = (quant/(quant + error))*100; %% porcentagem
rate = [porc quant]; %% montando o  array
rate
conf
plot(Xline,Yline)
