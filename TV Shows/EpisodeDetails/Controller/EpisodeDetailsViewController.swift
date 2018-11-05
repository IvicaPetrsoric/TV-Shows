import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    var episodeId: String? {
        didSet {
            guard let id = episodeId else { return }
            
            ServiceApi.shared.getEpisodeDetails(id: id) { (episodeDetails, response) in
                print(episodeDetails as Any)
                if response == .error {
                    return
                }
                
                self.episodeDetailsView.episodeDetials = episodeDetails
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
        return controller
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
    }
    
    fileprivate func setupViews() {
        view.addSubview(episodeDetailsView)
        view.addSubview(backButton)
        
        episodeDetailsView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        backButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 28, left: 16, bottom: 0, right: 0), size: .init(width: 32, height: 32))
    }
    
    @objc func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension EpisodeDetailsViewController: PushNewVCDelegate {
    
    func pushVC(byId: String) {
        let episodeCommentsViewController = EpisodeCommentsViewController()
        episodeCommentsViewController.episodeId = byId
        let navVC = UINavigationController(rootViewController: episodeCommentsViewController)
        navigationController?.present(navVC, animated: true, completion: nil)
    }
    
}
