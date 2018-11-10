import UIKit
import Alamofire

extension CreateEpisodeController {
    
    func uploadImageData() {
        guard let image = uploadImageView.currentImage else { return self.showAllert(message: .errorCreateEpisodeNoImage) }
        guard let imageData = image.jpegData(compressionQuality: 0.7) else { return }
        guard let showEpisodeDetails = validateEpisodeDetailsData() else { return }
        
        progressIndicator.animate(show: true)
        
        ServiceApi.shared.postImage(data: imageData) { [weak self] (uploadedImageData, response) in
            guard let mediaId = uploadedImageData?.id, let imageUrl = uploadedImageData?.path, response != .error else {
                self?.progressIndicator.animate(show: false)
                self?.showAllert(message: .errorCreateEpisode)
                return
            }
            
            let parameters: Parameters = [
                "showId": showEpisodeDetails.id,
                "mediaId": mediaId,
                "title": showEpisodeDetails.title,
                "description": showEpisodeDetails.description,
                "episodeNumber": showEpisodeDetails.episodeNumber,
                "season": showEpisodeDetails.season
            ]
            
            self?.uploadEpisodeData(parameters: parameters, showEpisodeDetails: showEpisodeDetails, imageUrl: imageUrl)
        }
    }
    
    fileprivate func uploadEpisodeData(parameters: Parameters, showEpisodeDetails: ShowEpisodesDetaills, imageUrl: String) {
        ServiceApi.shared.postAddEpisode(parameters: parameters, endpoint: .addEpisode, completionHandler: { [weak self] (addedEpisodeDetails, response) in
            self?.progressIndicator.animate(show: false)
            
            guard let id = addedEpisodeDetails?.id, response != .error else {
                self?.showAllert(message: .errorCreateEpisode)
                return
            }
            
            let newEpisode = ShowEpisodesDetaills.init(id: id, title: showEpisodeDetails.title, description: showEpisodeDetails.description,
                                                       imageUrl: imageUrl, episodeNumber: showEpisodeDetails.episodeNumber, season: showEpisodeDetails.season)
            self?.successfullyCreatedEpisode(newEpisode: newEpisode)
        })
    }
    
    fileprivate func validateEpisodeDetailsData() -> ShowEpisodesDetaills? {
        guard let id = showId else { return nil }
        
        guard let title = episodeTitleTextField.myTextField.text, !title.isEmpty else {
            showAllert(message: .errorCreateEpisodeTitle)
            return nil
        }
        
        guard let description = episodeDescriptionTextField.myTextField.text, !description.isEmpty else {
            showAllert(message: .errorCreateEpisodeDescription)
            return nil
        }
        
        let season = self.seasonAndEpisode.season
        let episode = self.seasonAndEpisode.episode
        
        if season.isEmpty {
            showAllert(message: .errorCreateEpisodeSeason)
            return nil
        } else if episode.isEmpty {
            showAllert(message: .errorCreateEpisodeEpisode)
            return nil
        }
        
        return ShowEpisodesDetaills.init(id: id, title: title, description: description, imageUrl: "", episodeNumber: episode, season: season)
    }
    
    func successfullyCreatedEpisode(newEpisode: ShowEpisodesDetaills) {
        let alert = UIAlertController(title: "Created Episode", message: "Successfully created new episode!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler:{ (UIAlertAction) in
            self.delegate?.updateShowDetailsTable(newEpisode: newEpisode)
            self.handleCancel()
        }))
        present(alert, animated: true)
    }
    
}
