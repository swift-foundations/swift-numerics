# swift-numerics

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

A unified numerics import for Swift — one `import Numerics` provides elementary functions on the `math` accessor, IEEE 754 binary serialization, integer utilities, and the gamma-function surface.

---

## Quick Start

```swift
import Numerics

// 171! overflows Double, but its logarithm is representable:
let logFactorial = Double.math.logGamma(172.0)   // log(171!) ≈ 711.71

// The sign Gamma(x) would have had — recoverable even where
// the magnitude only exists in log space:
let sign = Double.math.signGamma(-2.5)           // .minus

// Odd roots of negative numbers stay real, where pow(-27, 1/3) is NaN:
let edge = Double.math.root(-27.0, 3)            // -3.0
```

The `math` accessor namespaces the full elementary-function surface on the floating-point types themselves — `Double.math.sin(_:)`, `Float.math.hypot(_:_:)`, `Double.math.atan2(_:_:)` — with no free-function namespace pollution and no direct `Darwin`/`Glibc` import in consumer code.

---

## Installation

Add swift-numerics to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-foundations/swift-numerics.git", branch: "main")
]
```

Add the product to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Numerics", package: "swift-numerics")
    ]
)
```

### Requirements

- Swift 6.3+
- macOS 26+, iOS 26+, tvOS 26+, watchOS 26+, visionOS 26+

---

## Architecture

`Numerics` is a single-product umbrella: it re-exports four modules and adds the gamma functions on top.

| Module (re-exported) | Provides |
|----------------------|----------|
| `Numeric_Primitives` | The `Numeric` namespace: `math` accessor, integer `gcd`/`lcm`/rounded division, compensated arithmetic, sign/ternary classification |
| `Real_Primitives` | Elementary functions over `Double`, `Float`, and `Float16` (exp, log, trigonometric, hyperbolic, pow, root, hypot) |
| `Integer_Primitives` | Integer operation surface backing the `Numeric` namespace |
| `IEEE_754` | IEEE 754-2019 binary interchange serialization for `Float` and `Double` |

Implemented in this package directly:

| API | Notes |
|-----|-------|
| `Double.math.lgamma(_:)` / `.logGamma(_:)` | Natural log of \|Gamma(x)\|, backed by ISO 9899 `libm` bindings (`lgamma_r`) |
| `Float.math.lgamma(_:)` / `.logGamma(_:)` | `lgammaf_r`-backed |
| `Float16.math.lgamma(_:)` / `.logGamma(_:)` | Forwarded through `Float`; available on arm64 Apple platforms |
| `Double.math.signGamma(_:)` / `Float.math.signGamma(_:)` | Sign of Gamma(x) as `FloatingPointSign`; positive by convention at the poles |

The gamma functions live here rather than in the primitives because their implementation binds the platform `libm` (via [swift-iso-9899](https://github.com/swift-iso/swift-iso-9899)), which the primitives layer deliberately avoids.

---

## Related Packages

### Dependencies

- [swift-numeric-primitives](https://github.com/swift-primitives/swift-numeric-primitives) — Numeric building blocks: `math` accessor, integer utilities, compensated arithmetic.
- [swift-ieee-754](https://github.com/swift-ieee/swift-ieee-754) — IEEE 754-2019 binary interchange serialization.
- [swift-iso-9899](https://github.com/swift-iso/swift-iso-9899) — C standard library bindings; supplies the `libm` gamma implementations (not re-exported).

---

## Community

<!-- BEGIN: discussion -->
*Discussion thread will be created at first public flip.*
<!-- END: discussion -->

---

## License

Apache 2.0 — see [LICENSE](LICENSE.md) for details.
