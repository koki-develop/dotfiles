# Dependencies Checklist

## Vulnerability Assessment

### Known Vulnerabilities
- [ ] Dependencies with CVEs
- [ ] Dependencies with security advisories
- [ ] Transitive dependencies with vulnerabilities

**How to check:**
```bash
# Node.js
npm audit
yarn audit

# Python
pip-audit
safety check

# Ruby
bundle audit

# Go
govulncheck ./...

# General
snyk test
```

### Outdated Dependencies
- [ ] Major versions behind
- [ ] Missing security patches
- [ ] End-of-life versions

**How to check:**
```bash
npm outdated
pip list --outdated
bundle outdated
go list -m -u all
```

## Dependency Quality

### Abandoned Packages
- [ ] No updates in >1-2 years
- [ ] Deprecated packages
- [ ] Archived repositories

### Low Quality Indicators
- [ ] Very low download counts
- [ ] No/minimal documentation
- [ ] No tests
- [ ] Single maintainer packages

### Typosquatting Risk
- [ ] Packages with suspicious names
- [ ] Recently published with similar names

## Unnecessary Dependencies

### Bloat
- [ ] Large packages for simple tasks
- [ ] Multiple packages doing the same thing
- [ ] Dependencies not actually used

### Duplicate Functionality
- [ ] Multiple date libraries
- [ ] Multiple HTTP clients
- [ ] Multiple utility libraries

## Version Management

### Unpinned Versions
- [ ] Using `latest` or `*`
- [ ] Overly permissive version ranges
- [ ] Missing lockfile

### Lockfile Issues
- [ ] Missing package-lock.json/yarn.lock
- [ ] Outdated lockfile
- [ ] Inconsistent lockfile

## Transitive Dependencies

### Deep Dependency Trees
- [ ] Excessive transitive dependencies
- [ ] Conflicting transitive versions
- [ ] Unknown transitive dependencies

**How to check:**
```bash
npm ls --all
pip show --verbose package
bundle viz
```

## License Compliance

### License Issues
- [ ] Incompatible licenses (GPL in proprietary)
- [ ] Missing licenses
- [ ] License changes in updates

**How to check:**
```bash
license-checker
pip-licenses
bundle-licenses
```

## Security Practices

### Supply Chain Risks
- [ ] Dependencies from untrusted sources
- [ ] Missing integrity checks
- [ ] Install scripts with dangerous operations

### Dependency Confusion
- [ ] Private package names similar to public
- [ ] Missing scoped packages
- [ ] Incorrect registry configuration

## Build Dependencies

### Dev vs Production
- [ ] Dev dependencies in production
- [ ] Missing production dependencies
- [ ] Oversized production bundles

### Native Dependencies
- [ ] Platform-specific dependencies
- [ ] Native compilation requirements
- [ ] Binary dependencies without source

## Dependency Injection

### Hard Dependencies
- [ ] Direct imports without abstraction
- [ ] Missing dependency injection
- [ ] Tightly coupled external services

### Configuration
- [ ] Hardcoded dependency versions in code
- [ ] Missing centralized dependency management
- [ ] Inconsistent import patterns
