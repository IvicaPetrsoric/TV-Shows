import UIKit

protocol CommentInputAccessoryViewDelegate: class {
    func didSubmit(for comment: String)
}

class CommentInputAccessoryView: BaseView {
    
    var delegate: CommentInputAccessoryViewDelegate?
    
    func clearCommentTextField(){
        commentTextField.text = nil
    }
    
    lazy var leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor =  UIColor.init(white: 0.1, alpha: 0.1)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleLeftButton), for: .touchUpInside)
        return button
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.color(key: .buttonLogInEnabled), for: .normal)
        button.addTarget(self, action: #selector(handlePost), for: .touchUpInside)
        return button
    }()
    
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add a comment..."
        textField.textColor = .gray
        textField.borderStyle = .roundedRect
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 21
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 1))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 46, height: 1))
        textField.rightViewMode = .always
        return textField
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    override func setupViews() {
        backgroundColor = .white

        addSubview(borderView)
        addSubview(leftButton)
        addSubview(commentTextField)
        commentTextField.addSubview(postButton)

        borderView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 1), size: .init(width: 0, height: 1))
        leftButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 7, left: 16, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        commentTextField.anchor(top: topAnchor, leading: leftButton.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 6, left: 8, bottom: 0, right: 16), size: .init(width: 0, height: 42))
        postButton.anchor(top: commentTextField.topAnchor, leading: nil, bottom: commentTextField.bottomAnchor, trailing: commentTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 22))
    }
    
    @objc func handleLeftButton() {
        print("handle left button")
    }
    
    @objc func handlePost(){
        guard let commentText = commentTextField.text else { return }
        delegate?.didSubmit(for: commentText)
    }
    
}
