public import ISO_9899_Core
public import Numeric_Primitives_Core
public import Real_Primitives

extension Numeric.Math.Accessor where T == Double {

    @inlinable
    public func lgamma(_ x: Double) -> Double { ISO_9899.Math.lgamma(x) }

    @inlinable
    public func logGamma(_ x: Double) -> Double { ISO_9899.Math.lgamma(x) }
}

extension Numeric.Math.Accessor where T == Float {

    @inlinable
    public func lgamma(_ x: Float) -> Float { ISO_9899.Math.lgamma(x) }

    @inlinable
    public func logGamma(_ x: Float) -> Float { ISO_9899.Math.lgamma(x) }
}

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS) || ((os(macOS) || targetEnvironment(macCatalyst)) && arch(arm64))
    extension Numeric.Math.Accessor where T == Float16 {

        @inlinable
        public func lgamma(_ x: Float16) -> Float16 { Float16(ISO_9899.Math.lgamma(Float(x))) }

        @inlinable
        public func logGamma(_ x: Float16) -> Float16 { Float16(ISO_9899.Math.lgamma(Float(x))) }
    }
#endif
