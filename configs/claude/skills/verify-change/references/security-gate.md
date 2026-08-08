# Cybersecurity gate

Apply checks proportionally to the changed attack surface. Use repository-native scanners and policies first. Do not install tools or perform intrusive testing without authorization.

## Blocking findings

Stop verification immediately for credible evidence of:

- committed credentials, private keys, session tokens, personal data, or secrets in logs;
- authentication or authorization bypass;
- cross-tenant or cross-user data access;
- injection into SQL, shell, templates, interpreters, headers, or paths;
- unsafe deserialization, arbitrary code execution, or unrestricted file access;
- server-side request forgery through user-controlled destinations;
- disabled certificate validation or cleartext transport for sensitive data;
- permissive access, debug mode, or insecure defaults exposed beyond local development;
- destructive production behavior without confirmation, rollback, or containment;
- a known critical dependency issue confirmed by the repository's vulnerability tooling.

Report the file and line, trust boundary, attacker-controlled input, reachable sink, impact, and redacted evidence. Separate confirmed exploit paths from hypotheses.

## Changed-surface checks

### Input and output

- Validate untrusted data at the boundary.
- Encode output for its destination.
- Bound sizes, recursion, retries, pagination, and resource use.
- Avoid leaking internals, credentials, or personal data in errors and logs.

### Identity and access

- Authenticate before protected operations.
- Authorize the specific action and resource.
- Verify ownership and tenant isolation server-side.
- Prefer least privilege and deny-by-default behavior.

### Data and secrets

- Keep secrets in approved secret stores or environment variables.
- Encrypt sensitive transport and follow repository rules for storage.
- Use synthetic or sanitized test data.
- Verify cleanup and retention behavior where relevant.

### Dependencies and configuration

- Review why a new dependency is needed, its lockfile change, maintenance, license, and audit result when tooling exists.
- Inspect package provenance, maintainer or ownership changes, typosquatting risk, transitive additions, lifecycle scripts, and unexpected binary artifacts.
- Prefer repository-pinned scanners and verified registries. Do not install a new scanner merely to complete this gate without user authorization.
- Verify production configuration does not inherit development shortcuts.
- Check CORS, cookies, headers, redirects, webhooks, and network allowlists when changed.

### Operations

- Make migrations and destructive actions reversible or guarded.
- Avoid production endpoints in tests.
- Confirm rate limits, timeouts, retries, idempotency, and replay protection where applicable.

Finish the gate when every changed trust boundary has been inspected and each suspected blocker is either demonstrated or dismissed with evidence.
