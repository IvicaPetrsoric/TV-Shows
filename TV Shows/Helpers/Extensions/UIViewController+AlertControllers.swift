import UIKit

extension UIViewController {
    
    enum AlertMessage: String{
        case errorLogin = "Ooops, something went wrong, check you credentials and web connection!"
        case errorFetchingShows = "Ooops, something went wrong with fetching your shows, check your web connection!"
        case errorFetchingShowsDetials = "Ooops, something went wrong with fetching your show details, check your web connection!"
    }
    
    func showAllert(message: String){
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
