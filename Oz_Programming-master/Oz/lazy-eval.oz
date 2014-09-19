%
% Lazy Evaluation
%
declare
fun lazy {Ints N}
   N|{Ints N+1}
end

declare L in
L = {Ints 2}
{Browse L}

{Browse case L of H|_ then H end}

{Browse L.2.1}

{Browse L.1}

{Browse L.2.2.2.2.1}

{Browse {List.drop L 5}}

{Browse {List.drop L 7}}



% From pascal.oz
% Pascal triangle row auxiliary functions

declare fun {ShiftRight L}  0|L end

declare fun {AddList L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 H1+H2|{AddList T1 T2}
      end
   else L2 end
end

declare fun lazy {PascalList Row}
   Row | {PascalList 
                {AddList 
		    Row
		    {ShiftRight Row}}}
end

declare L in
L = {PascalList [1]}

{Browse L}

{Browse L.1}

{Browse L.2.1}

{Browse L.2.2.2.2.1}

declare F1 F2 F3 A B C D in
fun lazy {F1} 1 end
fun lazy {F2} 2 end
fun lazy {F3} {F3} end
B = {F1}
C = {F2}
D = {F3}
{Browse A#B#C#D}

A = B+C
{Browse A}

% Using lazy streams

declare
fun {Sum Xs A Limit} 
   if Limit>0 then 
      case Xs of X|Xr then 
	 {Sum Xr A+X Limit-1} 
      end 
   else A end 
end 

local Xs S1 S2 in
   Xs={Ints 0}
   S1={Sum Xs 0 1500}
   {Browse S1}
   S2={Sum Xs 0 1500000}
   {Browse S2}
end

% Improving throughput using a buffer

% naive version
declare
fun {Buffer1 In N} 
   End={List.drop In N} 
   fun lazy {Loop In End} 
      In.1|{Loop In.2 End.2} 
   end 
in
   {Loop In End} 
end

declare
fun lazy {SlowInts N}
   {Delay 1000}  % one integer per second
   N | {SlowInts N+1}
end

declare Xs S1 S2

   Xs={SlowInts 0}
   S1={Sum Xs 0 15}
   {Browse S1}

   S2={Sum Xs 0 1500}
   {Browse S2}


declare In Out in
In = {SlowInts 1}
Out = {Buffer1 In 5}
% after 5 seconds, trigger 10 integers
{Browse Out}
{Browse Out.2.2.2.2.2.2.2.2.2.2}



% serves the consumer concurrently
declare
fun {Buffer2 In N} 
   End = thread
	    {List.drop In N}
	 end
   fun lazy {Loop In End} 
      In.1|{Loop In.2 End.2} 
   end 
in
   {Loop In End} 
end

declare In Out in
In = {SlowInts 1}
Out = {Buffer2 In 5}
{Browse Out}
% after 5 seconds
{Browse Out.2.2.2.2.2.2.2.2.2.2}

% concurrently requests the next element
declare
fun {Buffer3 In N} 
   End = {List.drop In N}
   fun lazy {Loop In End}
      E2 = thread End.2 end in
      In.1|{Loop In.2 E2} 
   end 
in 
   {Loop In End} 
end


declare In Out in
In = {SlowInts 1}
Out = {Buffer3 In 5}
{Browse Out}
% after 5 seconds
{Browse Out.2.2.2.2.2.2.2.2.2.2}

% concurrently serves the consumer and requests the next element
declare
fun {Buffer4 In N} 
   End = thread 
	    {List.drop In N}
	 end
   fun lazy {Loop In End}
      E2 = thread End.2 end in
      In.1|{Loop In.2 E2} 
   end 
in 
   {Loop In End} 
end


declare In Out in
In = {SlowInts 1}
Out = {Buffer4 In 5}
{Browse Out}
% immediately serve consumer
{Browse Out.2.2.2.2.2.2.2.2.2.2}

{Browse {List.drop Out 20}}

% Larger example
% The Sieve of Erastothenes

declare
fun lazy {LFilter Xs F}
   case Xs
   of nil then nil
   [] X|Xr then
      if {F X} then X|{LFilter Xr F} else {LFilter Xr F} end
   end
end

%Lazy filter for infinite streams
declare
fun lazy {LFilter Xs F}
   X|Xr = Xs in
   if {F X} then X|{LFilter Xr F}
   else {LFilter Xr F} end
end

declare
fun lazy {Sieve Xs}
   X|Xr = Xs in
   X | {Sieve {LFilter
	       Xr
	       fun {$ Y} Y mod X \= 0 end
	      }}
end

declare
fun {Primes} {Sieve {Ints 2}} end

local P in
   P = {Primes}
   {Browse P}
   {Browse {List.drop P 20}}
end

%implicit streams

local Ones in
   Ones = 1|Ones
   {Browse Ones}
   {Browse Ones.2.2.1}
end

declare
fun lazy {LMap Xs F}
   case Xs
   of nil then nil
   [] X|Xr then
      {F X}|{LMap Xr F}
   end
end

local Xs in
   Xs = 1 | {LMap Xs fun {$ X} X+1 end}
   {Browse Xs}
   {Browse Xs.2.2.2.1}
end
