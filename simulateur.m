function [e,c,g,a,hl,indic] = simulateur (indic,xy,lm)
  global A B L
  
  e=c=g=a=hl='None';
  
  if mod(length(xy),2) ~= 0
    indic=-1;
  end  
  
  nn=length(xy)/2;
  nb=nn+1;
  x=xy(1:nn);
  y=xy(nn+1:end);
  
  
  
  if indic==1   %Tracé de la chaîne 
    plot([0;x;A],[0;y;B],'-b');
    indic=1;
  end
  if (indic==2)||(indic==4)   %Calcul de e et c
    Y1=[0 y']';
    X1=[0 x']';
    Y2=[y' B]';
    X2=[x' A]';
    V=Y2+Y1;
    ly=Y2-Y1;
    lx=X2-X1;
    li2=lx.^2+ly.^2;
    e=sum(L.*(V/2))
    c=li2-L.^2;
    
    if indic==2
      indic=1;
    end
  end
  
  if (indic==4)   %Calcul e,c,g et a
    L1=L(1:nn)/2;
    L2=L(2:end)/2;
    gy=L1+L2;
    g=[zeros(1,nn) gy']';
    
    a=zeros(nb,2*nn);
    for i=1:nb
      v=zeros(1,2*nn);
      if i==1
        v(1,1)=2*x(1,1);
        v(1,nn+1)=2*y(1,1);
        a(1,:)=v;
      elseif i==nb
        v(1,nn)=-2*(A-x(nn,1));
        v(1,2*nn)=-2*(B-y(nn,1));
        a(nb,:)=v;
      else
        v(1,i)=2*(x(i,1)-x(i-1,1));
        v(1,i-1)=-v(1,i);
        v(1,i+nn)=2*(y(i,1)-y(i-1,1));
        v(1,i+nn-1)=-v(1,i+nn);
        a(i,:)=v;
      end  
    endfor  
    indic=1;
  end


  if indic==5   %Calcul hl
    hl=zeros(2*nn,2*nn);
    for i=1:nb
      h=zeros(2*nn,2*nn);
      if i==1
        h(1,1)=h(nn+1,nn+1)=2;
      elseif i==nb
        h(nn,nn)=h(2*nn,2*nn)=2;
      else
        h(i,i)=h(i-1,i-1)=h(nn+i,nn+i)=h(nn+i-1,nn+i-1)=2;
        h(i,i-1)=h(i-1,i)=h(i+nn,nn+i-1)=h(nn+i-1,nn+i)=-2;
      end
      hl=hl+lm(i,1)*h;
    endfor
    indic=1;
  end


endfunction














