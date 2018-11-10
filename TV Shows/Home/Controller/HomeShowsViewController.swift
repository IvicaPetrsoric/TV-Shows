import UIKit

class HomeShowsViewController: UIViewController {
    
    lazy var titleView: TitleView = {
        let view = TitleView()
        view.delegate = self
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
        
        presentVC(byId: "")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupViews() {
        view.addSubview(titleView)
        view.addSubview(showsTableController.view)
        view.addSubview(progressIndicator)
        if #available(iOS 11.0, *) {
            titleView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 83))
        } else {
            titleView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 83))
        }
        showsTableController.view.anchor(top: titleView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        progressIndicator.fillSuperview()
    }
    
    func fetchUserVideos() {
        progressIndicator.animate(show: true)
        
        ServiceApi.shared.getData(endpoint: .show, type: [Shows].self) { (shows, error) in
            self.progressIndicator.animate(show: false)
            
            if error == .error {
                self.showAllert(message: .errorFetchingShows)
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

