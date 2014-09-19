declare Pascal Addlist Shiftleft Shiftright
fun{Pascal N}
   if N==1 then [1]
   else {Addlist{Shiftleft{Pascal N-1}}{Shiftright{Pascal N-1}}}
	end
end
      fun {Shiftleft L}
	 case L of H|T then
	    H|{Shiftleft T}
	 else [0]
	 end
      end

      fun {Shiftright L} 0|L end
	    
   fun {Addlist L1 L2}
      case L1 of H1|T1 then
	 case L2 of H2|T2 then
	    H1+H2|{Addlist T1 T2}
	 end
      else nil end
   end
{Browse {Pascal 5}}