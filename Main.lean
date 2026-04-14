import MinimalFvExample

open Demo

def main : IO Unit := do
  let input : Array Int256 :=
    #[1, 2, 3, 4, 5].map (BitVec.ofNat 256)
  IO.println s!"input    : {input.toList.map BitVec.toNat}"
  IO.println s!"impl xs  : {(reverseImpl input).toList.map BitVec.toNat}"
