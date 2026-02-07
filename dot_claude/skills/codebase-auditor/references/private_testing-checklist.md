# Testing Checklist

## Missing Tests

### Critical Path Coverage
- [ ] Core business logic untested
- [ ] Authentication/authorization untested
- [ ] Payment/transaction flows untested
- [ ] Error handling paths untested

### Edge Cases
- [ ] Boundary conditions not tested
- [ ] Empty/null inputs not tested
- [ ] Maximum limits not tested
- [ ] Concurrent access not tested

### Integration Points
- [ ] API endpoints without tests
- [ ] Database operations untested
- [ ] External service integrations untested

## Test Quality Issues

### Weak Assertions
- [ ] Tests without assertions
- [ ] Only checking for no exceptions
- [ ] Asserting on implementation details
- [ ] Missing negative test cases

### Flaky Tests
- [ ] Tests dependent on timing
- [ ] Tests dependent on order
- [ ] Tests with random data without seeds
- [ ] Tests dependent on external state

### Test Interdependence
- [ ] Tests sharing mutable state
- [ ] Tests depending on other tests' side effects
- [ ] Missing test isolation

## Disabled/Skipped Tests

### Permanently Skipped
- [ ] Old skipped tests without reason
- [ ] TODO tests never implemented
- [ ] Disabled tests hiding failures

## Test Anti-Patterns

### Tests Testing Framework
- [ ] Testing mocks instead of code
- [ ] Excessive mocking
- [ ] Tests that always pass

### Tightly Coupled Tests
- [ ] Tests breaking when implementation changes
- [ ] Testing private methods directly
- [ ] Whitebox testing where blackbox would suffice

### Slow Tests
- [ ] Unnecessary I/O in unit tests
- [ ] Real network calls in unit tests
- [ ] Database operations in unit tests

## Coverage Gaps

### Untested Error Paths
- [ ] Exception handlers untested
- [ ] Fallback code untested
- [ ] Retry logic untested

### Untested Branches
- [ ] Else clauses without coverage
- [ ] Switch default cases untested
- [ ] Short-circuit evaluations

### Missing Scenarios
- [ ] Only happy path tested
- [ ] No stress/load tests
- [ ] No security-focused tests

## Test Organization

### Naming Issues
- [ ] Unclear test names
- [ ] Test names not describing behavior
- [ ] Inconsistent naming conventions

### Structure Issues
- [ ] No separation of unit/integration tests
- [ ] Tests in wrong location
- [ ] Missing test utilities/helpers

## Mock/Stub Issues

### Over-Mocking
- [ ] Mocking too many dependencies
- [ ] Mocks hiding bugs
- [ ] Mocks not matching real behavior

### Missing Mocks
- [ ] External services called in tests
- [ ] Time-dependent code not mocked
- [ ] Random values not controlled

## Assertions Quality

### Missing Assertions
- [ ] Tests with no expect/assert
- [ ] Incomplete assertions
- [ ] Not checking all returned values

### Wrong Assertion Types
- [ ] Using equality for object comparison
- [ ] String matching when structure needed
- [ ] Loose equality vs strict equality
