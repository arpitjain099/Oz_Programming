local Y LB in
   Y=0
   proc{LB X ?Z}
      if X>Y then Z=X else Z=Y end
   end
   local Y= 15 Z in {LB 5 Z}
   end
   {Browse Y}
end
declare Y=3 in
local X in X=1
   local X in X=2
      {Browse X}
   end {Browse Y}
end
%proc with external ref
{Browse 'hello'}
local Y B in Y=2
   local Copy in local A in Copy=proc{$ B ?A}
		    A=Y
				 end
		          {Copy 1 A}
      {Browse A}
		 end
   end
end
declare X Y Res
fun{Concat L M}
   case L of nil then M
   [] H|T then  H|{Concat T M}
   end
end
X=1|2|3|nil
Y=4|6|5|nil
fun{Length P}
   case P of nil then 0 else
      1+{Length P.2}
   end
end
{Concat X Y Res}
{Browse Res}