import Foundation

public class Config {
    // ZenText supports localization, and will always check the languages in default order. If none pass, it will print the key.
    // It is a good idea to update this array such that the device locale is at index 0, and your default locale
    // is at the last index, though not necessary. 
    // At worst, your key will be the string returned.
    public var languages = ["en"]
    
    // [language:[key:value]]
    // e.g. copy["en"]["profile.title"] = ["Hello world!"]
    // e.g. copy["en"]["profile.title"] = ["Hello ", "world!".style("token")]
    internal var _copy = [String:[String:[TextComponent]]]()
    open var copy: ((_ locale: String, _ key: String) -> [TextComponent]?)?
    
    // Configure your own styles and set them here.
    // e.g. ZenText.manager.styles.append("header", Style(color: nil, font: UIFont(named:"something", size:14)))
    //      ZenText.manager.styles.append("bindleGreen", Style(color: ..., font: nil)
    fileprivate var _styles = [String:Style]()
    open var styles: ((_ name: String) -> Style?)?
    
    public init() {
        
    }
    
    public func styleNamed(_ styleName: String) -> Style {
        if let style = _styles[styleName] {
            return style
        }
        return styles?(styleName) ?? Style() // TODO: default style?
    }
}
