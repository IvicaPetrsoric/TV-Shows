import UIKit

extension UIView {
    
    func getGradientLayer(frame: CGRect, colors: [CGColor], locations: [NSNumber]?, startPoint: CGPoint, endPoint: CGPoint, cornerRadius: CGFloat = 0) -> CALayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.cornerRadius = cornerRadius
        return gradient
    }
    
}
