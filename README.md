# minimal-fv-example

形式検証を示す最小構成の Lean 4 プロジェクトです。末尾再帰版の
`List.reverse` 実装と、それが抽象仕様を満たすことの証明をペアで提供します。

- `Demo.impl` — 具体的な末尾再帰実装 (`MinimalFvExample/Basic.lean`)
- `Demo.spec` — 抽象仕様 (`xs.reverse`)
- `Demo.impl_correct` — 定理: `impl xs = spec xs`

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
証明を検査するため、ビルドが成功すること自体が `impl_correct` と
`impl_meets_spec` が **すべての** 入力について成り立つことの機械的な
保証になります。上記のサンプル入力だけに対する保証ではありません。

```sh
lake build MinimalFvExample
```

`Build completed successfully` と表示されれば、ライブラリ内のすべての
定理が Lean カーネルによって形式的に検証されたことを意味します。
