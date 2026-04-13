import MinimalFvExample

open Demo

def main : IO Unit := do
  let input : List Nat := [1, 2, 3, 4, 5]
  IO.println s!"input    : {input}"
  IO.println s!"impl xs  : {impl input}"
  IO.println s!"spec xs  : {reverseSpec input}"
