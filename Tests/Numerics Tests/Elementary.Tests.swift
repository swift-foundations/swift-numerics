import Testing

@testable import Numerics

@Suite
struct `Elementary Tests` {

    @Test
    func `Exp`() {
        let result = Double.math.exp(1.0)

        #expect(result.equals.approximate(2.718281828459045, tolerance: 1e-10))
    }

    @Test
    func `Log`() {
        let e = Double.math.exp(1.0)
        let result = Double.math.log(e)
        #expect(result.equals.approximate(1.0, tolerance: 1e-10))
    }

    @Test
    func `sin And Cos`() {
        let angle = Double.pi / 4
        let s = Double.math.sin(angle)
        let c = Double.math.cos(angle)

        let expected = Double.math.sqrt(2.0) / 2
        #expect(s.equals.approximate(expected, tolerance: 1e-10))
        #expect(c.equals.approximate(expected, tolerance: 1e-10))

        #expect((s * s + c * c).equals.approximate(1.0, tolerance: 1e-10))
    }

    @Test
    func `Atan2`() {

        let result = Double.math.atan2(1.0, 1.0)
        #expect(result.equals.approximate(Double.pi / 4, tolerance: 1e-10))

        let zero = Double.math.atan2(0.0, 1.0)
        #expect(zero.equals.approximate(0.0, tolerance: 1e-15))
    }

    @Test
    func `Hyperbolic`() {
        let x = 1.0
        let s = Double.math.sinh(x)
        let c = Double.math.cosh(x)

        #expect((c * c - s * s).equals.approximate(1.0, tolerance: 1e-10))
    }

    @Test
    func `Pow`() {
        let result = Double.math.pow(2.0, 3.0)
        #expect(result.equals.approximate(8.0, tolerance: 1e-10))
    }

    @Test
    func `Sqrt`() {
        let result = Double.math.sqrt(4.0)
        #expect(result.equals.approximate(2.0, tolerance: 1e-15))
    }

    @Test
    func `Hypot`() {

        let result = Double.math.hypot(3.0, 4.0)
        #expect(result.equals.approximate(5.0, tolerance: 1e-10))
    }

    @Test
    func `root Square`() {

        let result = Double.math.root(4.0, 2)
        #expect(result.equals.approximate(2.0, tolerance: 1e-10))

        let result2 = Double.math.root(9.0, 2)
        #expect(result2.equals.approximate(3.0, tolerance: 1e-10))
    }

    @Test
    func `root Cube`() {

        let result = Double.math.root(8.0, 3)
        #expect(result.equals.approximate(2.0, tolerance: 1e-10))

        let result2 = Double.math.root(27.0, 3)
        #expect(result2.equals.approximate(3.0, tolerance: 1e-10))

        let negResult = Double.math.root(-8.0, 3)
        #expect(negResult.equals.approximate(-2.0, tolerance: 1e-10))
    }

    @Test
    func `root Fourth`() {

        let result = Double.math.root(16.0, 4)
        #expect(result.equals.approximate(2.0, tolerance: 1e-10))

        let result2 = Double.math.root(81.0, 4)
        #expect(result2.equals.approximate(3.0, tolerance: 1e-10))
    }

    @Test
    func `root Negative Even`() {

        let result = Double.math.root(-4.0, 2)
        #expect(result.isNaN)

        let result2 = Double.math.root(-16.0, 4)
        #expect(result2.isNaN)
    }

    @Test
    func `root Negative Odd`() {

        let result = Double.math.root(-27.0, 3)
        #expect(result.equals.approximate(-3.0, tolerance: 1e-10))

        let result2 = Double.math.root(-32.0, 5)
        #expect(result2.equals.approximate(-2.0, tolerance: 1e-10))
    }

    @Test
    func `root Float`() {

        let result: Float = Float.math.root(8.0, 3)
        #expect(result.equals.approximate(2.0, tolerance: 1e-5))

        let negResult: Float = Float.math.root(-8.0, 3)
        #expect(negResult.equals.approximate(-2.0, tolerance: 1e-5))
    }

    #if canImport(Darwin) || canImport(Glibc) || canImport(Musl)
        @Test
        func `log Gamma Positive`() {

            let result = Double.math.logGamma(1.0)
            #expect(result.equals.approximate(0.0, tolerance: 1e-10))

            let result2 = Double.math.logGamma(2.0)
            #expect(result2.equals.approximate(0.0, tolerance: 1e-10))

            let result3 = Double.math.logGamma(3.0)
            #expect(result3.equals.approximate(Double.math.log(2.0), tolerance: 1e-10))

            let result4 = Double.math.logGamma(4.0)
            #expect(result4.equals.approximate(Double.math.log(6.0), tolerance: 1e-10))
        }

        @Test
        func `log Gamma Float`() {

            let result: Float = Float.math.logGamma(3.0)
            #expect(result.equals.approximate(Float.math.log(2.0), tolerance: 1e-5))
        }

        @Test
        func `sign Gamma Positive`() {

            #expect(Double.math.signGamma(1.0) == .plus)
            #expect(Double.math.signGamma(2.5) == .plus)
            #expect(Double.math.signGamma(0.5) == .plus)
            #expect(Double.math.signGamma(100.0) == .plus)
        }

        @Test
        func `sign Gamma Negative Integers`() {

            #expect(Double.math.signGamma(-1.0) == .plus)
            #expect(Double.math.signGamma(-2.0) == .plus)
            #expect(Double.math.signGamma(-3.0) == .plus)
        }

        @Test
        func `sign Gamma Negative Non Integers`() {

            #expect(Double.math.signGamma(-0.5) == .minus)

            #expect(Double.math.signGamma(-1.5) == .plus)

            #expect(Double.math.signGamma(-2.5) == .minus)

            #expect(Double.math.signGamma(-3.5) == .plus)
        }

        @Test
        func `log Gamma And Sign Gamma Consistency`() {

            let x = 3.5
            let logG = Double.math.logGamma(x)
            let gamma = Double.math.tgamma(x)
            #expect(Double.math.exp(logG).equals.approximate(gamma.magnitude, tolerance: 1e-10))

            #expect(Double.math.signGamma(x) == (gamma >= 0 ? .plus : .minus))
        }
    #endif
}
