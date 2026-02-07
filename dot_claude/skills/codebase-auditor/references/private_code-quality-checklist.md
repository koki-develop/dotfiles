# Code Quality Checklist

## Dead Code

### Unreachable Code
- [ ] Code after return/throw statements
- [ ] Unreachable branches (always true/false conditions)
- [ ] Unused imports
- [ ] Commented-out code blocks

### Unused Definitions
- [ ] Unused functions/methods
- [ ] Unused classes
- [ ] Unused variables
- [ ] Unused parameters

## Code Duplication

### Exact Duplicates
- [ ] Copy-pasted code blocks
- [ ] Duplicate functions with different names
- [ ] Repeated logic that should be abstracted

### Structural Duplicates
- [ ] Similar patterns with minor variations
- [ ] Repeated conditional structures
- [ ] Copy-paste with find-replace

## Complexity Issues

### High Cyclomatic Complexity
- [ ] Functions with many branches
- [ ] Deeply nested conditionals
- [ ] Long switch/case statements

### Long Functions/Methods
- [ ] Functions exceeding ~50 lines
- [ ] Methods doing multiple things
- [ ] God classes with too many responsibilities

### Long Parameter Lists
- [ ] Functions with >5 parameters
- [ ] Boolean parameters (flag arguments)

## Naming Issues

### Poor Naming
- [ ] Single-letter variable names (except iterators)
- [ ] Abbreviations and acronyms
- [ ] Misleading names
- [ ] Inconsistent naming conventions

### Magic Numbers/Strings
- [ ] Hardcoded numeric values
- [ ] Hardcoded string literals
- [ ] Missing named constants

## Design Issues

### Tight Coupling
- [ ] Hard dependencies instead of interfaces
- [ ] Direct instantiation instead of injection
- [ ] Circular dependencies

### Missing Abstractions
- [ ] Primitive obsession
- [ ] Feature envy
- [ ] Data clumps

### God Objects
- [ ] Classes with too many methods
- [ ] Classes with too many fields
- [ ] Classes doing unrelated things

## Technical Debt Markers

### TODO/FIXME Comments
- [ ] Old TODO comments
- [ ] FIXME without tracking
- [ ] HACK markers
- [ ] Temporary workarounds

### Deprecation Warnings
- [ ] Usage of deprecated APIs
- [ ] Deprecated internal code still in use

## Documentation Issues

### Missing Documentation
- [ ] Public APIs without documentation
- [ ] Complex logic without explanation
- [ ] Missing README or setup instructions

### Outdated Documentation
- [ ] Comments not matching code
- [ ] Stale API documentation
- [ ] Wrong examples

## Code Style

### Inconsistencies
- [ ] Mixed indentation (tabs vs spaces)
- [ ] Inconsistent brace style
- [ ] Inconsistent quotes
- [ ] Missing/inconsistent formatting

### Missing Type Safety
- [ ] `any` types (TypeScript)
- [ ] Missing null checks
- [ ] Implicit type conversions
