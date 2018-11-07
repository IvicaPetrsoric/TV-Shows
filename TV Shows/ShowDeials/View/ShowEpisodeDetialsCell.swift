import UIKit

class ShowEpisodeDetialsCell: BaseTableCell {
    
    var showEpisodeDetails: ShowEpisodesDetaills? {
        didSet {
            guard let season = showEpisodeDetails?.season, let episode = showEpisodeDetails?.episodeNumber, let title = showEpisodeDetails?.title else { return }
            let attributedText = NSMutableAttributedString(string: "S\(season) E\(episode)  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.color(key: .buttonLogInEnabled)])
            attributedText.append(NSAttributedString(string: " \(title)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
            episodeDetilasLabel.attributedText = attributedText
        }
    }
    
    let episodeDetilasLabel = UILabel()
    
    let showDetailsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "ic-navigation-chevron-right-medium")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    override func setupViews() {
        selectionStyle = .none
        
        addSubview(showDetailsButton)
        addSubview(episodeDetilasLabel)
        
        showDetailsButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 24), size: .init(width: 24, height: 24))
        episodeDetilasLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: showDetailsButton.leadingAnchor, padding: .init(top: 18, left: 24, bottom: 0, right: 13), size: .init(width: 0, height: 19))
    }
    
}
