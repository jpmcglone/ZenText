open class Regex {
    open class func findTokens(_ regex: String, text: String) -> [String]? {
        if let ranges = findTokenRanges(regex, text: text) {
            var results = [String]()
            for range in ranges {
                results.append((text as NSString).substring(with: range))
            }
            return results
        }
        return nil
    }
    
    // This method supports one capture group. If you use more than one, it will return the last range of each match.
    open class func findTokenRanges(_ regex: String, text: String) -> [NSRange]? {
        do {
            var ranges: [NSRange]?
            let regularExpression = try NSRegularExpression(pattern: regex, options: NSRegularExpression.Options(rawValue: 0))
            let range = NSRange(location: 0, length: text.characters.count)
            let matches = regularExpression.matches(in: text, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: range)
            
            if matches.count > 0 {
                ranges = [NSRange]()
                for match in matches {
                  ranges!.append(match.range(at: match.numberOfRanges-1))
                }
                return ranges
            }
            return nil
        } catch {
            return nil
        }
    }
}
