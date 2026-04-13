import MinimalFvExample.Impl

namespace Demo

-- 関数形式の抽象仕様: 結果は数学的な reverse と一致する
def reverseSpec (xs : List α) : List α :=
  xs.reverse

-- 補助関数 revAux に関する等式
theorem revAux_eq (xs acc : List α) :
    revAux xs acc = xs.reverse ++ acc := by
  induction xs generalizing acc with
  | nil =>
      rfl
  | cons x xs ih =>
      simp [revAux, ih, List.reverse_cons, List.append_assoc]

-- 関数形式の仕様の充足
theorem impl_eq_reverseSpec (xs : List α) :
    impl xs = reverseSpec xs := by
  simp [impl, reverseSpec, revAux_eq]

end Demo
