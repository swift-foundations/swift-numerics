// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-primitives
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import Testing

@testable import Numerics

@Suite
struct `Elementary Tests` {

    // MARK: - Exponential Functions

    @Test
    func exp() {
        let result = Double.math.exp(1.0)
        // e ≈ 2.71828...
        #expect(result.equals.approximate(2.718281828459045, tolerance: 1e-10))
    }

    // MARK: - Logarithmic Functions

    @Test
    func log() {
        let e = Double.math.exp(1.0)
        let result = Double.math.log(e)
        #expect(result.equals.approximate(1.0, tolerance: 1e-10))
    }

    // MARK: - Trigonometric Functions

    @Test
    func `sin And Cos`() {
        let angle = Double.pi / 4
        let s = Double.math.sin(angle)
        let c = Double.math.cos(angle)

        // sin(π/4) = cos(π/4) = √2/2
        let expected = Double.math.sqrt(2.0) / 2
        #expect(s.equals.approximate(expected, tolerance: 1e-10))
        #expect(c.equals.approximate(expected, tolerance: 1e-10))

        // sin²(x) + cos²(x) = 1
        #expect((s * s + c * c).equals.approximate(1.0, tolerance: 1e-10))
    }

    @Test
    func atan2() {
        // atan2(1, 1) = π/4
        let result = Double.math.atan2(1.0, 1.0)
        #expect(result.equals.approximate(Double.pi / 4, tolerance: 1e-10))

        // atan2(0, 1) = 0
        let zero = Double.math.atan2(0.0, 1.0)
        #expect(zero.equals.approximate(0.0, tolerance: 1e-15))
    }

    // MARK: - Hyperbolic Functions

    @Test
    func hyperbolic() {
        let x = 1.0
        let s = Double.math.sinh(x)
        let c = Double.math.cosh(x)

        // cosh²(x) - sinh²(x) = 1
        #expect((c * c - s * s).equals.approximate(1.0, tolerance: 1e-10))
    }

    // MARK: - Power Functions

    @Test
    func pow() {
        let result = Double.math.pow(2.0, 3.0)
        #expect(result.equals.approximate(8.0, tolerance: 1e-10))
    }

    @Test
    func sqrt() {
        let result = Double.math.sqrt(4.0)
        #expect(result.equals.approximate(2.0, tolerance: 1e-15))
    }

    @Test
    func hypot() {
        // 3² + 4² = 5²
        let result = Double.math.hypot(3.0, 4.0)
        #expect(result.equals.approximate(5.0, tolerance: 1e-10))
    }

    // MARK: - Root Functions

    @Test
    func `root Square`() {
        // √4 = 2
        let result = Double.math.root(4.0, 2)
        #expect(result.equals.approximate(2.0, tolerance: 1e-10))

        // √9 = 3
        let result2 = Double.math.root(9.0, 2)
        #expect(result2.equals.approximate(3.0, tolerance: 1e-10))
    }

    @Test
    func `root Cube`() {
        // ∛8 = 2
        let result = Double.math.root(8.0, 3)
        #expect(result.equals.approximate(2.0, tolerance: 1e-10))

        // ∛27 = 3
        let result2 = Double.math.root(27.0, 3)
        #expect(result2.equals.approximate(3.0, tolerance: 1e-10))

        // ∛(-8) = -2 (real cube root of negative)
        let negResult = Double.math.root(-8.0, 3)
        #expect(negResult.equals.approximate(-2.0, tolerance: 1e-10))
    }

    @Test
    func `root Fourth`() {
        // ⁴√16 = 2
        let result = Double.math.root(16.0, 4)
        #expect(result.equals.approximate(2.0, tolerance: 1e-10))

        // ⁴√81 = 3
        let result2 = Double.math.root(81.0, 4)
        #expect(result2.equals.approximate(3.0, tolerance: 1e-10))
    }

    @Test
    func `root Negative Even`() {
        // Even root of negative number is NaN
        let result = Double.math.root(-4.0, 2)
        #expect(result.isNaN)

        let result2 = Double.math.root(-16.0, 4)
        #expect(result2.isNaN)
    }

    @Test
    func `root Negative Odd`() {
        // Odd roots of negative numbers are real
        let result = Double.math.root(-27.0, 3)
        #expect(result.equals.approximate(-3.0, tolerance: 1e-10))

        let result2 = Double.math.root(-32.0, 5)
        #expect(result2.equals.approximate(-2.0, tolerance: 1e-10))
    }

    @Test
    func `root Float`() {
        // Test Float variant
        let result: Float = Float.math.root(8.0, 3)
        #expect(result.equals.approximate(2.0, tolerance: 1e-5))

        let negResult: Float = Float.math.root(-8.0, 3)
        #expect(negResult.equals.approximate(-2.0, tolerance: 1e-5))
    }

    // MARK: - Gamma Functions

    #if canImport(Darwin) || canImport(Glibc) || canImport(Musl)
        @Test
        func `log Gamma Positive`() {
            // logGamma(1) = log(0!) = log(1) = 0
            let result = Double.math.logGamma(1.0)
            #expect(result.equals.approximate(0.0, tolerance: 1e-10))

            // logGamma(2) = log(1!) = log(1) = 0
            let result2 = Double.math.logGamma(2.0)
            #expect(result2.equals.approximate(0.0, tolerance: 1e-10))

            // logGamma(3) = log(2!) = log(2) ≈ 0.693
            let result3 = Double.math.logGamma(3.0)
            #expect(result3.equals.approximate(Double.math.log(2.0), tolerance: 1e-10))

            // logGamma(4) = log(3!) = log(6) ≈ 1.791
            let result4 = Double.math.logGamma(4.0)
            #expect(result4.equals.approximate(Double.math.log(6.0), tolerance: 1e-10))
        }

        @Test
        func `log Gamma Float`() {
            // Test Float variant
            let result: Float = Float.math.logGamma(3.0)
            #expect(result.equals.approximate(Float.math.log(2.0), tolerance: 1e-5))
        }

        @Test
        func `sign Gamma Positive`() {
            // Gamma is positive for all x >= 0
            #expect(Double.math.signGamma(1.0) == .plus)
            #expect(Double.math.signGamma(2.5) == .plus)
            #expect(Double.math.signGamma(0.5) == .plus)
            #expect(Double.math.signGamma(100.0) == .plus)
        }

        @Test
        func `sign Gamma Negative Integers`() {
            // At negative integers (poles), we assign .plus
            #expect(Double.math.signGamma(-1.0) == .plus)
            #expect(Double.math.signGamma(-2.0) == .plus)
            #expect(Double.math.signGamma(-3.0) == .plus)
        }

        @Test
        func `sign Gamma Negative Non Integers`() {
            // Between -1 and 0: trunc = 0 (even) → minus
            #expect(Double.math.signGamma(-0.5) == .minus)

            // Between -2 and -1: trunc = -1 (odd) → plus
            #expect(Double.math.signGamma(-1.5) == .plus)

            // Between -3 and -2: trunc = -2 (even) → minus
            #expect(Double.math.signGamma(-2.5) == .minus)

            // Between -4 and -3: trunc = -3 (odd) → plus
            #expect(Double.math.signGamma(-3.5) == .plus)
        }

        @Test
        func `log Gamma And Sign Gamma Consistency`() {
            // For positive values, exp(logGamma(x)) should equal |tgamma(x)|
            let x = 3.5
            let logG = Double.math.logGamma(x)
            let gamma = Double.math.tgamma(x)
            #expect(Double.math.exp(logG).equals.approximate(gamma.magnitude, tolerance: 1e-10))

            // Sign should match
            #expect(Double.math.signGamma(x) == (gamma >= 0 ? .plus : .minus))
        }
    #endif
}
