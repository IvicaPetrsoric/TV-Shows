import UIKit

class HomeShowsViewController: UIViewController {
    
    lazy var titleView: TitleView = {
        let view = TitleView()
        view.viewControoler = self
        return view
    }()
    
    lazy var showsTableController : ShowsTableController = {
        let tabController = ShowsTableController()
        tabController.delegate = self
        return tabController
    }()
    
    fileprivate let progressIndicator = PrgoressIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        
//        titleView.handleLogout()
        
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        let layout = UICollectionViewFlowLayout()
        let episodeCommentsViewController = EpisodeCommentsCollectionView(collectionViewLayout: layout)
        let navVC = UINavigationController(rootViewController: episodeCommentsViewController)
        navigationController?.present(navVC, animated: true, completion: nil)
    }
    
    func setupViews() {
        view.addSubview(titleView)
        view.addSubview(showsTableController.view)
        view.addSubview(progressIndicator)
        
        titleView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 83))
        showsTableController.view.anchor(top: titleView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        showsTableController.tableView.isHidden = true
        progressIndicator.fillSuperview()
    }
    
    func fetchData() {
        progressIndicator.animate(show: true)
        
        ServiceApi.shared.getShows() { (shows, error) in
            self.progressIndicator.animate(show: false)
            
            if error == .error {
                self.showAllert(message: AlertMessage.errorFetchingShows.rawValue)
                return
            }
            
            if let myShows = shows {
                let filtered = myShows.filter({ (show) -> Bool in
                    return !show.imageUrl.isEmpty && !show.id.isEmpty && !show.title.isEmpty
                })
                
                self.showsTableController.tableView.isHidden = false
                self.showsTableController.shows = filtered
                
                DispatchQueue.main.async {
                    self.showsTableController.tableView.reloadData()
                }
            }
        }
    }
    
}

extension HomeShowsViewController: PushNewVCDelegate {
    
    func pushVC(byId: String) {
        let showsDetilasController = ShowDetailsTableController()
        showsDetilasController.showDetialsId = byId
        navigationController?.pushViewController(showsDetilasController, animated: true)
    }
    
}
