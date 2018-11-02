import UIKit

class ShowsCell: BaseTableCell {
    
    var myShow: Shows? {
        didSet {
            showstitle.text = myShow?.title
            
            guard let imageUrl = myShow?.imageUrl else { return }
            
            ServiceApi.shared.getShowsImage(byUrl: imageUrl) { (image) in
                if let image = image {
                    self.showsImageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
 
    let showsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let showstitle: UILabel = {
        let label = UILabel()
        label.text = "Test"
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicator.color = UIColor.color(key: .buttonLogInEnabled)
        indicator.startAnimating()
        return indicator
    }()
    
    override func setupViews() {
        selectionStyle = .none

        addSubview(showsImageView)
        showsImageView.addSubview(activityIndicator)
        addSubview(showstitle)
        
        showsImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 16, bottom: 0, right: 0), size: .init(width: 64, height: 90))
        showstitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 13, left: 114, bottom: 0, right: 16), size: .init(width: 0, height: 16))
        activityIndicator.anchorCenterSuperview()
    }
    
}
