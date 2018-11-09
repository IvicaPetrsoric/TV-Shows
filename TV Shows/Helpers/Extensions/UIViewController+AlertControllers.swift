import UIKit

extension UIViewController {
    
    enum AlertMessage: String{
        case errorLogin = "Ooops, something went wrong, check you credentials and web connection!"
        case errorFetchingShows = "Ooops, something went wrong with fetching your shows, check your web connection!"
        case errorFetchingShowsDetials = "Ooops, something went wrong with fetching your show details, check your web connection!"
        case errorFetchingEpisodeDetials = "Ooops, something went wrong with fetching episode details, check your web connection!"
        case errorPostingComment = "Ooops, something went wrong with sending comment, check your web connection!"
        case errorFetchingComments = "Ooops, something went wrong with fetching comment, check your web connection!"
        case errorCreateEpisodeNoImage = "You missed to upload image!"
        case errorCreateEpisodeUploadImage = "Something wen+t wrong with uploading image, check your web connection!"
        case errorCreateEpisodeTitle = "You missed to set Title!"
        case errorCreateEpisodeDescription = "You missed to set description!"
        case errorCreateEpisodeSeason = "You missed to set season!"
        case errorCreateEpisodeEpisode = "You missed to set episode!"
        case errorCreateEpisode = "Ooops, something wen't wrong with creating episode, check your web connection!"
    }
    
    func showAllert(message: AlertMessage){
        let alert = UIAlertController(title: "Notice", message: message.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
