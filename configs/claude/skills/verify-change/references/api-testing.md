# External API testing

Test the adapter through its public interface. Keep automated tests deterministic, isolated, and free of production credentials.

## Required coverage

- Assert method, URL construction, headers, authentication placement, parameters, and serialized body.
- Use synthetic fixture responses for success, validation errors, authentication errors, rate limits, timeouts, malformed payloads, and upstream failures relevant to the change.
- Verify response parsing, schema validation, error mapping, retries, backoff, pagination, and idempotency when implemented.
- Assert secrets and sensitive payloads are absent from logs and raised errors.
- Add a regression fixture for the reported upstream behavior when fixing an integration bug.

## Test doubles

Prefer, in order:

1. an in-process fake implementing the external contract;
2. an HTTP stub or mock server at the network boundary;
3. sanitized recorded fixtures with volatile and sensitive fields removed;
4. a provider sandbox or dedicated test account for explicit contract or end-to-end tests.

Mock the external boundary, not internal business logic. Keep fixture data minimal and name it after the behavior it proves.

## Live calls

Run live integration tests only when the user authorizes them and a non-production environment, test credentials, cost limits, cleanup, and rate-limit safeguards are confirmed. Mark skipped live checks as `Unverified`; do not replace them with an assumption.
