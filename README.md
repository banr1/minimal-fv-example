# minimal-fv-example

形式検証を示す最小構成の Lean 4 プロジェクトです。末尾再帰版の
`List.reverse` 実装と、それが抽象仕様を満たすことの証明をペアで提供します。

一つの具体実装に対して抽象仕様の与え方には複数のスタイルがあり、
本リポジトリではその例として **関数形式** と **関係形式** の 2 つを
それぞれ独立に提示します。両者は互いに依存せず、`Impl` のみを共有する
別々の証明として構成されています。

- `Demo.impl` — 具体的な末尾再帰実装 (`MinimalFvExample/Impl.lean`)
- `Demo.reverseSpec` — 関数形式の抽象仕様 (`xs.reverse`)
- `Demo.IsReverse` — 関係形式の抽象仕様 (命題)
- `Demo.impl_eq_reverseSpec` — 定理: `impl xs = reverseSpec xs`
- `Demo.impl_isReverse` — 定理: `IsReverse xs (impl xs)`

## 具体実装をサンプル値で実行する

`Demo.impl` を具体的なリストに対して実行し、その結果を仕様の出力と
あわせて表示します。

```sh
lake exe minimal-fv-example
```

期待される出力:

```
input    : [1, 2, 3, 4, 5]
impl xs  : [5, 4, 3, 2, 1]
spec xs  : [5, 4, 3, 2, 1]
```

他のリストで試すには `Main.lean` の `input` を書き換えてください。

## 抽象仕様の証明を検証する

`MinimalFvExample` ライブラリを型検査します。Lean はエラボレーション時に
証明を検査するため、ビルドが成功すること自体が `impl_eq_reverseSpec` と
`impl_isReverse` が **すべての** 入力について成り立つことの機械的な
保証になります。上記のサンプル入力だけに対する保証ではありません。

```sh
lake build MinimalFvExample
```

`Build completed successfully` と表示されれば、ライブラリ内のすべての
定理が Lean カーネルによって形式的に検証されたことを意味します。

2 種類の仕様はそれぞれ独立しているため、個別に検証することもできます。
`FunctionalSpec` と `RelationalSpec` の間には証明の依存関係がなく、
一方を削除してももう一方はそのまま検証できます。

```sh
# 関数形式の仕様 (impl_eq_reverseSpec) のみを検証
lake build MinimalFvExample.FunctionalSpec

# 関係形式の仕様 (impl_isReverse) のみを検証
lake build MinimalFvExample.RelationalSpec
```
