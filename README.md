# cobol-swift-processor

This project is a hands-on SWIFT MT103 payment processor built in COBOL and packaged with Docker from day one.

The idea is to model a realistic bank processing flow: parse MT103 messages, validate fields, route approved payments, and generate daily operational reports. COBOL stays at the core, while containerization keeps the runtime predictable across machines and CI.

## Why this project

- Practice real payment-message processing, not toy COBOL examples
- Build a clean, incremental architecture that can later sit behind an API
- Keep modernisation practical: containerise the COBOL runtime instead of rewriting everything

## Current status

Implemented so far:

- `IBAN-CHECK.cob` with normalisation, country checks, length checks, and mod-97 checksum validation
- `IBAN-CHECK-HARNESS.cob` for repeatable regression testing
- IBAN test dataset covering valid, invalid, and edge-style cases
- Docker + GitHub Actions baseline so builds and checks run consistently

## Roadmap

### 1) IBAN foundation (in progress)

- [x] Build IBAN checker skeleton
- [x] Add executable harness
- [x] Add checksum and country-aware rules
- [ ] Add stricter country-specific BBAN format rules

### 2) MT103 parser

- [ ] Read batch files with multiple messages
- [ ] Extract key SWIFT tags into a shared record layout
- [ ] Write parsed output for downstream validation

### 3) MT103 validator

- [ ] Enforce mandatory-field and format rules
- [ ] Attach clear rejection codes (`AC01`, `DT01`, `MS02`, etc.)
- [ ] Split approved vs rejected queues

### 4) Routing engine

- [ ] Load BIC routing table
- [ ] Classify transfer as internal, correspondent, or nostro
- [ ] Maintain per-currency net position file

### 5) Reporting

- [ ] Generate daily summary report
- [ ] Generate rejection report
- [ ] Generate nostro/manual-review report
- [ ] Produce settlement-ready position output

### 6) API wrapper (later phase)

- [ ] Add FastAPI wrapper in front of the COBOL pipeline
- [ ] Accept raw MT103 payload, trigger processing, return structured JSON result

## Run

```bash
docker compose run --rm processor
```

This command builds COBOL programs and runs the current harness through `scripts/run-processor.sh`.
