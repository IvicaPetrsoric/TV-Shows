import UIKit

extension HomeShowsViewController: PushNewVCDelegate {
    
    func pushVC(byId: String) {
        let showsDetilasController = ShowDetailsViewController()
        showsDetilasController.showDetialsId = byId
        navigationController?.pushViewController(showsDetilasController, animated: true)
    }
    
}

extension HomeShowsViewController: PresentNewVCDelegate {
    
    func presentVC(byId: String) {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self
        let navController = UINavigationController(rootViewController: loginViewController)
        present(navController, animated: true, completion: nil)
    }
    
}

extension HomeShowsViewController: LoginViewDelegate {
    
    func userLoged() {
        fetchUserVideos()
    }
}
