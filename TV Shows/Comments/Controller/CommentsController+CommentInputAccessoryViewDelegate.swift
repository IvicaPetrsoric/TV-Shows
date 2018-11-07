import Foundation

extension CommentsController: CommentInputAccessoryViewDelegate {
    
    func didSubmit(for comment: String) {
        guard let id = episodeId else { return }
        progressIndicator.animate(show: true)
        
        ServiceApi.shared.postEpisodeDetailsComment(id: id, text: comment) { [weak self] (response) in
            self?.progressIndicator.animate(show: false)
            
            if response == .error {
                self?.showAllert(message: AlertMessage.errorPostingComment.rawValue)
                return
            }
            
            self?.addNewComment(id: id, comment: comment)
        }
    }
}
