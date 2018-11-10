import UIKit

class EpisodeDetailsViewController: LightStatusBarStyle {
    
    var episodeId: String? {
        didSet {
            guard let id = episodeId else { return }
            progressIndicator.animate(show: true)
            
            ServiceApi.shared.getData(id: id, endpoint: .episodeDetails, type: EpisodeDetails.self) { [weak self] (episodeDetails, response) in
                if response == .error {
                    self?.progressIndicator.animate(show: false)
                    self?.showAllert(message: .errorFetchingEpisodeDetials)
                    return
                }
                
                self?.episodeDetailsView.episodeDetials = episodeDetails
            }
        }
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "ic-navigate-back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var episodeDetailsView: EpisodeDetailsView = {
        let controller = EpisodeDetailsView()
        controller.epDelegate = self
        controller.delegate = self
        return controller
    }()

    fileprivate let progressIndicator = PrgoressIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(backButton)
        
        var backButtonTopPadding: CGFloat = 28
        
        if #available(iOS 11.0, *) {
            backButtonTopPadding = view.safeAreaInsets.top != 0 ? view.safeAreaInsets.top + 8  : backButtonTopPadding
        }
        
        backButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,
                          padding: .init(top: backButtonTopPadding, left: 16, bottom: 0, right: 0), size: .init(width: 32, height: 32))
    }
    
    fileprivate func setupViews() {
        view.addSubview(episodeDetailsView)
        view.addSubview(progressIndicator)
        
        episodeDetailsView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        progressIndicator.fillSuperview()
    }
    
    @objc func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension EpisodeDetailsViewController: UpdateViewsDelegate {
    
    func updateViews() {
        progressIndicator.animate(show: false)
    }
}

extension EpisodeDetailsViewController: PresentNewVCDelegate {
    
    func presentVC(byId: String) {
        let layout = UICollectionViewFlowLayout()
        let episodeCommentsViewController = CommentsController(collectionViewLayout: layout)
        episodeCommentsViewController.episodeId = byId
        let navVC = UINavigationController(rootViewController: episodeCommentsViewController)
        navigationController?.present(navVC, animated: true, completion: nil)
    }
    
}
