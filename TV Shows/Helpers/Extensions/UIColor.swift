import UIKit

extension UIColor {
    
    enum ColorKeys: String {
        case buttonLogInEnabled
        case buttonLogInDisabled
    }
    
    static func color(key: ColorKeys) -> UIColor {
        switch key {
        case .buttonLogInEnabled:
            return UIColor.rgb(red: 255, green: 117, blue: 140)
            
        case .buttonLogInDisabled:
            return UIColor.rgb(red: 255, green: 204, blue: 213)
            
        }
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}
