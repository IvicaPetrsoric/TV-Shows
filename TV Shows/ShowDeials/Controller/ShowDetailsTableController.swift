import UIKit

class ShowDetailsTableController: UIViewController {
    
    var showDetialsId: String? {
        didSet {
            guard let id = showDetialsId else { return }
            ServiceApi.shared.getShowDescription(id: id) { (details, error) in
                if error == .error {
                    return
                }
                
                guard let details = details else { return }
                self.headerDetialsView.showDetilas = details
            }
        }
    }
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .white
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "ic-navigate-back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var headerDetialsView: HeaderDetialsView = {
        let headerController = HeaderDetialsView()
        headerController.delegate = self
        return headerController
    }()
    
    fileprivate let showDetialsEpisodesTableController = ShowDetialsEpisodesTableController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    fileprivate func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(headerDetialsView)
        scrollView.addSubview(backButton)
        
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: -UIApplication.shared.statusBarFrame.height, left: 0, bottom: 0, right: 0))

//        // headerDetails height + Episdeos: title, 7cells, addButton
//        let height: CGFloat = headerDetialsView.frame.height + 56 + 7 * 56 + 77
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1100)
        
        headerDetialsView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        backButton.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 28, left: 16, bottom: 0, right: 0), size: .init(width: 32, height: 32))
    }
    
    @objc func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }

}

extension ShowDetailsTableController: HeaderDetialsViewDelegate {
    
    func updateViews() {
        scrollView.addSubview(showDetialsEpisodesTableController.view)
        showDetialsEpisodesTableController.view.anchor(top: headerDetialsView.descriptionLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 504))
    }
}
