import Foundation
import Alamofire

extension CommentsController: CommentInputAccessoryViewDelegate {
    
    func didSubmit(for comment: String) {
        guard let id = episodeId else { return }
        progressIndicator.animate(show: true)
        
        let parameters: Parameters = [
            "text": comment,
            "episodeId": id
        ]
        
        ServiceApi.shared.postData(parameters: parameters, endpoint: .comment) { [weak self] (response) in
            self?.progressIndicator.animate(show: false)
            
            if response == .error {
                self?.showAllert(message: .errorPostingComment)
                return
            }
            
            self?.addNewComment(id: id, comment: comment)
        }
    }
    
}
