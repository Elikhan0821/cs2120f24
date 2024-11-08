namespace cs2120f24.constructiveLogic

/-! HOMEWORK #6. COUNTS FOR TWO ASSIGNMENTS.

This is an important homework. It gives you an
opportunity to work out many of the kinks in your
understanding of predicate logic and deductive
proofs in type theory. With P, Q, and R accepted
as propositions, you are to give proofs of all of
the identities from Library/propLogic/identities,
which I've rewritten in Lean for you. There's one
of these axioms that has no constructive proof (in
just one direction). You can just identify it.
-/


-- Suppse P, Q, and R are arbitrary propositions
axiom P : Prop
axiom Q : Prop
axiom R : Prop

/-!
Give proofs in Lean that each of the following identities
is valid. We already know they're classically valid as we
validated their propositional logic analogics semantically
using our model / validity checker. To get you started with
a concrete example, we prove the first one for you and give
a little English explanation after. You should od the same
for each proposition you prove.
-/


def andIdempotent   : P ↔ (P ∧ P) :=
Iff.intro
  -- forward direction: P → P ∧ P
  -- assume p : P, show P ∧ P
  (fun (p : P) => (And.intro p p))
  -- backwards direction: P ∧ P → P
  (fun (h : And P P) => (h.right))

/-!
In English: To prove P ↔ P ∧ P it will suffice
by iff intro, to have proofs, (fw : P → (P ∧ P))
and (bw : (P ∧ P) → P). Each is proved by giving
an argument to result proof construction.

Forward direction:

To prove P → P ∧ P, we show (by defining one) that
there is a function that turns any proof of P into
a proof of P ∧ P. There just one answer: ⟨ p, p ⟩.

Backward direction:

To prove P ∧ P → P, we assume a proof, (h : P ∧ P),
and are to show P. Either h.left or h.right will do.

Summary: Whether in formal logic or English language,
you have to know that to prove any equivance, P ↔ Q,
it is both sufficient and necessary that you have or
obtain proofs (fw : P → Q) and (bw: Q → P). With these
values, the term, (Iff.intro fw bw), is a proof of the
equivalence.
-/

-- What we are to prove is that ∨ is idemponent
-- That is, that for any P, P ↔ (P ∨ P).
def orIdempotent    : P ↔ (P ∨ P) :=
-- Proof: by application if iff.intro
-- iff intro
(
  Iff.intro
  -- Proof of P → P ∨ P
  (fun (p : P) => Or.inl p)
  -- Required proof of backward implication
  (fun (h : P ∨ P) =>
    (Or.elim
      h
      (fun p => p)
      (fun p => p)
    )
  )
)

def andCommutative  : (P ∧ Q) ↔ (Q ∧ P) :=
_

def orCommutative   : (P ∨ Q) ↔ (Q ∨ P) :=
_

def identityAnd     : (P ∧ True) ↔ P :=
_

def identityOr      : (P ∨ False) ↔ P :=
Iff.intro
  -- forwards
  (fun (h : P ∨ False) =>
    (Or.elim h
      (fun (p : P) => p)
      (fun (f : False) => False.elim f)
    )
  )
  -- backwards
  (fun (p : P) =>
    (Or.inl p)
  )

def annhilateAnd    : (P ∧ False) ↔ False  :=
_

def annhilateOr     : (P ∨ True) ↔ True :=
_

def orAssociative   : ((P ∨ Q) ∨ R) ↔ (P ∨ (Q ∨ R)) :=
_

def andAssociative  : ((P ∧ Q) ∧ R) ↔ (P ∧ (Q ∧ R)) :=
_

def distribAndOr    : (P ∧ (Q ∨ R)) ↔ ((P ∧ Q) ∨ (P ∧ R)) :=
_

def distribOrAnd    : (P ∨ (Q ∧ R)) ↔ ((P ∨ Q) ∧ (P ∨ R)) :=
_

def equivalence     : (P ↔ Q) ↔ ((P → Q) ∧ (Q → P)) :=
_

def implication     : (P → Q) ↔ (¬P ∨ Q) :=
Iff.intro
  (fun (h : P → Q) =>
    (Or.inr _))
  (fun (h : (¬P ∨ Q)) =>
    (fun (p : P) =>
      Or.elim
      h
      (fun (k : ¬P) => False.elim (k p))
      (fun q => q)
    )
  )


def exportation     : ((P ∧ Q) → R) ↔ (P → Q → R) :=
_

def absurdity       : (P → Q) ∧ (P → ¬Q) → ¬P :=
_

def distribNotAnd   : ¬(P ∧ Q) ↔ (¬P ∨ ¬Q) :=
_

def distribNotOr    : ¬(P ∨ Q) ↔ (¬P ∧ ¬Q) :=
_


/-!
EXTRA CREDIT: apply the axiom of the excluded middle
to give a classical proof of the one proposition that
you identified as having no constructive proof. The
axiom is available as Classical.em (p : Prop) : p ∨ ¬p.
-/

#check Classical.em
-- Classical.em (p : Prop) : p ∨ ¬p
-- Given any proposition p, you can have a proof of p ∨ ¬p
-- You then have two cases: one with a proof of p, one with ¬p
example (A : Prop) : A ∨ ¬A := Classical.em A