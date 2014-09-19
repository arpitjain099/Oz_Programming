declare Xs P Forall in
proc{Forall Xs P}
   case Xs of nil then skip
   []X|Xr then {P X}{Delay 1000}{Forall Xr P}end
end
declare L L1 L2 in
thread {Forall L Browse}end
thread L=1|L1 end
thread L1=2|L2 end
thread L2=3|nil end


      