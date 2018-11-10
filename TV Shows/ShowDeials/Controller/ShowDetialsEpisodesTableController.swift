import UIKit

class ShowDetialsEpisodesTableController: UITableViewController {
    
    weak var delegate: PushNewVCDelegate?
    
    var showId: String? {
        didSet {
            guard let id = showId else { return }
            progressIndicator.animate(show: true)
            
            ServiceApi.shared.getData(id: id, endpoint: .showEpisodesDescription, type: [ShowEpisodesDetaills].self) { [weak self] (showEpisodes, response) in
                self?.progressIndicator.animate(show: false)
                
                if response == .error {
                    self?.showAllert(message: .errorFetchingShowsDetials)
                    return
                }
                
                guard let showEpisodes = showEpisodes else { return }
                self?.showEpisodesDetails = showEpisodes
                self?.filterResultAndRefreshTable()
            }
        }
    }
    
    var showEpisodesDetails = [ShowEpisodesDetaills]()
    let cellId = "cellId"
    fileprivate let progressIndicator = PrgoressIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViews()
    }
    
    fileprivate func setupTableView() {
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.register(ShowEpisodeDetialsCell.self, forCellReuseIdentifier: cellId)
    }
    
    fileprivate func setupViews() {
        view.addSubview(progressIndicator)
        progressIndicator.anchorCenterSuperview()
    }
    
    fileprivate func filterResultAndRefreshTable() {
        let filteredResults = showEpisodesDetails.sorted(by: { (a, b) -> Bool in
            guard let aSeason = Int(a.season) else { return false }
            guard let bSeason = Int(b.season) else { return false }
            
            if aSeason > bSeason {
                return true
            } else if aSeason == bSeason  {
                return a.episodeNumber > b.episodeNumber
            } else {
                return false
            }
        })
        
        self.showEpisodesDetails = filteredResults
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension ShowDetialsEpisodesTableController: CreateEpisodeDelegate {
    
    func updateShowDetailsTable(newEpisode: ShowEpisodesDetaills) {
        showEpisodesDetails.append(newEpisode)
        filterResultAndRefreshTable()
    }
}
