/-
  The simp set behind `verity_unfold` (see `Verity/Proofs/Stdlib/Automation.lean`).

  A registered simp attribute, so that layers above `Verity.Core` extend the unfolding set
  without editing the tactic: `Automation.lean` tags the storage lenses, the context readers,
  event emission and the monad operations; `Contracts.Common` tags the EDSL `emit`/
  `EventArg.toWord`; a contract may tag its own internal helpers. (A simp attribute can only
  be used by modules that import the one registering it, hence this separate file.)
-/

import Verity.Core

/-- Declarations unfolded by `verity_unfold`. -/
register_simp_attr verity_unfold_simps
