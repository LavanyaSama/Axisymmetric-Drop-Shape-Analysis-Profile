function [ly_Xleft,ly_Xright,ly_Yleft,ly_Yright] = sample1(b,s)
c=0.1363;
sSpan=[0:0.01:10];
Y0=[0,0.01,0];
options=[];
[S,Y]= ode45(@laplaceyoung,sSpan,Y0,options,b,c);
 Z0=Y(:,3);
j=1;
while j<length(Z0)
 if Z0(j)<Z0(j+1)
     j=j+1;
 else
     break;
end
end
 X(1:j,1)=Y(1:j,2); 
 Z(1:j,1)=Y(1:j,3);
 P(1:j,1)=Y(1:j,1);
 S(1:j,1)=S(1:j,1);
 X_1left=[-X(1:j,1)];
 X_1right=[X(1:j,1)];
 Z_1left=[Z(1:j,1)];
 Z_1right=[Z(1:j,1)];
  for m=1:length(X_1left)
        ly_Xleft(m)=X_1left(m)*s;
        ly_Xright(m)=X_1right(m)*s;
        ly_Yleft(m)=Z_1left(m)*s;
        ly_Yright(m)=Z_1right(m)*s;
    end
    
    
    
 
        
        
    
        
   
 