import UIKit

protocol HeaderDetialsViewDelegate: class {
    func updateViews()
}

class HeaderDetialsView: BaseView {
    
    var showDetilas: ShowDetails? {
        didSet {
            titleLabel.text = showDetilas?.title
            descriptionLabel.text = showDetilas?.description
            
            guard let imageUrl = showDetilas?.imageUrl else { return }
            
            ServiceApi.shared.getShowsImage(byUrl: imageUrl) { (image) in
                if let image = image {
                    self.fetchedImage = image
                    self.setupUI()
                    self.delegate?.updateViews()
                }
            }
        }
    }
    
    weak var delegate: HeaderDetialsViewDelegate?
    
    var fetchedImage = UIImage()
    let headerImageView =  UIImageView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        return textView
    }()
    
    lazy var gradientView: UIView = {
        let view = UIView()
        let gradient = getGradientLayer(frame: CGRect(x: 0, y: 0, width: frame.width, height: 84), colors: [UIColor.white.cgColor, UIColor.clear.cgColor],
                                        locations: [0, 1], startPoint: CGPoint(x: 0.5, y: 1), endPoint: CGPoint(x: 0.5, y: 0))
        view.layer.addSublayer(gradient)
        return view
    }()
    
    func setupUI() {
        let (cropedImage, height) = getCropedImageAndHeight(fetchedImage)
        headerImageView.image = cropedImage
        
        addSubview(headerImageView)
        addSubview(gradientView)
        headerImageView.addSubview(titleLabel)
        headerImageView.addSubview(descriptionLabel)

        headerImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: height))
        gradientView.anchor(top: nil, leading: leadingAnchor, bottom: headerImageView.bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 84))
        titleLabel.anchor(top: headerImageView.bottomAnchor, leading: headerImageView.leadingAnchor, bottom: nil, trailing: headerImageView.trailingAnchor,
                          padding: .init(top: 0, left: 24, bottom: 0, right: 24), size: .init(width: 0, height: 40))
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor)
    }
    
    func getCropedImageAndHeight(_ image: UIImage) -> (UIImage, CGFloat) {
        var height = image.getImageHeight(width: frame.width)
        guard let cropedImage = image.crop(toRect: CGRect(x: 0, y: 0, width: frame.width, height: frame.width), viewWidth: frame.width, viewHeight: height) else { return (UIImage(), 0) }
        let imageCropRatio = CGFloat(cropedImage.getCropRatio())
        height = frame.width / imageCropRatio
        return (cropedImage, height)
    }
    
    func getImageHeight(image: UIImage, width: CGFloat) -> CGFloat {
        let imageCrop = CGFloat(image.getCropRatio())
        return width / imageCrop
    }
    
}
