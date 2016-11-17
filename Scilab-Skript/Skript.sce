//This script only works from a maximum range of -300 to +300 for beta
//If you want it to work for every range, you have to add a counter, which 
//counts how often the motor rotated completely, to modify the if..then..else 
//parts...

//Constant
d = 105e-3;
h = 19e-3;
a2 = 118.72e-3;
a1 = 18e-3;
b2 = 36.22e-3;
hk = 17e-3;
lk = 117.5e-3;

//set range of beta
//range starts at -beta_range and ends at beta_range
beta_range = 300; 
beta = -beta_range*%pi/180:%pi/100:beta_range*%pi/180;

//calculate constant angles and values
b1 = sqrt(d^2+h^2);
gamma = atan(h/d);
delta = atan(hk/lk);

//(ceil uses upper gauß bracket)
//initialize alpha matrix with zeros
alpha = [zeros(1,ceil(2*(beta_range*%pi/180)/(%pi/100)))];

//loop to calculate alpha
for i = 1:ceil(2*(beta_range*%pi/180)/(%pi/100))
    if(beta(1,i)<(-gamma))    
        if(beta(1,i) < (-gamma-%pi))
            gamma1 = %pi-gamma-beta;
            c1 = sqrt(a1^2+b1^2-2*a1*b1*cos(gamma1));
            alpha1 = acos((c1(1,i)^2+b1^2-a1^2) / (2*c1(1,i)*b1));
        else
            gamma1 = %pi+gamma+beta;
            c1 = sqrt(a1^2+b1^2-2*a1*b1*cos(gamma1));
            alpha1 = -acos((c1(1,i)^2+b1^2-a1^2)/(2*c1(1,i)*b1));
        end
    else
        if(beta(1,i) < (-gamma+%pi))
            gamma1 = %pi-gamma-beta;
            c1 = sqrt(a1^2+b1^2-2*a1*b1*cos(gamma1));
            alpha1 = acos((c1(1,i)^2+b1^2-a1^2)/(2*c1(1,i)*b1));
        else
            gamma1 = %pi+gamma+beta;
            c1 = sqrt(a1^2+b1^2-2*a1*b1*cos(gamma1));
            alpha1 = -acos((c1(1,i)^2+b1^2-a1^2)/(2*c1(1,i)*b1));
        end
    end
    beta2 = acos((a2^2+c1(1,i)^2-b2^2)/(2*a2*c1(1,i)));
    alpha(1,i) = alpha1+beta2-delta-gamma;
end 


//calculate beta and alpha in degrees for the plot
alpha = alpha*180/%pi;
beta = beta*180/%pi;

//plot the result
plot(beta, alpha);
plot(beta,a1/a2*beta,"r:");

//label the plot and show grid
xlabel("$\beta$");
ylabel("$\alpha$");
xgrid();
