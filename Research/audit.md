# Audit: swift-numerics

## Legacy — Consolidated 2026-04-08

### From: swift-institute/Research/platform-compliance-audit.md (2026-03-19)

**Skill**: platform — [PLAT-ARCH-001-010], [PATTERN-001], [PATTERN-004a], [PATTERN-005]

| # | Severity | Rule | Location | Finding | Status |
|---|----------|------|----------|---------|--------|
| H-45 | HIGH | [PLAT-ARCH-008] | Numeric.Math.SignGamma.swift:9,27 | `#if canImport(Darwin) || canImport(Glibc) || canImport(Musl)` guards on pure arithmetic. Fix: Investigate whether guards are necessary; remove if pure arithmetic. If depends on `lgamma`, gate only the lgamma-dependent path. | OPEN — Phase 1 quick win |
