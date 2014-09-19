declare Op Filter 
fun{$Op} Op<0 end
fun {Filter Xs P}
   case Xs
   of nil then nil
   [] X|Xr andthen {P X} then
      X|{Filter Xr P}
   [] X|Xr then {Filter Xr P}
   end
end
{Browse {Filter [1 ~2 8 ~7] Op}}
