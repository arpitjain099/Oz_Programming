declare Pascal Addlist Left Right
fun {Pascal N}
   if N==1 then [1]
   else L in
      L={Pascal N-1}
      {Addlist{Left L} {Right L}}
   end
end
fun {Addlist L K}
   case L of L1|T1 then
      case K of L2|T2 then
	 L1+L2|{Addlist T1 T2}
      end
   else nil end
end
fun {Right L}
   0|L
end
fun {Left L}
   case L of H|T then
      H|{Left T}
   else [0]
   end
end
{Browse {Pascal 5}}