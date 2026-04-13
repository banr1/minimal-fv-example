import MinimalFvExample.FunctionalSpec

namespace Demo

-- 関係形式の抽象仕様: ys は xs の反転である
def IsReverse (xs ys : List α) : Prop :=
  ys = xs.reverse

-- 関係形式の仕様の充足
theorem impl_isReverse (xs : List α) : IsReverse xs (impl xs) := by
  simp [IsReverse, impl_eq_reverseSpec, reverseSpec]

end Demo
