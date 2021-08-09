% center of thedrop where contact area is present is to be mentioned
clear;
clc;
FPS=3;
pixellength=0.00266;  
pixelsinXdirectionStart=496;
pixelsinXdirectionEnd=1581;
pixelsinYdirectionEnd=1081;
%address = uigetdir;
%address='D:\9th May postprocessing\80';
for list=293
%  im1=imread([address '\image_' int2str(list),'.bmp']);
%  img_edge=edge(im1,'sobel');
%  [rows1 cols1]=find(img_edge);
 

    
BW1=imread(['C:\Users\sanyu\OneDrive\Desktop\MTP\TA\image_59','.bmp']);
BW1=imcomplement(BW1);

ypixel=1787;

 j=ypixel; % pixel where area of drop is there, can be read from the image by using max y pixel value
 x=0;
 for i=pixelsinXdirectionStart:pixelsinXdirectionEnd % max limit can be read by taking max x pixel value of BW1
     if BW1(j,i)==0
         x=x+1;
         radiuspixels(x)=i;
     end
 end
 center=(max(radiuspixels)+ min(radiuspixels))*0.5; %center pixel number
 radiusofdrop = max(radiuspixels)-center; %radius of drop in pixels
 
 C=round(center);
 y=0;
 j=ypixel; % area is present pixel
 for w=j:-1:pixelsinYdirectionEnd  %used to be 425
     if BW1(w,C)==0
         y=y+1;
         heightpixels(y)=w;
     end
 end
 heightofdrop = j-min(heightpixels); % height of drop in pixels

 count=0;
 j=ypixel;
 for u=(radiuspixels(1)+1):round(center)
    sss=0;
     for v=j:-1:pixelsinYdirectionEnd      
         if BW1(v,u)==0 
            sss=sss+1;
            sur1(sss)=v;
         end
    end
 if sss>=1
     count=count+1;
     surface_x1(count)=u;
     surface_y1(count)=min(sur1);
 end 
 clearvars sur1;
 end
 
  count1=count;
  inc1=0;
j=ypixel;
 for u=pixelsinXdirectionStart:(radiuspixels(1))
     ssss=0;
     for v=j:-1:pixelsinYdirectionEnd
    if BW1(v,u)==0
        ssss=ssss+1;
        surtest(ssss)=v;
    end
    end
    if ssss>=1
        count1=count1+1;
        surface_x1(count1)=u;
        surface_y1(count1)=min(surtest);
        inc1=inc1+1;
          sur_x1(inc1)= u;
          sur_y1(inc1)=min(surtest);
        if (max(surtest)~=min(surtest))
        count1=count1+1;
        surface_x1(count1)=u;
        surface_y1(count1)=max(surtest);
        inc1=inc1+1;
          sur_x1(inc1)= u;
          sur_y1(inc1)=max(surtest);
        end
    end
    clearvars surtest;
 end
clearvars sss count;

count=0;
j=ypixel;
 for u=round(center):(radiuspixels(length(radiuspixels))-1)
     sss=0;
     for v=j:-1:pixelsinYdirectionEnd 
    if BW1(v,u)==0
        sss=sss+1;
        sur2(sss)=v;
    end 
    end
     if sss>=1
     count=count+1;
        surface_x2(count)=u;
        surface_y2(count)=min(sur2);
     end
     clearvars sur2;
 end
 
 count3=length(surface_x2);
 inc=0;
j=ypixel;
 for u=(radiuspixels(end)):pixelsinXdirectionEnd
     ss=0;
     for v=j:-1:pixelsinYdirectionEnd 
    if BW1(v,u)==0
        ss=ss+1;
        surtest2(ss)=v;
    end    
    end
      if ss>=1
        count3=count3+1;
        surface_x2(count3)=u;
        surface_y2(count3)=min(surtest2);
        if (max(surtest2)~=min(surtest2))
        count3=count3+1;
        surface_x2(count3)=u;
        surface_y2(count3)=max(surtest2);
        inc=inc+1;
          sur_x2(inc)= u;
          sur_y2(inc)=max(surtest2);
        end
      end
    clearvars surtest2;
 end
 
 % sorting accordingly
 [Y1sorted, SortIndex] = sort(surface_y1,'descend');  
 X1sorted = surface_x1(SortIndex);
 surface_x1=X1sorted;
 surface_y1=Y1sorted;
  [Y2sorted, SortIndex] = sort(surface_y2,'ascend');   
 X2sorted = surface_x2(SortIndex);
 surface_x2=X2sorted;
 surface_y2=Y2sorted;
 
 drop_x=[surface_x1 surface_x2];
 drop_y=[surface_y1 surface_y2];
 
 apex=[min(heightpixels),C];
 shiftdrop_x=drop_x-apex(:,2);
shiftdrop_y=drop_y-apex(:,1);
surfacepixel=ypixel-apex(:,1);
shiftdropleft_x=surface_x1-apex(:,2);
shiftdropleft_y=surface_y1-apex(:,1);
shiftdropright_x=surface_x2-apex(:,2);
shiftdropright_y=surface_y2-apex(:,1);
s=260;
bb=[5];
iteration=1;
l=1;
l1=1;
Error1=2500;
for iter=1:length(bb)
 b=bb(iter);
 while Error1>0
[ly_Xleft,ly_Xright,ly_Yleft,ly_Yright,P]=sample1(b,s);
lyy_Xleft=round(ly_Xleft);
lyy_Xright=round(ly_Xright);
lyy_Yleft=round(ly_Yleft);
lyy_Yright=round(ly_Yright);
lyy_Xtotal=[lyy_Xleft,lyy_Xright];
lyy_Ytotal=[lyy_Yleft,lyy_Yright];
Phi=P*(180/pi);
loop=1;
for mm=1:length(shiftdropright_y);
    same_y=shiftdropright_y(mm);
    countl=1;
    for nn=1:length(shiftdropright_y)
        if(shiftdropright_y(nn)==same_y)
           arr(countl)=shiftdropright_x(nn);
           countl=countl+1;
           ab=mean(arr);
           cd=same_y;
        end
    end
  newshiftdropright_x(loop)=ab;
  newshiftdropright_y(loop)=cd;
  loop=loop+1;
arr=[];
end
loop1=1;
 for mm=1:length(shiftdropleft_y)
     same_y=shiftdropleft_y(mm);
     count2l=1;
     for nn=1:length(shiftdropleft_y)
         if(shiftdropleft_y(nn)==same_y)
             arr(count2l)=shiftdropleft_x(nn);
             count2l=count2l+1;
             ab=mean(arr);
             cd=same_y;
         end
     end
     newshiftdropleft_x(loop1)=ab;
     newshiftdropleft_y(loop1)=cd;
     loop1=loop1+1;
     arr=[];
   end
newshiftdroptotal_x=[ newshiftdropleft_x, newshiftdropright_x];
newshiftdroptotal_y=[ newshiftdropleft_y, newshiftdropright_y];
loop3=1;
for mm=1:length(lyy_Yleft);
    same_y=lyy_Yleft(mm);
    countl=1;
    for nn=1:length(lyy_Yleft)
        if(lyy_Yleft(nn)==same_y)
           arr(countl)=lyy_Xleft(nn);
           countl=countl+1;
           ab=mean(arr);
           cd=same_y;
        end
    end
  newlyy_Xleft(loop3)=ab;
  newlyy_Yleft(loop3)=cd;
  loop3=loop3+1;
arr=[];
end
loop4=1;
for mm=1:length(lyy_Yright)
    same_y=lyy_Yright(mm);
    countl=1;
    for nn=1:length(lyy_Yright)
        if(lyy_Yright(nn)==same_y)
           arr(countl)=lyy_Xright(nn);
           countl=countl+1;
           ab=mean(arr);
           cd=same_y;
        end
    end
  newlyy_Xright(loop4)=ab;
  newlyy_Yright(loop4)=cd;
  loop4=loop4+1;
arr=[];
end

loopcount=1;
for m=1:length(newshiftdropleft_y)-200
    search_y=newshiftdropleft_y(m);
    for n=1:length(newlyy_Yleft)
        if(newlyy_Yleft(n)==search_y)
            reqd_x=newlyy_Xleft(n);
            needed_x=newshiftdropleft_x(m);
            comp_drop_xleft(loopcount)=needed_x;
           comp_drop_yleft(loopcount)=search_y;
            comp_young_xleft(loopcount)=reqd_x;
           comp_young_yleft(loopcount)=search_y;
           loopcount=loopcount+1;
      end
    end
end
   
   loopcount1=1;
for m=200:length(newshiftdropright_y)
    search_y=newshiftdropright_y(m);
    for n=1:length(newlyy_Yright)
        if(newlyy_Yright(n)==search_y)
            reqd_x=newlyy_Xright(n);
            needed_x=newshiftdropright_x(m);
            comp_drop_xright(loopcount1)=needed_x;
           comp_drop_yright(loopcount1)=search_y;
            comp_young_xright(loopcount1)=reqd_x;
           comp_young_yright(loopcount1)=search_y;
           loopcount1=loopcount1+1;
        end
    end
end
comp_drop_x=[comp_drop_xleft,comp_drop_xright];
 comp_drop_y=[comp_drop_yleft,comp_drop_yright];
 comp_young_x=[comp_young_xleft,comp_young_xright];
 comp_young_y=[comp_young_yleft,comp_young_yright];
 
r=1;
 sum=0;
   while r<=length(comp_drop_xleft)
       residual=(comp_young_xleft(r)-comp_drop_xleft(r));
       sum=sum+abs(residual);
        r=r+1;
   end
   sumleft(l)=sum;
   l=l+1;
r1=1;
 sum1=0;
   while r1<=length(comp_drop_xright)
       residual1=(comp_young_xright(r1)-comp_drop_xright(r1));
       sum1=sum1+abs(residual1);
        r1=r1+1;
   end
   sumright(l1)=sum1;
   l1=l1+1;
   Total=abs(sumleft+sumright);
   bvalue(iteration)=b;
   iteration=iteration+1;
   if Total>Error1
       b=b-0.01;
   else break;
   end
   
   comp_drop_xleft=[];
 comp_drop_yleft=[];
 comp_drop_xright=[];
 comp_drop_yright=[];
 comp_young_xleft=[];
 comp_young_yleft=[];
 comp_young_xright=[];
 comp_young_yright=[];

 end
plot(newshiftdroptotal_x,newshiftdroptotal_y,'g.');
hold on;
plot(lyy_Xtotal,lyy_Ytotal,'.');
for i=1:length(lyy_Yright)
    if lyy_Yright(i)==surfacepixel
        Contactangle=Phi(i);
    end
end
end
end
 



 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
