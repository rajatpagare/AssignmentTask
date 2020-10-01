import UIKit
extension UIFont {

    class func sfRegular(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFUIText-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    class func sfMedium(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFUIText-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
        }
        return font
    }

    class func sfSemibold(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFUIText-Semibold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
        }
        return font
    }

    class func sfBold(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFUIText-Bold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
        }
        return font
    }
}
