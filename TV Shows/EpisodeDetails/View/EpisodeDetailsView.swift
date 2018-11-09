import UIKit

class EpisodeDetailsView: ShowHeaderDetialsView {
    
    var episodeDetials: EpisodeDetails? {
        didSet {
            
            guard let season = episodeDetials?.season, let episode = episodeDetials?.episodeNumber, let title = episodeDetials?.title else { return }
            
            let attributedText = NSMutableAttributedString(string: "\(title)\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)])
            attributedText.append(NSAttributedString(string: "S\(season) Ep\(episode)",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.color(key: .buttonLogInEnabled)]))
            titleLabel.attributedText = attributedText
            
            descriptionLabel.text = episodeDetials?.description
            
            guard let imageUrl = episodeDetials?.imageUrl else { return }
            
            ServiceApi.shared.getShowsImage(byUrl: imageUrl) { (image) in
                if let image = image {
                    super.fetchedImage = image
                }
                
                super.setupUI()
                self.setupCommentsView()
                self.delegate?.updateViews()
            }
        }
    }
    
    weak var epDelegate: PushNewVCDelegate?
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic-message-circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("Comments", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.centerTextAndImage(spacing: 8)
        button.addTarget(self, action: #selector(handleComments), for: .touchUpInside)
        return button
    }()
    
    func setupCommentsView() {
        addSubview(commentButton)
        commentButton.anchor(top: descriptionLabel.bottomAnchor, leading: descriptionLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 24))
    }
    
    @objc func handleComments() {
        guard let id = episodeDetials?.id else { return }
        epDelegate?.pushVC(byId: id)
    }
    
}

