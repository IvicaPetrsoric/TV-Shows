import UIKit

class ShowsCell: BaseTableCell {
    
    
 
    let showsImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "img-login-logo")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let showstitle: UILabel = {
        let label = UILabel()
        label.text = "Test"
        return label
    }()
    
    override func setupViews() {
        addSubview(showsImageView)
        addSubview(showstitle)
        
        showsImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 16, bottom: 0, right: 0), size: .init(width: 64, height: 90))
        showstitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 13, left: 114, bottom: 0, right: 16), size: .init(width: 0, height: 16))
    }
    
}
