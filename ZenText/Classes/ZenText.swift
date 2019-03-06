import Foundation

public let manager = Manager(config: Config())

public class Manager {
    public var config: Config
    
    // applying a style only updates the non-nil values. In the order the styles are applied.
    public init(config: Config) {
        self.config = config
    }
    
    // This will ignore style
    public func string(key: String, args: [String] = []) -> String? {
        guard let language = firstAvailableLanguage(key: key) else { return key }
        guard let textComponents = config._copy[language]?[key] ?? config.copy?(language, key) else { return nil }
        return string(textComponents, args: args)
    }
    
    // Get a styled (attributed) string from `copy`
    public func attributedString(key: String, args: [String] = []) -> NSAttributedString? {
        guard let language = firstAvailableLanguage(key: key) else { return NSAttributedString(string: key) }
        guard let textComponents = config._copy[language]?[key] ?? config.copy?(language, key) else { return nil }
        return attributedString(textComponents, args: args)
    }
    
    public func string(_ textComponents: [TextComponent], args: [String] = []) -> String {
        var string = ""
        //combine textComponents without their style
        for component in textComponents {
            // check for args in component
            // TODO: this isn't very efficient. Consider an algorithm that does this in one pass, instead of n
            var value = component.value
            for (index, arg) in args.enumerated() {
                value = value.replacingOccurrences(of: "$\(index)", with: arg)
            }
            string += value
        }
        return string
    }
    
    internal func styleNamesFromStyleString(_ styleString: String) -> [String] {
        return styleString.components(separatedBy: " ")
    }
    
    // Make an attributedString on the fly with TextComponents
    public func attributedString(_ textComponents: [TextComponent], args: [String] = []) -> NSAttributedString {
        let string = NSMutableAttributedString()
        for component in textComponents {
            var value = component.value
            for (index, arg) in args.enumerated() {
                value = value.replacingOccurrences(of: "$\(index)", with: arg)
            }
            
            var style = component.style
            if style == nil {
                if let styleName = component.styleName {
                    // multiple styles are possible
                    for styleName in styleNamesFromStyleString(styleName) {
                        if style == nil {
                            style = config.styles?(styleName)
                        } else {
                            style!.append(config.styles?(styleName))
                        }
                    }
                }
            }
            
            let attributes = attributesForStyle(style)
            let attributedValue = NSAttributedString(string: value, attributes: attributes)
            string.append(attributedValue)
        }
        return string
    }
    
    // MARK: - Private
    fileprivate func firstAvailableLanguage(key: String) -> String? {
        var lang: String? = nil
        for language in config.languages {
            if let _ = config._copy[language]?[key] ?? config.copy?(language, key) {
                lang = language
                break
            }
        }
        return lang
    }
    
    public func attributesForStyle(_ style: Style?) -> [NSAttributedString.Key : AnyObject]? {
        guard let style = style else { return nil }
        
        // if there is no size, use 12
        var font: UIFont!
        let fontSize = style.fontSize ?? 12
        if let fontName = style.fontName {
            font = UIFont(name: fontName, size: fontSize)
        } else {
            font = UIFont.systemFont(ofSize: fontSize)
        }
        
        var attributes = [NSAttributedString.Key : AnyObject]()
        attributes[NSAttributedString.Key.foregroundColor] = style.color
        
        if let color = style.color, let alpha = style.alpha {
            attributes[NSAttributedString.Key.foregroundColor] = color.withAlphaComponent(alpha)
        }
        
        attributes[NSAttributedString.Key.font] = font
        
        if let underline = style.underline , underline {
          attributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue as AnyObject?
        } else {
            attributes[NSAttributedString.Key.underlineStyle] = nil
        }
        
        attributes[NSAttributedString.Key.backgroundColor] = style.backgroundColor
      
        // For TTTLabel support
//        attributes["TTTBackgroundFillColor"] = style.backgroundColor?.cgColor
      
        return attributes
    }
}
