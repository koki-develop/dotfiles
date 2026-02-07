# Performance Checklist

## N+1 Query Problems

### Database N+1
- [ ] Queries in loops
- [ ] Missing eager loading/joins
- [ ] Lazy loading in iterations

### API N+1
- [ ] HTTP calls in loops
- [ ] Sequential API calls that could be batched

## Inefficient Data Access

### Missing Indexes
- [ ] Queries on unindexed columns
- [ ] Full table scans
- [ ] Missing composite indexes for common queries

### Over-fetching
- [ ] SELECT * instead of specific columns
- [ ] Loading entire objects when partial data needed
- [ ] Missing pagination

### Under-fetching
- [ ] Multiple queries when one would suffice
- [ ] Missing data preloading

## Memory Issues

### Memory Leaks
- [ ] Unbounded caches
- [ ] Event listener accumulation
- [ ] Closure references preventing GC
- [ ] Large objects in long-lived scopes

### Inefficient Memory Usage
- [ ] Loading large files into memory
- [ ] String concatenation in loops
- [ ] Unnecessary object creation in hot paths

## Algorithm Complexity

### O(n^2) or Worse
- [ ] Nested loops on large collections
- [ ] Repeated linear searches
- [ ] Sorting in loops

### Suboptimal Data Structures
- [ ] Linear search when hash lookup possible
- [ ] Array when Set/Map appropriate
- [ ] Repeated operations on unsorted data

## Network Performance

### Unnecessary Requests
- [ ] Missing caching
- [ ] Duplicate requests
- [ ] Polling when push available

### Large Payloads
- [ ] Uncompressed responses
- [ ] Over-fetched data
- [ ] Missing pagination
- [ ] Large base64 encoded data

## Blocking Operations

### Main Thread Blocking
- [ ] Synchronous I/O on main thread
- [ ] Heavy computation without offloading
- [ ] Blocking database calls in request handlers

### Missing Async
- [ ] Sequential operations that could be parallel
- [ ] Missing Promise.all for independent operations

## Caching Issues

### Missing Cache
- [ ] Repeated expensive computations
- [ ] Repeated identical database queries
- [ ] No HTTP caching headers

### Cache Invalidation
- [ ] Stale cache without TTL
- [ ] Missing cache invalidation on updates
- [ ] Inconsistent cache state

## Resource Management

### Connection Pooling
- [ ] Creating connections per request
- [ ] Missing connection reuse
- [ ] Pool size misconfiguration

### File Handling
- [ ] Not using streaming for large files
- [ ] Holding file handles open
- [ ] Reading entire files when streaming possible
