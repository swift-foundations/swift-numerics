import Real_Primitives

extension Numeric.Math.Accessor where T == Double {

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

    @inlinable
    public func signGamma(_ x: Float) -> FloatingPointSign {
        if x.isNaN { return .plus }
        if x >= 0 { return .plus }
        let truncated = x.rounded(.towardZero)
        if truncated == x { return .plus }
        return truncated.truncatingRemainder(dividingBy: 2) == 0 ? .minus : .plus
    }
}
