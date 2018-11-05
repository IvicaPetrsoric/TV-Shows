import UIKit

class ShowDetailsViewController: UIViewController {
    
    var showDetialsId: String? {
        didSet {
            guard let id = showDetialsId else { return }
            progressIndicator.animate(show: true)

            ServiceApi.shared.getShowDescription(id: id) { [weak self] (details, error) in
                if error == .error {
                    self?.progressIndicator.animate(show: false)
                    self?.showAllert(message: AlertMessage.errorFetchingShowsDetials.rawValue)
                    return
                }
                
                guard let details = details else { return }
                self?.headerDetialsView.showDetilas = details
                
                ServiceApi.shared.getShowEpisodesDescription(id: id) { [weak self] (showEpisodes, error) in
                    self?.progressIndicator.animate(show: false)

                    if error == .error {
                        self?.showAllert(message: AlertMessage.errorFetchingShowsDetials.rawValue)
                        return
                    }
                    
                    guard let showEpisodes = showEpisodes else { return }
                    self?.showDetialsEpisodesTableController.showEpisodesDetails = showEpisodes
                }
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
    
    lazy var addEpisodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "ic-fab-button")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleAddEpisode), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var headerDetialsView: HeaderDetialsView = {
        let headerController = HeaderDetialsView()
        headerController.delegate = self
        return headerController
    }()
    
    fileprivate let showDetialsEpisodesTableController = ShowDetialsEpisodesTableController()
    fileprivate let progressIndicator = PrgoressIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    fileprivate func setupViews() {
        view.addSubview(scrollView)
        view.addSubview(progressIndicator)
        scrollView.addSubview(headerDetialsView)
        scrollView.addSubview(backButton)
        
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: -UIApplication.shared.statusBarFrame.height, left: 0, bottom: 0, right: 0))

//        // headerDetails height + Episdeos: title, 7cells, addButton
//        let height: CGFloat = headerDetialsView.frame.height + 56 + 7 * 56 + 77
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1032)
        
        headerDetialsView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        backButton.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 28, left: 16, bottom: 0, right: 0), size: .init(width: 32, height: 32))
        progressIndicator.fillSuperview()
    }
    
    @objc func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddEpisode() {
        print("Add episode")
    }

}

extension ShowDetailsViewController: HeaderDetialsViewDelegate {
    
    func updateViews() {
        scrollView.addSubview(showDetialsEpisodesTableController.view)
        scrollView.addSubview(addEpisodeButton)
        
        showDetialsEpisodesTableController.view.anchor(top: headerDetialsView.descriptionLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 448))
        addEpisodeButton.anchor(top: showDetialsEpisodesTableController.view.bottomAnchor, leading: nil, bottom: nil, trailing: showDetialsEpisodesTableController.view.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0, right: 24), size: .init(width: 56, height: 56))
    }
}
