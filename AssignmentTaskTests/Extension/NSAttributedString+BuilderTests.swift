import UIKit
import Quick
import Nimble
@testable import AssignmentTask

class NSAttributedString_BuilderTests: QuickSpec {

    override func spec() {
        describe("attributed string with") {
            it("SFUIText-Medium font") {
                let sfMediumFont = UIFont.sfMedium(14)
                let attributedText = NSAttributedString(string: "This is a test string").withFont(sfMediumFont)
                let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
                expect(attributes[.font] as? UIFont).to(equal(sfMediumFont))
                expect(attributedText.string).to(equal("This is a test string"))
            }
            
            it("system font") {
                let systemFont = UIFont.systemFont(ofSize: 15)
                let attributedText = NSAttributedString(string: "This is a test string").withFont(systemFont)
                let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
                expect(attributes[.font] as? UIFont).to(equal(systemFont))
                expect(attributedText.string).to(equal("This is a test string"))
            }
        }
        
        describe("attributed string with") {
            it("test color") {
                let color = UIColor.red
                let attributedText = NSAttributedString(string: "This is a test string").withTextColor(color)
                let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
                expect(attributes[.foregroundColor] as? UIColor).to(equal(color))
                expect(attributedText.string).to(equal("This is a test string"))
            }
        }
        
        describe("attributed string with") {
            it("line height") {
                let attributedText = NSAttributedString(string: "This is a test string").withLineHeight(1.5)
                let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
                let paragraphStyle = attributes[.paragraphStyle] as! NSParagraphStyle
                expect(paragraphStyle.lineHeightMultiple).to(equal(1.5))
                expect(attributedText.string).to(equal("This is a test string"))
            }
        }
        
        describe("attributed string with") {
            it("line spacing") {
                let attributedText = NSAttributedString(string: "This is a test string").withLineSpacing(2.0)
                let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
                let paragraphStyle = attributes[.paragraphStyle] as! NSParagraphStyle
                expect(paragraphStyle.lineSpacing).to(equal(2.0))
                expect(attributedText.string).to(equal("This is a test string"))
            }
        }
        
        describe("attributed string with") {
            it("text alignment") {
                let attributedText = NSAttributedString(string: "This is a test string").withAlignment(.left)
                let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
                let paragraphStyle = attributes[.paragraphStyle] as! NSParagraphStyle
                expect(paragraphStyle.alignment).to(equal(NSTextAlignment.left))
                expect(attributedText.string).to(equal("This is a test string"))
            }
        }
        
        describe("attributed string with") {
            it("multiple attributes") {
                let font = UIFont.sfBold(13.0)
                let color = UIColor.blue
                
                let attributedText = NSAttributedString(string: "This is a test string").withFont(font).withTextColor(color).withLineHeight(1.2).withLineSpacing(1.8).withAlignment(.right)
                let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
                let paragraphStyle = attributes[.paragraphStyle] as! NSParagraphStyle
                
                expect(attributes[.font] as? UIFont).to(equal(font))
                expect(attributes[.foregroundColor] as? UIColor).to(equal(color))
                expect(paragraphStyle.lineHeightMultiple).to(equal(1.2))
                expect(paragraphStyle.lineSpacing).to(equal(1.8))
                expect(paragraphStyle.alignment).to(equal(NSTextAlignment.right))
                expect(attributedText.string).to(equal("This is a test string"))
            }
        }
    }
    
}
