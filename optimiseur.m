function [xy,lm,info] = optimiseur (simul,xy,lm,options)
  
  
  
  m=length(lm);
  n=length(xy);
  maxiter=options.maxit;
  eps1=options.tol(1);
  eps2=options.tol(2);
  
  nbiter=0;
  num=0;
  %subplot(4,4,num);
  %feval(simul,1,xy,lm);
  
  
 
  while 1
    [e,c,g,a,k,indic]=feval(simul,4,xy,lm);
    [e,v,w,z,hl,indic]=feval(simul,5,xy,lm);
    
    nbiter=nbiter+1;
    num+=1;
    subplot(4,4,num);
    feval(simul,1,xy,lm);

    gradl=g+a'*lm;
    supl=max(gradl.*sign(gradl));
    supc=max(c.*sign(c));
    


    zer=zeros(m,m);
    AA=[hl a';a zer];
    BB=-[g; c];
    s=AA\BB;
    
    d=s(1:n,1);
    l=s(n+1:end,1);
    
    
    
    xy=xy+d;
    lm=l;   
   if nbiter == maxiter
      info.status=2;
      info.niter=maxiter;
      break;
    endif
    

    if (supl<=eps1) && (supc<=eps2)
      info.status=0;
      info.niter=nbiter;
      break;
    endif
    
  endwhile
  
  
  
  
endfunction