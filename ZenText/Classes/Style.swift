import Foundation

open class Style: ExpressibleByStringLiteral {
    open var color: UIColor?
    open var fontName: String?
    open var fontSize: CGFloat?
    open var underline: Bool?
    open var alpha: CGFloat?
    open var backgroundColor: UIColor?
    
    public required init(stringLiteral value: String) {
        for styleName in ZenText.manager.styleNamesFromStyleString(value) {
            if let style = styleName.style() {
                append(style)
            }
        }
    }
    
    public required init(extendedGraphemeClusterLiteral value: String) {
        for styleName in ZenText.manager.styleNamesFromStyleString(value) {
            if let style = styleName.style() {
                append(style)
            }
        }
    }
    
    public required init(unicodeScalarLiteral value: String) {
        for styleName in ZenText.manager.styleNamesFromStyleString(value) {
            if let style = styleName.style() {
                append(style)
            }
        }
    }
    
    public init(color: UIColor? = nil, fontName: String? = nil, fontSize: CGFloat? = nil, underline: Bool? = nil, alpha: CGFloat? = nil, backgroundColor: UIColor? = nil) {
        self.color = color
        self.fontName = fontName
        self.fontSize = fontSize
        self.underline = underline
        self.alpha = alpha
        self.backgroundColor = backgroundColor
    }
    
    open func append(_ style: Style?) {
        guard let style = style else { return }
        if let color = style.color { self.color = color }
        if let fontName = style.fontName { self.fontName = fontName }
        if let fontSize = style.fontSize { self.fontSize = fontSize }
        if let alpha = style.alpha { self.alpha = alpha }
        if let underline = style.underline { self.underline = underline }
        if let backgroundColor = style.backgroundColor { self.backgroundColor = backgroundColor }
    }
}
