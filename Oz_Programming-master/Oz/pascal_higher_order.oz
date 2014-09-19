declare Pascal Oplist Left Right P
fun
   {Add X Y}X+Y
end
fun {Pascal Op N}
   if N==1 then [1]
   else L in
      L={Pascal Op N-1}
      {Oplist Op{Left L} {Right L}}
   end
end
fun {Oplist Op L K}
   case L of L1|T1 then
      case K of L2|T2 then
	{Op L1 L2}|{Oplist Op T1 T2}
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
thread P in
   P={Pascal Add 10}
   {Browse P}
end
{Browse 99*99}