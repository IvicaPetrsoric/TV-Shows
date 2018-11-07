import UIKit

class CommentsCell: BaseCell {
    
    var comment: Comment? {
        didSet {
            commentTextView.text = comment?.text
            
            guard let userEmail = comment?.userEmail else { return }
            let emailCommponents = userEmail.components(separatedBy: "@")
            
            if emailCommponents.count > 1 {
                userNameLabel.text = emailCommponents[0]
            }
        }
    }
    
    var imageName: String? {
        didSet {
            if let imageName = imageName {
                userImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img-placeholder-user1")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .color(key: .buttonLogInEnabled)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let commentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "5min"
        label.textColor = .lightGray
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    var commentTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Test"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isUserInteractionEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        return textView
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func setupViews() {
        addSubview(borderView)
        addSubview(userImageView)
        addSubview(userNameLabel)
        addSubview(commentTimeLabel)
        addSubview(commentTextView)
        
        borderView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 1))
        userImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 13, left: 16, bottom: 0, right: 0), size: .init(width: 48, height: 48))
        commentTimeLabel.anchor(top: userImageView.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 0, height: 14))
        userNameLabel.anchor(top: userImageView.topAnchor, leading: userImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 0, height: 19))
        commentTextView.anchor(top: userNameLabel.bottomAnchor, leading: userNameLabel.leadingAnchor, bottom: bottomAnchor, trailing: commentTimeLabel.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 10, right: 0))
    }
    
}
