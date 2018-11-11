import UIKit

class ShowDetailsViewController: LightStatusBarStyle {
    
    var showDetialsId: String? {
        didSet {
            guard let id = showDetialsId else { return }
            progressIndicator.animate(show: true)

            ServiceApi.shared.getData(id: id, endpoint: .showDescription, type: ShowDetails.self) { [weak self] (details, response) in
                self?.progressIndicator.animate(show: false)

                if response == .error {
                    self?.showAllert(message: .errorFetchingShowsDetials)
                    return
                }
                
                guard let details = details else { return }
                self?.headerDetialsView.showDetilas = details
                self?.showDetialsEpisodesTableController.showId = id
            }
        }
    }
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .white
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
    
    lazy var headerDetialsView: ShowHeaderDetialsView = {
        let headerController = ShowHeaderDetialsView()
        headerController.delegate = self
        return headerController
    }()
    
    lazy var showDetialsEpisodesTableController: ShowDetialsEpisodesTableController = {
        let controller = ShowDetialsEpisodesTableController()
        controller.delegate = self
        return controller
    }()
    
    fileprivate let progressIndicator = PrgoressIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.color(key: .pinkEnabled)
        scrollView.refreshControl = refreshControl
    }
    
    @objc func handleRefresh() {
        scrollView.refreshControl?.endRefreshing()
        let id = showDetialsId
        showDetialsId = id
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.addSubview(backButton)
        
        var backButtonTopPadding: CGFloat = 28
        
        if #available(iOS 11.0, *) {
            backButtonTopPadding = view.safeAreaInsets.top != 0 ? view.safeAreaInsets.top + 8  : backButtonTopPadding
        }
        
        backButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,
                          padding: .init(top: backButtonTopPadding, left: 16, bottom: 0, right: 0), size: .init(width: 32, height: 32))
    }
    
    fileprivate func setupViews() {
        view.addSubview(scrollView)
        view.addSubview(progressIndicator)
        scrollView.addSubview(headerDetialsView)
        
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,
                          padding: .init(top: -UIApplication.shared.statusBarFrame.height, left: 0, bottom: 0, right: 0))
        
        headerDetialsView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        progressIndicator.fillSuperview()
    }
    
    @objc func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddEpisode() {
        guard let id = showDetialsId else { return }
        let createEpisode = CreateEpisodeController()
        createEpisode.showId = id
        createEpisode.delegate = showDetialsEpisodesTableController
        let navVC = UINavigationController(rootViewController: createEpisode)
        navigationController?.present(navVC, animated: true, completion: nil)
    }

}
