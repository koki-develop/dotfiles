# Error Handling Checklist

## Empty/Silent Error Handling

### Empty Catch Blocks
- [ ] `catch` blocks that swallow exceptions
- [ ] `except: pass` patterns
- [ ] Silent failures that hide bugs
- [ ] Missing error logging

### Inappropriate Error Suppression
- [ ] Catching generic exceptions (Exception, Error)
- [ ] Try-catch around entire functions
- [ ] Overly broad error handling

## Improper Error Propagation

### Lost Error Context
- [ ] Re-throwing without original error
- [ ] Converting errors to generic messages
- [ ] Logging without preserving stack trace

### Inconsistent Error Types
- [ ] Mixed error handling strategies
- [ ] Inconsistent error response formats
- [ ] Undefined/null returns instead of errors

## Missing Error Handling

### Unhandled Promises
- [ ] Async functions without try-catch
- [ ] Missing `.catch()` on promises
- [ ] Fire-and-forget async calls
- [ ] Unhandled promise rejections

### Unchecked Operations
- [ ] File operations without error handling
- [ ] Network calls without timeout/retry
- [ ] Database operations without transaction handling
- [ ] JSON parsing without try-catch

## Resource Cleanup

### Missing Finally/Cleanup
- [ ] Resources not released on error
- [ ] Missing `finally` blocks for cleanup
- [ ] Database connections not closed
- [ ] File handles left open

### Memory Leaks
- [ ] Event listeners not removed
- [ ] Subscriptions not unsubscribed
- [ ] Timers not cleared

## Error Reporting

### Insufficient Logging
- [ ] Errors caught but not logged
- [ ] Missing error context in logs
- [ ] No correlation IDs for tracing

### Excessive Error Exposure
- [ ] Stack traces in API responses
- [ ] Internal error details exposed to users
- [ ] Debug information in production

## Graceful Degradation

- [ ] Missing fallback mechanisms
- [ ] No circuit breaker patterns
- [ ] Hard failures instead of graceful degradation
- [ ] Missing retry logic for transient failures
