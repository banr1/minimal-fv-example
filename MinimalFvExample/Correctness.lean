import MinimalFvExample.Spec
import MinimalFvExample.Impl

namespace Demo

-- 実装に関する補題
theorem revAux_correct (xs acc : List α) :
    revAux xs acc = xs.reverse ++ acc := by
  induction xs generalizing acc with
  | nil =>
      rfl
  | cons x xs ih =>
      simp [revAux, ih, List.reverse_cons, List.append_assoc]

-- 仕様の充足
theorem impl_correct (xs : List α) :
    impl xs = spec xs := by
  simp [impl, spec, revAux_correct]

theorem impl_meets_spec (xs : List α) : isRev xs (impl xs) := by
  simp [isRev, impl_correct, spec]

end Demo
