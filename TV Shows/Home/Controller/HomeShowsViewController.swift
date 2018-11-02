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
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        setupViews()
        
//        titleView.handleLogout()
        
        fetchData()
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
                self.showsTableController.tableView.isHidden = false
                self.showsTableController.shows = myShows
                
                DispatchQueue.main.async {
                    self.showsTableController.tableView.reloadData()
                }
            }
        }
    }
    
}

extension HomeShowsViewController: PushShowDetailsDelegate {
    
    func pushShowDetailsController(forShow: Shows) {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
}
