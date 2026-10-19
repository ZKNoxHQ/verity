import Contracts.Common

namespace Contracts.Smoke

open Contracts
open Verity hiding pure bind
open Verity.EVM.Uint256

/-! Regression: a `Unit` internal helper called in non-tail position must return to its
    caller. Before the fix, the end of `bump` lowered to `stop()`, which halted the transaction
    (successfully) after the first helper: `twice` left `counter` at 1 instead of 2 on the EVM,
    while the source semantics below give 2. -/
verity_contract VoidHelperSequence where
  storage
    counter : Uint256 := slot 0

  function internal bump () : Unit := do
    let c ← getStorage counter
    setStorage counter (add c 1)

  function allow_post_interaction_writes twice () : Unit := do
    bump
    bump

  function view get () : Uint256 := do
    let c ← getStorage counter
    return c

/-- Source semantics: both helper calls run, `counter = 2`. The compiled Yul must agree. -/
def voidHelperSequenceTwiceCounts : Bool :=
  match VoidHelperSequence.twice Verity.defaultState with
  | .success _ s =>
      match VoidHelperSequence.get s with
      | .success v _ => v == 2
      | _ => false
  | _ => false

example : voidHelperSequenceTwiceCounts = true := by decide

end Contracts.Smoke
