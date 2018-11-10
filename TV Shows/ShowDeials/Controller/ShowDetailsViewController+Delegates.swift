import Foundation

extension ShowDetailsViewController: UpdateViewsDelegate {
    
    func updateViews() {
        scrollView.addSubview(showDetialsEpisodesTableController.view)
        scrollView.addSubview(addEpisodeButton)
        
        showDetialsEpisodesTableController.view.anchor(top: headerDetialsView.descriptionLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 448))
        addEpisodeButton.anchor(top: showDetialsEpisodesTableController.view.bottomAnchor, leading: nil, bottom: scrollView.bottomAnchor, trailing: showDetialsEpisodesTableController.view.trailingAnchor,
                                padding: .init(top: 4, left: 0, bottom: 24, right: 24), size: .init(width: 56, height: 56))
    }
}

extension ShowDetailsViewController: PushNewVCDelegate {
    
    func pushVC(byId: String) {
        let episodeDetailsViewController = EpisodeDetailsViewController()
        episodeDetailsViewController.episodeId = byId
        navigationController?.pushViewController(episodeDetailsViewController, animated: true)
    }
    
}


