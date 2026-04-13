namespace Demo

-- Abstract specification: result matches the mathematical reverse
def spec (xs : List α) : List α :=
  xs.reverse

-- Concrete implementation: tail-recursive
def revAux : List α → List α → List α
  | [],      acc => acc
  | x :: xs, acc => revAux xs (x :: acc)

def impl (xs : List α) : List α :=
  revAux xs []

-- Implementation lemma
theorem revAux_correct (xs acc : List α) :
    revAux xs acc = xs.reverse ++ acc := by
  induction xs generalizing acc with
  | nil =>
      rfl
  | cons x xs ih =>
      simp [revAux, ih, List.reverse_cons, List.append_assoc]

-- Specification satisfaction
theorem impl_correct (xs : List α) :
    impl xs = spec xs := by
  simp [impl, spec, revAux_correct]

-- Alternative: specification as a proposition
def isRev (xs ys : List α) : Prop :=
  ys = xs.reverse

theorem impl_meets_spec (xs : List α) : isRev xs (impl xs) := by
  simp [isRev, impl_correct, spec]

end Demo

def hello := "world"
