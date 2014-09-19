local B in
   thread B=true end
   if B==true  then {Browse 'yay'}end
end
local X Y in
thread X=1  end
thread Y=X+1 end
thread X=Y end
{Browse Y}
end
local Gen A B X Y in
   fun{Gen L N}
      {Delay 1000}
      if L==N then nil else L|{Gen L+1 N}end
   end
   A={Gen 1 10}
   B={Map A fun{$ X}X*X end}
  {Browse B}
   thread X={Gen 1 10}end
   thread Y={Map X fun{$X}X*X end }end
   {Browse Y}
end
{Browse 'thread successful'}
