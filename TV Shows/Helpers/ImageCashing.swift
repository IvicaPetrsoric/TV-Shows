import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageCashing {
    
    func loadImage(url: String, completionHandler: @escaping(UIImage?) -> ()) {
        if let imageFromCache = imageCache.object(forKey: url as NSString){
            return completionHandler(imageFromCache)
        }
        
        return completionHandler(nil)
    }
    
    func saveImage(image: UIImage, url: String) {
        imageCache.setObject(image, forKey: url as NSString)
    }
    
}
