
% Lists
declare
H=1
T = [2 3 4 5]
{Browse H|T}  % This will show [1 2 3 4 5]

{Browse [1]|[2 3 4 5]}

declare  L = [5 6 7 8]
{Browse L.1}
{Browse L.2}

declare L = [[1] 2 3 4 5]
{Browse L.1}

{Browse L.2.1}

{Browse L.1.1}

% "." is not allowed for numbers:
{Browse L.1.1.2}

{Browse L.1.2}

case L of H|T then {Browse H} {Browse T} end

declare L = [1 2 3 4]

{Browse L}

%Oz bug!?:  The following works:
case L of E1|E2|T then {Browse E1} end

% but the following seems to crash:
case L of E1|E2|T then {Browse E1} {Browse E2} {Browse T} end

case L of E1|E2|T then {Browse E2} end

% the following works:
case L of H1|T1 then
   case T1 of H2|T2 then
      {Browse H2}
   end
end

% inside a local statement, things work as expected:
local L=[1 2 3 4] in
   case L of E1|E2 then
      {Browse E2}
   end
   case L of E1|E2|E3 then
      {Browse E2}
   end
   case L of E1|E2|E3|E4 then
      {Browse E2}
   end
   case L of E1|E2|E3|E4|nil then
      {Browse E2}
   end
   case L of E1|E2|E3|E4|E5 then
      {Browse E2}
   end
   case L of E1|E2|E3|E4|E5|E6 then
      {Browse E2}
   else {Browse 'no match'}
   end
end

% in a single statement, it works:
declare
L = [1 2 3 4]
case L of E1|E2|E3|E4 then
      {Browse E2}
end

% but in two separate statements, it crashes:
declare
L = [1 2 3 4]

case L of E1|E2|E3|E4 then
      {Browse E2}
end

% that seems to isolate the Mozart/Oz implementation bug!



