# Detection Patterns

Detailed checklist for each detection category. Use this as a guide when scanning — not every pattern is a problem in every codebase. Apply judgment based on the project's language, conventions, and context.

## Complexity

### Nested Conditionals
- **Ternary nesting**: Ternary operators nested 2+ levels deep, especially when multiple values derive from the same condition independently (each re-evaluating the same state)
- **If/else chains**: Long if/else-if chains (5+ branches) that could be replaced with lookup tables, maps, enums, or polymorphism
- **Deeply nested blocks**: Code indented 4+ levels deep (nested if/for/try/catch/callback)

### Complex Expressions
- **Long boolean expressions**: Conditions with 4+ clauses joined by AND/OR operators, especially when the intent is unclear without careful reading
- **Inline computation**: Complex calculations or transformations done inline in function arguments or return values instead of named intermediate variables

### Control Flow Nesting
- **Nested asynchronous handling**: Deeply nested callbacks, continuations, or chained asynchronous operations that could be flattened or decomposed into named steps
- **Chained collection operations**: Long chains of collection transformations (map/filter/reduce/select/where/flatMap etc.) that are hard to follow — consider breaking into named intermediate steps

### Search hints
```
# Nested ternaries
? .* \? .* :

# Long boolean chains
&& .* && .* &&
\|\| .* \|\| .* \|\|

# Deep nesting (look for excessive indentation levels)
```

## Duplication

### Repeated Derivation
- **Multiple checks on the same condition**: Different values (colors, messages, class names, status codes, etc.) independently checking the same condition with separate if/else or ternary chains — should derive state once and look up values from a table
- **Repeated null/error checks**: Same guard check performed in multiple places within a function or across closely related functions

### Copy-Paste Code
- **Similar functions**: Two or more functions with nearly identical structure, differing only in a few values — candidates for parameterization or generics
- **Repeated structural blocks**: Similar code blocks (UI templates, SQL queries, API handlers, config stanzas) repeated with minor variations — candidates for shared helpers or templates
- **Duplicate validation logic**: Same validation rules implemented in multiple places instead of a single reusable validator

### Search hints
```
# Look for identical multi-line patterns across files
# Look for the same conditional expression appearing multiple times in a file
```

## Size

### Oversized Functions / Methods
- **Long functions**: Functions over ~80 lines (context-dependent — a 100-line function with straightforward sequential logic may be fine; a 50-line function with complex branching may need splitting)
- **Multiple responsibilities**: Functions that do setup, processing, AND cleanup — especially when the phases are independent
- **Many parameters**: Functions taking 5+ parameters, suggesting they're doing too much or need a structured parameter (object, struct, config)

### Oversized Files / Classes
- **Large files**: Source files over ~400 lines (excluding tests) are worth examining for split opportunities
- **God classes / modules**: A single class or module that accumulates unrelated functionality — a sign of a "junk drawer"
- **Many exports**: Files exporting many unrelated functions or types

### Large Code Blocks
- **Monolithic blocks**: Functions or methods with a single large block of logic (100+ lines without meaningful decomposition) that represents multiple distinct phases or concerns
- **Inline definitions**: Large nested structures (config objects, template literals, data definitions) that obscure the surrounding logic and could be extracted to named constants or separate files

### Search hints
```
# Find large files (use wc -l or similar)
# Find long functions (look for function/method definitions and count lines to next definition)
```

## Abstraction

### Missing Abstractions
- **Repeated literal values**: Magic numbers or strings used in multiple places without named constants
- **Inline configuration**: Config values hardcoded in logic instead of centralized
- **Conditional chains mapping values**: If/else or switch/case chains that map one value to another — candidates for lookup tables, dictionaries, or maps
- **Repeated error handling patterns**: Same try/catch or error-check structure copied across multiple call sites

### Unnecessary Abstractions

*These patterns are about individual extractions that did not pay off. For systemic over-decomposition (too many layers, too many files), see Fragmentation.*

- **Single-use wrappers**: Helper functions, classes, or modules used exactly once, adding indirection without reuse value
- **Over-parameterized utilities**: Utility functions with many options/flags that make them harder to understand than the inline code they replaced
- **Premature generalization**: Abstractions built for "future flexibility" that add complexity without current benefit

### Search hints
```
# Branching constructs with many cases (switch/match/when/cond etc.)
# Look for files where "case" or equivalent keyword appears 8+ times

# Magic numbers (numbers other than 0, 1, -1 appearing in conditions or calculations)
# Search for bare numeric literals in logic — not in constants, config, or test data
```

## Fragmentation

Over-fragmentation makes code harder to follow than necessary. The cost of splitting — indirection, context-switching between files, loss of locality — can exceed the benefit. Look for places where consolidation would improve readability without sacrificing modularity.

*For individual unnecessary extractions (single-use wrappers, premature generalization), see Abstraction > Unnecessary Abstractions. This category focuses on systemic over-decomposition — too many layers, files, or indirection steps.*

### Over-Split Files / Modules
- **Micro-files**: Files containing only 1-2 small functions or a single trivial type definition, where the content would read more naturally alongside its only consumer
- **One-class-per-file taken too far**: Dozens of tiny files in a directory where several logically related types/functions could coexist in one module without confusion
- **Matching pairs that always travel together**: A module and its "helper" or "utils" file that are always imported together and have no independent consumers

### Excessive Indirection
- **Deep call chains for simple operations**: Following a straightforward operation (e.g., saving a record) requires tracing through 5+ function calls across multiple files, each doing minimal work before delegating
- **Thin pass-through layers**: Functions, methods, or classes that accept arguments and forward them to the next layer with little or no transformation — adding a layer of indirection without adding value
- **Wrapper-only modules**: Modules whose sole purpose is re-exporting or thinly wrapping another module's API

### Over-Engineered Patterns
- **Design patterns for trivial cases**: Strategy, Factory, Observer, Visitor, etc. applied where a simple function call or conditional would suffice — the pattern adds ceremony without flexibility benefit
- **Excessive interface/protocol definitions**: Interfaces or abstract classes with only one implementation and no realistic prospect of a second, adding indirection for hypothetical extensibility
- **Plugin architectures for fixed requirements**: Extension points, registries, or hook systems built for requirements that are known and stable — a direct implementation would be simpler and easier to trace

### Forced DRY (Over-Abstracted Shared Code)
- **Divergent callers sharing a "common" function**: A shared function serving callers with different needs, resulting in many parameters, flags, or conditional branches that make the function harder to understand than the duplicated code it replaced
- **Premature parameterization**: Code extracted into a "reusable" utility before there's a second use case, burdened with options no current caller exercises
- **Abstraction with more config than logic**: Helper functions or components where the majority of lines handle options, defaults, or feature flags rather than the core operation

### Search hints
```
# Very small files (use wc -l to find files under ~20 lines in source directories)

# Re-export / barrel files (look for files that only re-export or re-import)
# Keyword: "export", "from", "require", "__all__", "pub use" etc. depending on language

# Over-engineered patterns (search for naming conventions that suggest ceremony)
Factory
Registry
Provider
Handler  # when combined with a directory full of single-method handlers

# Directories with many tiny files (use ls + wc -l to spot directories
# where average file size is under ~30 lines)
```

## Coupling

### Mixed Concerns
- **Business logic in presentation**: Data processing, validation, or orchestration logic mixed into code primarily responsible for output/display
- **Presentation in data layers**: Formatting or display logic in service/repository/model modules
- **Cross-module internals access**: Module A directly reaching into internal implementation details of Module B instead of using its public interface

### Excessive Parameter Passing
- **Pass-through parameters**: Values passed through multiple layers of function calls without being used in intermediate layers
- **Large parameter lists**: Functions or constructors receiving 8+ parameters, suggesting they need decomposition

### Tight Coupling
- **Circular dependencies**: Module A imports from B, B imports from A
- **Implicit dependencies**: Functions that rely on external state, global variables, or singletons instead of explicit parameters
- **Temporal coupling**: Functions that must be called in a specific order but nothing enforces that order

### Search hints
```
# Circular imports (look for mutual import patterns between modules)
# Large parameter lists in function/method signatures
# Global variable usage
```
