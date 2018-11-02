import UIKit

protocol PushShowDetailsDelegate: class {
    func pushShowDetailsController(byId: String)
}

class ShowsTableController: UITableViewController {
    
    var shows = [Shows]()
    weak var delegate: PushShowDetailsDelegate?
    
    fileprivate let cellId = "celId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ShowsCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ShowsCell
        cell.myShow = shows[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showId = shows[indexPath.row].id
        delegate?.pushShowDetailsController(byId: showId)
    }
    
}
