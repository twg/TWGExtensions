public extension UILabel {
    
    public func styleSubstring(substr: String, withAttributes attributes: [String : AnyObject]) {
        let range = self.text?.rangeOfString(substr)
        if let r = range {
            self.styleRange(r, withAttributes: attributes)
        }
    }
    
    private func styleRange(range: Range<String.Index>,
        withAttributes attributes: [String : AnyObject]) {
            if let text = self.attributedText {
                let attr = NSMutableAttributedString(attributedString: text)
                let start = text.string.startIndex.distanceTo(range.startIndex)
                let length = range.startIndex.distanceTo(range.endIndex)
                //swiftlint:disable legacy_constructor
                attr.addAttributes(attributes, range: NSMakeRange(start, length))
                //swiftlint:enable legacy_constructor
                self.attributedText = attr
            }
    }
}
