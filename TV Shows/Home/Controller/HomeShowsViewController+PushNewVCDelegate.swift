import UIKit

extension HomeShowsViewController: PushNewVCDelegate {
    
    func pushVC(byId: String) {
        let showsDetilasController = ShowDetailsViewController()
        showsDetilasController.showDetialsId = byId
        navigationController?.pushViewController(showsDetilasController, animated: true)
    }
    
}
