import UIKit

class PrgoressIndicator: BaseView {
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicator.color = UIColor.color(key: .buttonLogInEnabled)
        return indicator
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    override func setupViews() {
        alpha = 0
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        addSubview(backgroundView)
        addSubview(activityIndicator)
        
        backgroundView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 64, height: 64))
        backgroundView.anchorCenterSuperview()        
        activityIndicator.anchorCenterSuperview()
    }
    
    func animate(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = show ? 1 : 0
        }
    }
    
}
