
% function for solving ODE
function dy = laplaceyoung(s,y,b,c)
p=y(1); 
x=y(2);
z=y(3);
dy(1,1)=(2/b)+(c*z)-(sin(p)/x);
dy(2,1)=cos(p);
dy(3,1)=sin(p);



