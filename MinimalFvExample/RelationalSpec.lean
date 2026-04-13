import MinimalFvExample.Impl

namespace Demo

-- 関係形式の抽象仕様: ys は xs の反転である
def IsReverse (xs ys : List α) : Prop :=
  ys = xs.reverse

-- 補助関数 revAux に関する等式 (関係形式仕様のための独立した証明)
theorem revAux_append_reverse (xs acc : List α) :
    revAux xs acc = xs.reverse ++ acc := by
  induction xs generalizing acc with
  | nil =>
      rfl
  | cons x xs ih =>
      simp [revAux, ih, List.reverse_cons, List.append_assoc]

-- 関係形式の仕様の充足
theorem impl_isReverse (xs : List α) : IsReverse xs (impl xs) := by
  simp [IsReverse, impl, revAux_append_reverse]

end Demo
