import UIKit

extension UIColor {
    
    enum Key: String {
        case pinkEnabled
        case pinkDisabled
    }
    
    static func color(key: Key) -> UIColor {
        switch key {
        case .pinkEnabled:
            return UIColor.rgb(red: 255, green: 117, blue: 140)
            
        case .pinkDisabled:
            return UIColor.rgb(red: 255, green: 204, blue: 213)
            
        }
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}
