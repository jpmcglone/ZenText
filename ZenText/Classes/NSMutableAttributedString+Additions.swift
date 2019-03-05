import Foundation

public extension NSMutableAttributedString {
    // Add style
    public func addStyle(named styleName: String, regex: String) -> [NSTextCheckingResult]? {
        let style = Style()
        for styleName in ZenText.manager.styleNamesFromStyleString(styleName) {
            if let s = ZenText.manager.config.styles?(styleName) {
                style.append(s)
            }
        }
        return addStyle(style, regex: regex)
    }
    
    public func addStyle(_ style: Style, regex: String, tokenized: Bool = true) -> [NSTextCheckingResult]? {
        return self.style(style, regex: regex, tokenized: tokenized, replace: false)
    }
    
    public func setStyle(named styleName: String, regex: String, tokenized: Bool = true) -> [NSTextCheckingResult]? {
        let style = Style()
        for styleName in ZenText.manager.styleNamesFromStyleString(styleName) {
            if let s = ZenText.manager.config.styles?(styleName) {
                style.append(s)
            }
        }
        return self.setStyle(style, regex: regex, tokenized: tokenized)
    }
    
    public func setStyle(_ style: Style, regex: String, tokenized: Bool = true) -> [NSTextCheckingResult]? {
        return self.style(style, regex: regex, tokenized: tokenized, replace: true)
    }
    
    public func style(_ style: Style, regex: String, tokenized: Bool = true) -> [NSTextCheckingResult]? {
        return self.style(style, regex: regex, tokenized: tokenized, replace: true)
    }
    
    // Set (replace) style
    public func setStyle(named styleName: String, dataDetector: NSDataDetector, tokenized: Bool = true, replace: Bool = true) -> [NSTextCheckingResult]? {
        let matches = dataDetector.matches(in: string, options: [], range: NSRange(location: 0, length: string.characters.count))
        let style = Style()
        for styleName in ZenText.manager.styleNamesFromStyleString(styleName) {
            if let s = ZenText.manager.config.styles?(styleName) {
                style.append(s)
            }
        }
        return self.style(style, matches: matches, tokenized: tokenized, replace: replace)
    }
    
    fileprivate func style(_ style: Style, matches: [NSTextCheckingResult], tokenized: Bool, replace: Bool) -> [NSTextCheckingResult]? {
        for match in matches {
          let range = (tokenized ? match.range(at: match.numberOfRanges-1) : match.range)
            
            let attributes = ZenText.manager.attributesForStyle(style)
            if replace {
                self.setAttributes(attributes, range: range)
            } else if let attributes = attributes {
                self.addAttributes(attributes, range: range)
            }
        }
        
        return matches
    }
    
    // MARK: - Private
    fileprivate func style(_ style: Style, regex: String, tokenized: Bool, replace: Bool) -> [NSTextCheckingResult]? {
        do {
            let regularExpression = try NSRegularExpression(pattern: regex, options: NSRegularExpression.Options(rawValue: 0))
            let range = NSRange(location: 0, length: self.length)
            
            let matches = regularExpression.matches(in: self.string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: range)
            
            return self.style(style, matches: matches, tokenized: tokenized, replace: replace)
        } catch _ {
            
        }
        return nil
    }
}
