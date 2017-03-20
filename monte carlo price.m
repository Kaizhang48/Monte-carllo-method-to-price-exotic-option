T=63/252;
r=0.03;
S0=100;
step=63;% 1000
k=300000;
dt=0.25/step;
sigma=[0.2;0.25;0.3];
result=[0:0.1:0.9,0.99];
op=[];
op2=[];
drift=(r-1/2.*power(sigma,2)).*dt;
rand=sigma.*power(dt,1/2);
for rho=result
    ss1=0;
    ss2=0;
    R=ones(3,3).*rho+eye(3)-rho*eye(3);
    L=chol(R)';
    for j=1:k
        x= mvnrnd(zeros(1,3),eye(3),step)';
        ln_ret=cumsum(drift+rand.*(L*x),2);
        sp=S0*exp(ln_ret);
        ss1=max([max(max(sp))-110,0])+ss1;
        ss2=max([mean(sp(:,end))-110,0])+ss2;
    end
    op=[op,exp(-r*(1/4))*(ss1/k)];
    op2=[op2,exp(-r*(1/4))*(ss2/k)];
end
result=[result;op;op2];
hold on
plot(result(1,:),result(2,:),'.','markersize',20)
plot(result(1,:),result(3,:),'.','markersize',20)
title('HOMEWORK1 #1')
xlabel('rho')
ylabel('price')
legend('option in #1A','option in #1B')




   
    