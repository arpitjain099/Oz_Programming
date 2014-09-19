declare
fun {Filter L Op}
      case L of H|T then Op H
      [] {Filter T Op}
      end
      {Browse {Filter [1 ~2 8 ~7] Op end}}
end
fun Op{Check N}
   if N>=0 then N
   end
end

   