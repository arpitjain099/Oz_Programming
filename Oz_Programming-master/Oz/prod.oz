local Accumulate Product in
   fun {Product X Y}
      X * Y
   end
   %==============
   % Function to calculate the cumulative result of
   % iterative application of BinOp over the list L.
   % BinOp is assumed to be right-associative.
   % Identity is the identity element of BinOp.
   %==============
   fun {Accumulate L BinOp Identity}
      case L
      of nil then Identity
      [] H|T then {BinOp H {Accumulate T BinOp Identity}}
      end
   end
   %======== Example Usage ======
   {Browse {Accumulate [1 2 3] Product 1}}
end
