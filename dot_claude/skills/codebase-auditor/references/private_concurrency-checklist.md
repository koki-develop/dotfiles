# Concurrency Checklist

## Race Conditions

### Data Races
- [ ] Shared mutable state without synchronization
- [ ] Check-then-act patterns without locks
- [ ] Read-modify-write without atomicity
- [ ] Non-atomic counter increments

### Time-of-Check to Time-of-Use (TOCTOU)
- [ ] File existence check before access
- [ ] Permission check before operation
- [ ] Balance check before transaction

## Deadlocks

### Lock Ordering
- [ ] Inconsistent lock acquisition order
- [ ] Nested locks without ordering
- [ ] Locks acquired in different orders across functions

### Resource Deadlocks
- [ ] Circular dependencies in resource acquisition
- [ ] Holding locks while waiting for I/O
- [ ] Missing lock timeouts

## Thread Safety

### Unsafe Singleton Patterns
- [ ] Double-checked locking issues
- [ ] Lazy initialization without synchronization
- [ ] Mutable singletons

### Shared State Issues
- [ ] Global variables modified concurrently
- [ ] Static mutable fields
- [ ] Non-thread-safe collections used concurrently

## Async/Await Issues

### Blocking in Async Context
- [ ] Blocking calls in async functions
- [ ] Thread.sleep in async code
- [ ] Synchronous I/O in event loop

### Missing Await
- [ ] Forgetting await on async calls
- [ ] Unhandled promise results
- [ ] Fire-and-forget patterns

## Database Concurrency

### Transaction Issues
- [ ] Missing transactions for multi-operation updates
- [ ] Long-running transactions
- [ ] Incorrect isolation levels
- [ ] Lost updates due to missing optimistic locking

### Connection Pool Issues
- [ ] Connection leaks
- [ ] Exhausted connection pools
- [ ] Missing connection timeouts

## Distributed Systems

### Distributed Race Conditions
- [ ] Missing distributed locks
- [ ] Inconsistent caching
- [ ] Eventual consistency not handled

### Message Ordering
- [ ] Assumptions about message order
- [ ] Missing idempotency
- [ ] Duplicate message handling

## Performance Impact

- [ ] Lock contention hotspots
- [ ] Unnecessary synchronization
- [ ] Blocking operations in hot paths
- [ ] Thread pool exhaustion
