import UIKit

class HomeShowsViewController: UIViewController {

//    fileprivate let loginViewController = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        let loginViewController = LoginViewController()
        let navController = UINavigationController(rootViewController: loginViewController)
        self.present(navController, animated: true, completion: nil)
        
    }


}

