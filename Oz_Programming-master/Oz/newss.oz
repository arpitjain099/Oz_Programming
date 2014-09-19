declare
fun {Filter Pred L}
   case L of
      H|T then if {Pred H}
               then H|{Filter T Pred}
               else {Filter T Pred}
               end
   else nil
   end
end
fun {IsNonNegative X}
   if X>= 0 then true else false end
end
{
 Browse
 {
  Filter IsNonNegative [~3 3 ~7 5 2 ~3 ~5 6] 
 }
}