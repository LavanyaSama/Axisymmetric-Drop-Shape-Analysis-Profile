function [theoretical_Xleft,theoretical_Xright,theoretical_Yleft,theoretical_Yright,P] = odesolve(b,s)
cc=[0.1363]; % array for c values
sSpan=[0:0.01:10]; % arclength data for solving ODE
Y0=[0,0.01,0];    % initial values defined for solving ODE
options=[];
for l=1:length(cc)
  c=cc(l);
[S,Y]= ode45(@laplaceyoung,sSpan,Y0,options,b,c); % ode solving to obtain theoretical data
 Z0=Y(:,3); % z data which is in third column
j=1;
while j<length(Z0)
 if Z0(j)<Z0(j+1)
     j=j+1;
 else
     break;
end
end

% Storing solution obtained by solving ODE (Y data)in X,Z and P (P refers to contact angle)
 X(1:j,1)=Y(1:j,2); 
 Z(1:j,1)=Y(1:j,3);
 P(1:j,1)=Y(1:j,1);
 S(1:j,1)=S(1:j,1);
 
 X_1left=[-X(1:j,1)]; 
 X_1right=[X(1:j,1)];
 Z_1left=[Z(1:j,1)];
 Z_1right=[Z(1:j,1)];

 
 % loop for converting data into pixels by scale factor s
  for m=1:length(X_1left)
        theoretical_Xleft(m)=X_1left(m)*s;
        theoretical_Xright(m)=X_1right(m)*s;
        theoretical_Yleft(m)=Z_1left(m)*s;
        theoretical_Yright(m)=Z_1right(m)*s;
  end
end 
    
    
    
 
        
        
    
        
   
 