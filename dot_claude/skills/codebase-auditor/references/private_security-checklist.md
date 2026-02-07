# Security Checklist

## Injection Vulnerabilities

### SQL Injection
- [ ] String concatenation in SQL queries
- [ ] Unparameterized queries
- [ ] Dynamic table/column names from user input
- [ ] ORM raw query methods with user input

### Command Injection
- [ ] `os.system()`, `subprocess.call()` with shell=True
- [ ] `exec()`, `eval()` with user input
- [ ] Template injection in shell commands

### XSS (Cross-Site Scripting)
- [ ] Unescaped user input in HTML
- [ ] `dangerouslySetInnerHTML` without sanitization
- [ ] `innerHTML` assignments
- [ ] Template literals with user data

### Path Traversal
- [ ] User input in file paths without validation
- [ ] Missing path normalization
- [ ] Symlink following without checks

## Authentication & Authorization

### Authentication Flaws
- [ ] Weak password requirements
- [ ] Missing rate limiting on login
- [ ] Predictable session tokens
- [ ] Session fixation vulnerabilities
- [ ] Missing logout functionality
- [ ] Passwords in logs/responses

### Authorization Flaws
- [ ] Missing access control checks
- [ ] Insecure direct object references (IDOR)
- [ ] Privilege escalation paths
- [ ] Missing role validation

## Sensitive Data Exposure

### Hardcoded Secrets
- [ ] API keys, tokens, passwords in code
- [ ] Private keys in repository
- [ ] Connection strings with credentials

### Data Leakage
- [ ] Sensitive data in logs
- [ ] Stack traces in production
- [ ] Verbose error messages to users
- [ ] Debug endpoints in production

### Cryptography Issues
- [ ] Weak algorithms (MD5, SHA1 for passwords)
- [ ] Hardcoded IVs/salts
- [ ] Missing encryption for sensitive data
- [ ] Insecure random number generation

## Input Validation

- [ ] Missing input length limits
- [ ] No format validation
- [ ] Accepting any content type
- [ ] Missing schema validation

## Security Headers & Configuration

- [ ] Missing CORS configuration
- [ ] Permissive CORS (*)
- [ ] Missing security headers (CSP, X-Frame-Options, etc.)
- [ ] Debug mode in production
- [ ] Verbose logging of secrets

## Dependency Security

- [ ] Known vulnerable dependencies
- [ ] Outdated security patches
- [ ] Unnecessary dependencies with known issues
