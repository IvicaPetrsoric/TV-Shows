import UIKit

class CommentsFooterCell: BaseCell {
    
    let footerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img-placeholder-user1")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let footerTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Sorry, we don’t have comments yet.\nBe first who will write a review."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override func setupViews() {
        backgroundColor = .white
        
        addSubview(footerImageView)
        addSubview(footerTextLabel)
        
        footerImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 80, left: 0, bottom: 0, right: 0), size: .init(width: 120, height: 120))
        footerImageView.anchorCenterXToSuperview()
        footerTextLabel.anchor(top: footerImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil)
        footerTextLabel.anchorCenterXToSuperview()
    }
    
}
