
declare X  Great in
fun{Filter L Arg}
   case L of H|T then
      if H>=0 then Append H {Filter T Arg}
      end
   end
end
{Browse Filter [1 5 ~3 4 ~4] Great}
