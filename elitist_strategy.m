function parent = elitist_strategy (F,x,popnum,idistance)
parent=[];
irank=1;
while length(parent)<popnum
   F1=F(irank).f;
   if length(parent)+length(F1)<= popnum
       parent = [parent;x(F1,:)];        
   else 
       number = popnum - length(parent);
       vdistance=idistance(F1);
       vdistance=[vdistance;F1];
       nondistance = sort(vdistance,2,'descend');
       FF = nondistance(2,1:number); 
       parent = [parent;x(FF,:)];
   end
   irank=irank+1;
end