# Configuration Checklist

## Secrets Management

### Hardcoded Secrets
- [ ] API keys in code
- [ ] Passwords in configuration files
- [ ] Connection strings with credentials
- [ ] Private keys in repository

### Committed Secrets
- [ ] .env files in repository
- [ ] Credentials in git history
- [ ] Secrets in CI/CD logs

**How to check:**
```bash
git log -p | grep -i password
git secrets --scan
trufflehog filesystem .
```

### Secret Rotation
- [ ] Long-lived static secrets
- [ ] No rotation mechanism
- [ ] Shared secrets across environments

## Environment Configuration

### Environment Separation
- [ ] Production config in development
- [ ] Shared credentials across environments
- [ ] Missing environment validation

### Missing Configurations
- [ ] Required env vars not documented
- [ ] No .env.example file
- [ ] Missing default values

### Configuration Validation
- [ ] No startup validation
- [ ] Invalid configs not caught early
- [ ] Missing required field checks

## Default Values

### Insecure Defaults
- [ ] Debug mode enabled by default
- [ ] Permissive CORS by default
- [ ] Weak security settings as default

### Missing Defaults
- [ ] Timeouts without defaults
- [ ] Retry counts without limits
- [ ] Buffer sizes unbounded

## Feature Flags

### Stale Flags
- [ ] Old feature flags never removed
- [ ] Flags for completed features
- [ ] Dead code behind flags

### Flag Management
- [ ] Flags in code instead of config
- [ ] No flag documentation
- [ ] Inconsistent flag naming

## Logging Configuration

### Log Level Issues
- [ ] Debug logging in production
- [ ] Insufficient error logging
- [ ] Sensitive data in logs

### Log Management
- [ ] No log rotation
- [ ] Unbounded log files
- [ ] Missing structured logging

## Infrastructure Configuration

### Database Configuration
- [ ] Connection pool sizing
- [ ] Timeout configurations
- [ ] Retry policies

### Cache Configuration
- [ ] TTL settings
- [ ] Cache size limits
- [ ] Eviction policies

### Network Configuration
- [ ] Request timeouts
- [ ] Connection limits
- [ ] Retry configurations

## CI/CD Configuration

### Pipeline Security
- [ ] Secrets in CI configuration
- [ ] Overly permissive permissions
- [ ] Missing security scans

### Build Configuration
- [ ] Inconsistent build settings
- [ ] Missing production optimizations
- [ ] Debug artifacts in release

## Runtime Configuration

### Resource Limits
- [ ] Missing memory limits
- [ ] Missing CPU limits
- [ ] Missing connection limits

### Health Checks
- [ ] Missing liveness probes
- [ ] Missing readiness probes
- [ ] Incorrect health check endpoints

## Configuration Storage

### Configuration Format
- [ ] Inconsistent formats (YAML/JSON/ENV)
- [ ] Complex nested configurations
- [ ] Missing configuration schema

### Configuration Access
- [ ] Configuration loaded multiple times
- [ ] Missing configuration caching
- [ ] Runtime configuration changes
