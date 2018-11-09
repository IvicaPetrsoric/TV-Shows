import Foundation

extension CreateEpisodeController: TextDidChangeDelegate {
    
    func textDidChange(onType: CustomTextFieldView.TextFieldMode, text: String) {
        let textArray = text.components(separatedBy: "&")
        seasonAndEpisode = (season: "" , episode: "")
        
        if textArray.count > 0 && textArray.count < 2 {
            let season: String = textArray[0].replacingOccurrences(of: " ", with: "")
            seasonAndEpisodeLabel.text = "Season \(season), Ep"
            seasonAndEpisode = (season: season , episode: "")
        } else if textArray.count > 1 && textArray.count < 3 {
            let season: String = textArray[0].replacingOccurrences(of: " ", with: "")
            let episode: String = textArray[1].replacingOccurrences(of: " ", with: "")
            seasonAndEpisodeLabel.text = "Season \(season), Ep \(episode)"
            seasonAndEpisode = (season: season , episode: episode)
        }
    }
    
}
