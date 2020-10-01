import UIKit

extension NSAttributedString {

    func withFont(_ font: UIFont) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        let range = NSRange(location: 0, length: length)
        mutable.addAttribute(.font, value: font, range: range)
        return mutable
    }

    func withTextColor(_ color: UIColor) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        let range = NSRange(location: 0, length: length)
        mutable.addAttribute(.foregroundColor, value: color, range: range)
        return mutable
    }

    func withLineHeight(_ height: CGFloat) -> NSAttributedString {
        let style = paragraphStyle(atLocation: 0)
            .withLineHeight(height)
        return withParagraphStyle(style)
    }

    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        let style = paragraphStyle(atLocation: 0)
            .withLineSpacing(spacing)
        return withParagraphStyle(style)
    }

    func withAlignment(_ alignment: NSTextAlignment) -> NSAttributedString {
        let style = paragraphStyle(atLocation: 0)
            .withAlignment(alignment)
        return withParagraphStyle(style)
    }

    func withTruncatingTail() -> NSAttributedString {
        let style = paragraphStyle(atLocation: 0)
            .withTruncatingTail()
        return withParagraphStyle(style)
    }

    func withParagraphStyle(_ style: NSParagraphStyle) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        let range = NSRange(location: 0, length: length)
        mutable.addAttribute(.paragraphStyle, value: style, range: range)
        return mutable
    }

    func paragraphStyle(atLocation location: Int, orCreate creator: (() -> NSParagraphStyle) = { return NSParagraphStyle() }) -> NSParagraphStyle {
        if !string.isEmpty, let style = attribute(.paragraphStyle, at: location, effectiveRange: nil) as? NSParagraphStyle {
            return style
        }
        return creator()
    }

    func appending(_ other: NSAttributedString, spacer: String = " ") -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        mutable.append(NSAttributedString(string: spacer))
        mutable.append(other)
        return mutable
    }

    func containsTextAttachmentAtIndex(_ index: Int) -> Bool {
        return attribute(NSAttributedString.Key.attachment, at: index, effectiveRange: nil) != nil
    }

}

extension NSParagraphStyle {

    func withLineHeight(_ height: CGFloat) -> NSParagraphStyle {
        let mutable = NSMutableParagraphStyle()
        mutable.setParagraphStyle(self)
        mutable.lineHeightMultiple = height
        return mutable
    }

    func withLineSpacing(_ spacing: CGFloat) -> NSParagraphStyle {
        let mutable = NSMutableParagraphStyle()
        mutable.setParagraphStyle(self)
        mutable.lineSpacing = spacing
        return mutable
    }

    func withAlignment(_ alignment: NSTextAlignment) -> NSParagraphStyle {
        let mutable = NSMutableParagraphStyle()
        mutable.setParagraphStyle(self)
        mutable.alignment = alignment
        return mutable
    }

    func withTruncatingTail() -> NSParagraphStyle {
        let mutable = NSMutableParagraphStyle()
        mutable.setParagraphStyle(self)
        mutable.lineBreakMode = .byTruncatingTail
        return mutable
    }

}

extension Array where Element: NSAttributedString {

    func joined(separator: NSAttributedString) -> NSAttributedString? {
        guard let first = first else {
            return nil
        }
        let rest = dropFirst()
        let joined = NSMutableAttributedString(attributedString: first)
        rest.forEach {
            joined.append(separator)
            joined.append($0)
        }
        return joined
    }

}
