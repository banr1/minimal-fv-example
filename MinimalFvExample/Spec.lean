namespace Demo

-- Abstract specification: result matches the mathematical reverse
def spec (xs : List α) : List α :=
  xs.reverse

-- Alternative: specification as a proposition
def isRev (xs ys : List α) : Prop :=
  ys = xs.reverse

end Demo
