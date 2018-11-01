import UIKit

class HomeShowsTableController: UIViewController {
    
    lazy var titleView: TitleView = {
        let view = TitleView()
        view.viewControoler = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        setupViews()
        
        titleView.handleLogout()
    }
    
    func setupViews() {
        view.addSubview(titleView)
        
        titleView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 83))
    }
    
}
