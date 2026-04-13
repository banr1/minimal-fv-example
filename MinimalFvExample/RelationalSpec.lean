import MinimalFvExample.Impl

namespace Demo

-- Relational spec stated on the `toList` view: `b` is a reversal of `a`.
def IsReverse (a b : Array Int256) : Prop :=
  b.toList = a.toList.reverse

-- Auxiliary: extending `List.take` by one element appends that element.
private theorem listTakeSucc {α} (l : List α) (n : Nat) (h : n < l.length) :
    l.take (n + 1) = l.take n ++ [l[n]] := by
  induction l generalizing n with
  | nil => simp at h
  | cons x xs ih =>
      cases n with
      | zero => simp
      | succ m =>
          have hm : m < xs.length := by
            simp only [List.length_cons] at h
            omega
          simp only [List.take_succ_cons, List.getElem_cons_succ]
          exact congrArg _ (ih m hm)

-- Loop invariant for `revAux` (proved independently from FunctionalSpec).
private theorem revAux_toList (src : Array Int256) (i : Nat) :
    ∀ (h : i ≤ src.size) (acc : Array Int256),
      (revAux src i h acc).toList = acc.toList ++ (src.toList.take i).reverse := by
  induction i with
  | zero =>
      intro _ acc
      simp [revAux]
  | succ n ih =>
      intro h acc
      have hn : n < src.size := h
      have hn' : n < src.toList.length := by
        simpa [Array.length_toList] using hn
      simp only [revAux, ih, Array.toList_push]
      rw [listTakeSucc src.toList n hn', List.reverse_append,
          List.reverse_singleton, List.append_assoc]
      rfl

-- Relational spec satisfaction.
theorem impl_isReverse (src : Array Int256) : IsReverse src (impl src) := by
  rw [IsReverse, impl, revAux_toList]
  simp [← Array.length_toList, List.take_length]

end Demo
