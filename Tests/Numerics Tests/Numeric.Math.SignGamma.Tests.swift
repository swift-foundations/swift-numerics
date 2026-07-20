// Numeric.Math.SignGamma.Tests.swift
// swift-numerics
//
// Regression tests for signGamma edge cases (fable-448 F-001).
// Generic-namespace source (Numeric.Math.Accessor<T>): top-level @Suite carve-out.

import Testing

@testable import Numerics

@Suite("Numeric.Math.SignGamma Edge Case")
struct Tests {

    @Test
    func `sign Gamma Double NaN returns plus without trapping`() {
        #expect(Double.math.signGamma(.nan) == .plus)
    }

    @Test
    func `sign Gamma Double negative infinity returns plus without trapping`() {
        #expect(Double.math.signGamma(-.infinity) == .plus)
    }

    @Test
    func `sign Gamma Double positive infinity returns plus`() {
        #expect(Double.math.signGamma(.infinity) == .plus)
    }

    @Test
    func `sign Gamma Double negative zero returns plus`() {
        #expect(Double.math.signGamma(-0.0) == .plus)
    }

    @Test
    func `sign Gamma Double magnitude beyond Int range returns plus without trapping`() {
        // Every Double with magnitude >= 2^53 is integral, so poles convention applies.
        #expect(Double.math.signGamma(-1e300) == .plus)
        #expect(Double.math.signGamma(-9.3e18) == .plus)
    }

    @Test
    func `sign Gamma Double non integer parity preserved`() {
        #expect(Double.math.signGamma(-0.5) == .minus)
        #expect(Double.math.signGamma(-1.5) == .plus)
        #expect(Double.math.signGamma(-2.5) == .minus)
        #expect(Double.math.signGamma(-3.5) == .plus)
    }

    @Test
    func `sign Gamma Float NaN returns plus without trapping`() {
        #expect(Float.math.signGamma(.nan) == .plus)
    }

    @Test
    func `sign Gamma Float negative infinity returns plus without trapping`() {
        #expect(Float.math.signGamma(-.infinity) == .plus)
    }

    @Test
    func `sign Gamma Float negative zero returns plus`() {
        #expect(Float.math.signGamma(-0.0) == .plus)
    }

    @Test
    func `sign Gamma Float magnitude beyond Int range returns plus without trapping`() {
        // Every Float with magnitude >= 2^24 is integral, so poles convention applies.
        #expect(Float.math.signGamma(-1e30) == .plus)
        #expect(Float.math.signGamma(-9.3e18) == .plus)
    }

    @Test
    func `sign Gamma Float non integer parity preserved`() {
        #expect(Float.math.signGamma(-0.5) == .minus)
        #expect(Float.math.signGamma(-1.5) == .plus)
        #expect(Float.math.signGamma(-2.5) == .minus)
    }
}
