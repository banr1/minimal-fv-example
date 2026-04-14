namespace Demo

-- 具体的な要素型: 256 ビットのマシン整数 (例: Solidity の int256)。
abbrev Int256 := BitVec 256

-- `Array Int256` に対する末尾再帰の反転ヘルパー。
-- `i` を `src.size` から `0` まで減らしながら、各ステップで `src[i]` を
-- `acc` に push していく。`i ≤ src.size` の境界により `src` を安全に添字参照できる。
def revAux (src : Array Int256) :
    (i : Nat) → i ≤ src.size → Array Int256 → Array Int256
  | 0,     _, acc => acc
  | n + 1, h, acc =>
      have hi : n < src.size := h
      revAux src n (Nat.le_of_lt hi) (acc.push src[n])

def reverseImpl (src : Array Int256) : Array Int256 :=
  revAux src src.size (Nat.le_refl _) #[]

end Demo
