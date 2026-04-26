// Numeric.Math.LogGamma.swift
// swift-numerics
//
// Log-of-absolute-value-of-gamma function (lgamma) implementation.
//
// Per /platform [PLAT-ARCH-008c] / [PRIM-FOUND-001/002] strict-L1 directive
// (2026-04-26): L1 numeric-primitives must not bind libm. lgamma's
// implementation lives at L3 here, backed by L2 swift-iso-9899's existing
// libm bindings. Public API surface (`Double.math.lgamma(x)` etc.) is
// preserved via the @_exported re-export chain — consumers `import Numerics`
// to reach this Accessor extension.
//
// Float16: forwarded through Float (Float16 isn't in iso-9899's libm
// surface; the same Float-promotion pattern numeric-primitives previously
// used in its _Shims `Float16(shim_expf(Float(x)))` form).

public import Numeric_Primitives_Core
public import Real_Primitives
public import ISO_9899_Core

extension Numeric.Math.Accessor where T == Double {
    /// Natural logarithm of the absolute value of the gamma function.
    ///
    /// Implementation backed by `ISO_9899.Math.lgamma` (POSIX `lgamma_r`).
    @inlinable
    public func lgamma(_ x: Double) -> Double { ISO_9899.Math.lgamma(x) }

    /// Natural logarithm of the absolute value of the gamma function.
    ///
    /// Spelling alias for ``lgamma(_:)``.
    @inlinable
    public func logGamma(_ x: Double) -> Double { ISO_9899.Math.lgamma(x) }
}

extension Numeric.Math.Accessor where T == Float {
    /// Natural logarithm of the absolute value of the gamma function.
    ///
    /// Implementation backed by `ISO_9899.Math.lgamma` (POSIX `lgammaf_r`).
    @inlinable
    public func lgamma(_ x: Float) -> Float { ISO_9899.Math.lgamma(x) }

    /// Natural logarithm of the absolute value of the gamma function.
    ///
    /// Spelling alias for ``lgamma(_:)``.
    @inlinable
    public func logGamma(_ x: Float) -> Float { ISO_9899.Math.lgamma(x) }
}

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS) || ((os(macOS) || targetEnvironment(macCatalyst)) && arch(arm64))
extension Numeric.Math.Accessor where T == Float16 {
    /// Natural logarithm of the absolute value of the gamma function.
    ///
    /// Implementation forwards through `Float` since iso-9899's libm surface
    /// does not include a Float16 variant. Float16 itself is hardware-bound
    /// (gated by the `arch(arm64)` conditional matching numeric-primitives'
    /// existing Float16 transcendental conformance per audit item 17).
    @inlinable
    public func lgamma(_ x: Float16) -> Float16 { Float16(ISO_9899.Math.lgamma(Float(x))) }

    /// Natural logarithm of the absolute value of the gamma function.
    ///
    /// Spelling alias for ``lgamma(_:)``.
    @inlinable
    public func logGamma(_ x: Float16) -> Float16 { Float16(ISO_9899.Math.lgamma(Float(x))) }
}
#endif
