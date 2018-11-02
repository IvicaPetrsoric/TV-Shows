import UIKit

class ShowsTableController: UITableViewController {
    
    var shows = [Shows]()
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
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ShowsCell
        
        return cell
    }
    
}