import MinimalFvExample.Impl

namespace Demo

-- Functional spec stated on the `toList` view of the array: the
-- implementation must agree with the standard list reversal.
def reverseSpec (a : Array Int256) : List Int256 :=
  a.toList.reverse

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

-- Loop invariant for `revAux`: starting from `acc`, the helper appends the
-- reverse of the first `i` elements of `src` to `acc`.
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

-- Functional spec satisfaction.
theorem reverseImpl_eq_reverseSpec (src : Array Int256) :
    (reverseImpl src).toList = reverseSpec src := by
  rw [reverseImpl, reverseSpec, revAux_toList]
  simp [← Array.length_toList, List.take_length]

end Demo
