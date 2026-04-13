# minimal-fv-example

A minimal Lean 4 project demonstrating formal verification: a tail-recursive
`List.reverse` implementation paired with a proof that it meets its abstract
specification.

- `Demo.impl` — concrete tail-recursive implementation (`MinimalFvExample/Basic.lean`)
- `Demo.spec` — abstract specification (`xs.reverse`)
- `Demo.impl_correct` — theorem: `impl xs = spec xs`

## Run the concrete implementation on sample values

Executes `Demo.impl` on a concrete list and prints the result alongside the
specification's output.

```sh
lake exe minimal-fv-example
```

Expected output:

```
input    : [1, 2, 3, 4, 5]
impl xs  : [5, 4, 3, 2, 1]
spec xs  : [5, 4, 3, 2, 1]
```

Edit the `input` value in `Main.lean` to try other lists.

## Verify the abstract specification proof

Type-checks the `MinimalFvExample` library. Because Lean checks proofs at
elaboration time, a successful build is a machine-verified guarantee that
`impl_correct` and `impl_meets_spec` hold for **all** inputs — not just the
sample above.

```sh
lake build MinimalFvExample
```

A `Build completed successfully` message means every theorem in the library
has been formally verified by the Lean kernel.
