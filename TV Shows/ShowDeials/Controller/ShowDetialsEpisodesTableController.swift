import UIKit

class ShowDetialsEpisodesTableController: UITableViewController {
    
    
    var showEpisodesDetails: [ShowEpisodesDetaills]? {
        didSet {
            guard let showEpisodesDetails = self.showEpisodesDetails else { return }
            
            let filtered = showEpisodesDetails.filter({ (episodeDetails) -> Bool in
                return !episodeDetails.episodeNumber.isEmpty && Int(episodeDetails.episodeNumber) != nil && !episodeDetails.imageUrl.isEmpty && !episodeDetails.title.isEmpty
            })
            
            filteredResults = filtered.sorted(by: { (a, b) -> Bool in
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
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    weak var delegate: PushNewVCDelegate?
    
    var filteredResults = [ShowEpisodesDetaills]()
    
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.register(EpisodeDetialsCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect(x: 24, y: 0, width: self.view.frame.width - 48, height: 56)
        let totalEpisodes = filteredResults.count
        let attributedText = NSMutableAttributedString(string: "Episodes  ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        attributedText.append(NSAttributedString(string: "\(totalEpisodes)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedText
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return filteredResults.count != 0 ? 56 : 0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeDetialsCell
        cell.showEpisodeDetails = filteredResults[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return filteredResults.count != 0 ? 56 : 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let showEpisodesDetails = showEpisodesDetails {
            let id = showEpisodesDetails[indexPath.row].id
            delegate?.pushVC(byId: id)
        }
    }
}
