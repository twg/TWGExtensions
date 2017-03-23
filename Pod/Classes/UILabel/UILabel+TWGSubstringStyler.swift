public extension UILabel {
    
    public func styleSubstring(_ substr: String, withAttributes attributes: [String : AnyObject]) {
        let range = self.text?.range(of: substr)
        if let r = range {
            self.styleRange(r, withAttributes: attributes)
        }
    }
    
    fileprivate func styleRange(_ range: Range<String.Index>,
        withAttributes attributes: [String : AnyObject]) {
            if let text = self.attributedText {
                let attr = NSMutableAttributedString(attributedString: text)
                let start = text.string.characters.distance(from: text.string.startIndex, to: range.lowerBound)
                let length = text.string.distance(from: range.lowerBound, to: range.upperBound)
                //swiftlint:disable legacy_constructor
                attr.addAttributes(attributes, range: NSMakeRange(start, length))
                //swiftlint:enable legacy_constructor
                self.attributedText = attr
            }
    }
}
