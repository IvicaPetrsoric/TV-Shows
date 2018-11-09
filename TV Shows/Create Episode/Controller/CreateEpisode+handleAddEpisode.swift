import UIKit

extension CreateEpisodeController {
    
    func prepareForUploadEpisodeData() {
        guard let image = uploadImageView.currentImage else { return self.showAllert(message: .errorCreateEpisodeNoImage) }
        guard let imageUrl = uploadImageView.currentImageUrl else { return }
        guard let imageData = image.pngData() else { return }
        
        ServiceApi.shared.postImage(data: imageData, fileName: imageUrl) { [weak self] (response) in
            // TODO: Upload image API error
            if response == .error {
                //                self?.showAllert(message: .errorCreateEpisodeUploadImage)
                //                return
            }
            
            guard let showEpisodeDetails = self?.validateEpisodeDetailsData(withImageUrl: imageUrl) else { return }
            
            ServiceApi.shared.postCreateEpisode(details: showEpisodeDetails, completionHandler: { [weak self] (response) in
                if response == .error {
                    self?.showAllert(message: .errorCreateEpisode)
                    return
                }
                
                self?.successfullyCreatedEpisode()
            })
        }
    }
    
    fileprivate func validateEpisodeDetailsData(withImageUrl: String) -> ShowEpisodesDetaills? {
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
        
        return ShowEpisodesDetaills.init(id: id, title: title, description: description, imageUrl: withImageUrl, episodeNumber: episode, season: season)
    }
    
    func successfullyCreatedEpisode() {
        let alert = UIAlertController(title: "Created Episode", message: "Successfully created new episode!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler:{ (UIAlertAction) in
            self.delegate?.updateShowDetailsTable()
            self.handleCancel()
        }))
        present(alert, animated: true)
    }
    
}
