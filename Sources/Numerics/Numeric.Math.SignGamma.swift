// Numeric.Math.SignGamma.swift
// swift-numerics
//
// Sign of gamma function implementation

import Real_Primitives

extension Numeric.Math.Accessor where T == Double {
    /// Sign of gamma function.
    ///
    /// Returns the sign of Gamma(x):
    /// - For x >= 0: always positive
    /// - For negative non-integers: alternates based on floor(x)
    /// - At negative integers (poles): returns positive by convention
    /// - For NaN: returns positive by convention
    /// - For -infinity: returns positive by convention (pole-like)
    @inlinable
    public func signGamma(_ x: Double) -> FloatingPointSign {
        if x.isNaN { return .plus }
        if x >= 0 { return .plus }
        let truncated = x.rounded(.towardZero)
        if truncated == x { return .plus }
        return truncated.truncatingRemainder(dividingBy: 2) == 0 ? .minus : .plus
    }
}

extension Numeric.Math.Accessor where T == Float {
    /// Sign of gamma function.
    ///
    /// Returns the sign of Gamma(x):
    /// - For x >= 0: always positive
    /// - For negative non-integers: alternates based on floor(x)
    /// - At negative integers (poles): returns positive by convention
    /// - For NaN: returns positive by convention
    /// - For -infinity: returns positive by convention (pole-like)
    @inlinable
    public func signGamma(_ x: Float) -> FloatingPointSign {
        if x.isNaN { return .plus }
        if x >= 0 { return .plus }
        let truncated = x.rounded(.towardZero)
        if truncated == x { return .plus }
        return truncated.truncatingRemainder(dividingBy: 2) == 0 ? .minus : .plus
    }
}
