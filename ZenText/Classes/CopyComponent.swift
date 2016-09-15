open class CopyComponent: ExpressibleByStringLiteral {
    open var value: String
    open var style: Style?
    open var styleName: String?
    
    public required init(stringLiteral value: String) {
        self.value = value
    }
    
    public required init(extendedGraphemeClusterLiteral value: String) {
        self.value = value
    }
    
    public required init(unicodeScalarLiteral value: String) {
        self.value = value
    }
    
    public init(value: String, style: Style? = nil, styleName: String? = nil) {
        self.value = value
        self.style = style
        self.styleName = styleName
    }
}

public extension String {
    func style(_ styleName: String) -> CopyComponent {
        return CopyComponent(value: self, styleName: styleName)
    }
    
    func style(_ style: Style?) -> CopyComponent {
        return CopyComponent(value: self, style: style)
    }
}
