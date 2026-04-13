namespace Demo

-- 抽象仕様: 結果は数学的な reverse と一致する
def spec (xs : List α) : List α :=
  xs.reverse

-- 別形式: 命題としての仕様
def isRev (xs ys : List α) : Prop :=
  ys = xs.reverse

end Demo
