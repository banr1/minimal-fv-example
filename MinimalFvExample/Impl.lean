namespace Demo

-- Concrete element type: 256-bit machine integer (e.g. Solidity int256).
abbrev Int256 := BitVec 256

-- Tail-recursive reversal helper for `Array Int256`.
-- Walks `i` down from `src.size` to `0`, pushing `src[i]` onto `acc`
-- at each step. The bound `i ≤ src.size` lets us index `src` safely.
def revAux (src : Array Int256) :
    (i : Nat) → i ≤ src.size → Array Int256 → Array Int256
  | 0,     _, acc => acc
  | n + 1, h, acc =>
      have hi : n < src.size := h
      revAux src n (Nat.le_of_lt hi) (acc.push src[n])

def impl (src : Array Int256) : Array Int256 :=
  revAux src src.size (Nat.le_refl _) #[]

end Demo
