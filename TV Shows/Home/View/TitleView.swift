import UIKit

protocol PresentNewVCDelegate: class {
    func presentVC(byId: String)
}

class TitleView: BaseView {
    
    weak var delegate: PresentNewVCDelegate?
    
    fileprivate let logutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "ic-logout")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Shows"
        label.textAlignment = .right
        return label
    }()
        
    override func setupViews() {
        addSubview(logutButton)
        addSubview(titleLabel)

        logutButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 21, left: 0, bottom: 0, right: 16), size: .init(width: 40, height: 40))
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 19, left: 16, bottom: 0, right: 0), size: .init(width: 0, height: 40))
    }
    
    @objc func handleLogout() {
        delegate?.presentVC(byId: "")
    }
    
}
