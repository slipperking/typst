// Tests convergence warnings.

--- convergence-query paged ---
// Warning: document did not converge within 25 attempts
// Hint: see 4 additional warnings for more details
// Hint: see https://typst.app/help/convergence for help
#import "switch.typ": switch
#show strong: none

= Real <real>

#context {
  // Warning: 15-29 number of heading elements did not stabilize
  // Hint: 15-29 the following numbers of elements were observed:\n- run 1: 0\n- run 2: 1\n- run 3: 2\n- run 4: 3\n- run 5: 4\n- run 6: 5\n- run 7: 6\n- run 8: 7\n- run 9: 8\n- run 10: 9\n- run 11: 10\n- run 12: 11\n- run 13: 12\n- run 14: 13\n- run 15: 14\n- run 16: 15\n- run 17: 16\n- run 18: 17\n- run 19: 18\n- run 20: 19\n- run 21: 20\n- run 22: 21\n- run 23: 22\n- run 24: 23\n- run 25: 24\n- final: 25
  let elems = query(heading)
  let count = elems.len()
  count * [= Fake <fake>]
}

#context {
  // This one converges.
  _ = query(<real>)
}

// Test alternative warning messages.
#context {
  // Warning: 7-37 number of matching heading elements did not stabilize
  // Hint: 7-37 the following numbers of elements were observed:\n- run 1: 0\n- run 2: 1\n- run 3: 2\n- run 4: 3\n- run 5: 4\n- run 6: 5\n- run 7: 6\n- run 8: 7\n- run 9: 8\n- run 10: 9\n- run 11: 10\n- run 12: 11\n- run 13: 12\n- run 14: 13\n- run 15: 14\n- run 16: 15\n- run 17: 16\n- run 18: 17\n- run 19: 18\n- run 20: 19\n- run 21: 20\n- run 22: 21\n- run 23: 22\n- run 24: 23\n- run 25: 24\n- final: 25
  _ = query(heading.where(level: 1))

  // Warning: 7-20 number of elements labelled `<fake>` did not stabilize
  // Hint: 7-20 the following numbers of elements were observed:\n- run 1: 0\n- run 2: 0\n- run 3: 1\n- run 4: 2\n- run 5: 3\n- run 6: 4\n- run 7: 5\n- run 8: 6\n- run 9: 7\n- run 10: 8\n- run 11: 9\n- run 12: 10\n- run 13: 11\n- run 14: 12\n- run 15: 13\n- run 16: 14\n- run 17: 15\n- run 18: 16\n- run 19: 17\n- run 20: 18\n- run 21: 19\n- run 22: 20\n- run 23: 21\n- run 24: 22\n- run 25: 23\n- final: 24
  _ = query(<fake>)

  // Warning: 7-48 number of elements matching `selector.or(<fake>, heading.where(level: 1))` did not stabilize
  // Hint: 7-48 the following numbers of elements were observed:\n- run 1: 0\n- run 2: 1\n- run 3: 2\n- run 4: 3\n- run 5: 4\n- run 6: 5\n- run 7: 6\n- run 8: 7\n- run 9: 8\n- run 10: 9\n- run 11: 10\n- run 12: 11\n- run 13: 12\n- run 14: 13\n- run 15: 14\n- run 16: 15\n- run 17: 16\n- run 18: 17\n- run 19: 18\n- run 20: 19\n- run 21: 20\n- run 22: 21\n- run 23: 22\n- run 24: 23\n- run 25: 24\n- final: 25
  _ = query(heading.where(level: 1).or(<fake>))
}

// This one has no hint since the number of matching elements is the same and
// it's difficult to provide a good hint for the concrete elements.
#switch(n => if n == 4 [*A*] else [*B*])
#context {
  _ = query(strong)
}

--- convergence-query-first-and-unique paged ---
#import "switch.typ": switch
#switch(n => if n == 4 [*A* <a>] else if n == 5 [_A_ <a>])

#link(<a>)[Link]

--- convergence-query-label paged ---
#import "switch.typ": switch
#set heading(numbering: "1.")
= A

#switch(n => if n == 5 [= B <b>])

@b

--- convergence-position paged ---
#import "switch.typ": switch

#switch(n => v(n * 10pt) + [= Heading])

#context locate(heading).position().y

--- convergence-page paged ---
#import "switch.typ": switch

// No "heading was created here" hint because the heading does not exist anymore
// in the end.
#switch(n => if n == 4 { pagebreak() + [= Heading] })

// Error: 10-25 selector does not match any element
#context locate(heading).page()

--- convergence-page-supplement paged ---
#import "switch.typ": switch

#set page(numbering: "1", margin: (bottom: 20pt))
#show: doc => switch(n => {
  set page(supplement: "Pagus", numbering: "I") if n == 4
  doc
})

= Hello <hello>

#ref(<hello>, form: "page")

--- convergence-state paged empty ---
// Warning: document did not converge within 25 attempts
// Hint: see 1 additional warning for more details
// Hint: see https://typst.app/help/convergence for help

#let hi = state("hi", 0)
#context hi.update(hi.get() + 1)
#context hi.update(hi.get() + 2)
#context hi.update(hi.get() + 3)
#context hi.update(hi.get() + 4)
#context hi.update(hi.get() + 5)

#context hi.update(hi.get() + 6)

#let s = state("s", 1)

// Warning: 19-28 value of `state("s")` did not converge
// Hint: 19-28 the following values were observed:\n- run 1: `1`\n- run 2: `2`\n- run 3: `3`\n- run 4: `4`\n- run 5: `5`\n- run 6: `6`\n- run 7: `7`\n- run 8: `8`\n- run 9: `9`\n- run 10: `10`\n- run 11: `11`\n- run 12: `12`\n- run 13: `13`\n- run 14: `14`\n- run 15: `15`\n- run 16: `16`\n- run 17: `17`\n- run 18: `18`\n- run 19: `19`\n- run 20: `20`\n- run 21: `21`\n- run 22: `22`\n- run 23: `23`\n- run 24: `24`\n- run 25: `25`\n- final: `26`
// Hint: 19-28 see https://typst.app/help/state-convergence for help
#context s.update(s.final() + 1)

--- convergence-state-errored paged empty ---
#import "switch.typ": switch
#let s = state("s")
// Error: 40-47 panicked
#switch(n => s.update(if n == 5 { _ => panic() } else { "ok" }))

#context { _ = s.get() }

--- convergence-counter paged empty ---
// Warning: document did not converge within 25 attempts
// Hint: see 2 additional warnings for more details
// Hint: see https://typst.app/help/convergence for help
#let c = counter("hi")

// Warning: 16-27 value of `counter("hi")` did not converge
// Hint: 16-27 the following values were observed:\n- run 1: 0\n- run 2: 0, 1\n- run 3: 0, 1, 3\n- run 4: 0, 1, 3, 7\n- run 5: 0, 1, 3, 7, 15\n- run 6: 0, 1, 3, 7, 15, 31\n- run 7: 0, 1, 3, 7, 15, 31, 63\n- run 8: 0, 1, 3, 7, 15, 31, 63, 127\n- run 9: 0, 1, 3, 7, 15, 31, 63, 127, 255\n- run 10: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511\n- run 11: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023\n- run 12: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047\n- run 13: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095\n- run 14: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191\n- run 15: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383\n- run 16: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767\n- run 17: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535\n- run 18: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071\n- run 19: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143\n- run 20: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287\n- run 21: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287, 1048575\n- run 22: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287, 1048575, 2097151\n- run 23: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287, 1048575, 2097151, 4194303\n- run 24: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287, 1048575, 2097151, 4194303, 8388607\n- run 25: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287, 1048575, 2097151, 4194303, 8388607, 16777215\n- final: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287, 1048575, 2097151, 4194303, 8388607, 16777215, 33554431
#context { _ = c.at(<end>) }

#context c.update({
  // Warning: 11-20 value of `counter("hi")` did not converge
  // Hint: 11-20 the following values were observed:\n- run 1: 0\n- run 2: 0, 1\n- run 3: 0, 1, 3\n- run 4: 0, 1, 3, 7\n- run 5: 0, 1, 3, 7, 15\n- run 6: 0, 1, 3, 7, 15, 31\n- run 7: 0, 1, 3, 7, 15, 31, 63\n- run 8: 0, 1, 3, 7, 15, 31, 63, 127\n- run 9: 0, 1, 3, 7, 15, 31, 63, 127, 255\n- run 10: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511\n- run 11: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023\n- run 12: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047\n- run 13: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095\n- run 14: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191\n- run 15: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383\n- run 16: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767\n- run 17: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535\n- run 18: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071\n- run 19: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143\n- run 20: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287\n- run 21: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287, 1048575\n- run 22: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287, 1048575, 2097151\n- run 23: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287, 1048575, 2097151, 4194303\n- run 24: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287, 1048575, 2097151, 4194303, 8388607\n- run 25: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287, 1048575, 2097151, 4194303, 8388607, 16777215\n- final: 0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, 131071, 262143, 524287, 1048575, 2097151, 4194303, 8388607, 16777215, 33554431
  let v = c.final()
  v + (1 + v.last() * 2,)
})

#metadata(none) <end>

--- converge-bibliography-1 paged ---
#import "switch.typ": switch
#switch(n => if n >= 5 { bibliography("/assets/bib/works.bib") })

@netwok

--- converge-bibliography-2 paged ---
#import "switch.typ": switch

#switch(n => if n >= 4 { bibliography("/assets/bib/works.bib") })

@netwok

--- convergence-measure paged empty ---
#import "switch.typ": switch
#switch(n => {
  let body = [= Hello]

  _ = measure(body)
  if n == 4 {
    body
  }
})

--- convergence-html-id html ---
#import "switch.typ": switch
#switch(n => calc.min(n, 4) * [= Heading <a>])

#context link(query(heading).last().location())[Hello]

--- convergence-state-converged-but-not-query paged empty ---
// In this example, the "high-level" state introspection yielded the same
// value in iteration 4 and 5, but the "low-level" state query yielded a
// different sequence. It also converged, but we don't know that until one
// iteration later.
#import "switch.typ": switch
#let s = state("a", none)
#switch(n => if n == 5 { s.update(none) })
#context s.get()
