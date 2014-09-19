%
% Higher-Order Programming
%

%SumList
declare
fun {FoldFactory F U}
   fun {FoldR L F U}
      case L
      of nil then U
      []  X|L2 then {F X  {FoldR L2 F U}}
      end
   end
in
   fun {$ L} {FoldR L F U} end
end

declare
SumList={FoldFactory fun {$ A B} A+B end 0}
{Browse {SumList [1 2 3]}}

%for I in 1..10 do {Browse I} 
declare
proc {For I J P}
   if I > J then skip
   else {P I} {For I+1 J P}
   end
end
{For 1 10 Browse}

for I in 1..10 do {Browse I} end

%
declare
proc {ForAll Xs P}
   case Xs
   of nil then skip
   [] X|Xr then
      {P X} {ForAll Xr P}
   end
end
{ForAll [m n s t]
 proc{$ I} {System.showInfo "the item is: " # I} end}

declare 
for I in [a b c d] do
   {System.showInfo "the item is: " # I}
end

declare
proc {ForAll Xs P}
   local L = {Map Xs fun {$ X} {P X} X end} in skip end
end
{ForAll [m n s t]
 proc{$ I} {System.showInfo "the item is: " # I} end}


%map
declare
fun {Map Xs F}
   case Xs
   of nil then nil
   [] X|Xr then
      {F X}|{Map Xr F}
   end
end
{Browse {Map [1 2 3 4] fun {$ I} I*I end}}

%filter
declare
fun {Filter Xs P}
   case Xs
   of nil then nil
   [] X|Xr andthen {P X} then
      X|{Filter Xr P}
   [] X|Xr then {Filter Xr P}
   end
end
{Browse {Filter [1 2 3 4] fun {$ A} A<3 end}}

%DFS tree
declare
proc {DFS Tree F}
   case Tree of tree(node:N sons:Sons ...) then
      {F N}
      for T in Sons do {DFS T F} end
   end
end
T=tree(node:1 sons:[tree(node:2 sons:nil) tree(node:3 sons:[tree(node:4 sons:nil)])])
{DFS T Browse}

%
declare
fun {FoldL Xs F U}
   case Xs
   of nil then U
   [] X|Xr then {FoldL Xr F {F X U}}
   end
end
{Browse {FoldL [1 2 3]
	 fun {$ X Y} X|Y end nil}}

local 
fun {AndThen B1 B2}
   if B1 then B2 else false
   end
end
in
local X = 4.0 Y = 0.0 in
   {Browse {AndThen Y==0 X/Y>4.0}}
end
end

{Browse 4.0/0.0}

%short-circuit evaluation in Oz
if false andthen {fun {$} {Browse 'test'} false end} then {Browse 'done'} end

% procedural abstraction
local 
fun {AndThen B1 B2}
   if B1 then B2 else false
   end
end
in
local X = 4.0 Y = 0.0 in
   {Browse {AndThen Y\=0 {fun {$} X = 3.0 true end}}}
end
end

% using a procedure value (thunk) to avoid B2's evaluation:
local 
fun {AndThen B1 B2}
   if {B1} then {B2} else false
   end
end
in
local X = 4.0 Y = 0.0 in
   {Browse {AndThen fun {$} Y\= 0.0 end
	            fun {$} X = 3.0 true end}
   }
end
end