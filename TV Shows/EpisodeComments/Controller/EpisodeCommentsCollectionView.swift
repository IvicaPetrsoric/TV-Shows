import UIKit

class EpisodeCommentsCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var episodeId: String? {
        didSet {
            guard let id = self.episodeId else { return }
            ServiceApi.shared.getEpisodeDetailsComments(id: id) { (comments, response) in
                if response == .error {
                    return
                }
//                print(comments as Any)
                
                guard let comments = comments else { return }
                self.episodeComments = comments
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var episodeComments = [EpisodeComments]()
    
    fileprivate let cellId = "cell"
    fileprivate let footerCellId = "footerCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodeId = "0KAjbPLJuRh75OJE"
        
        collectionView.backgroundColor = .white
        collectionView?.keyboardDismissMode = .interactive
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -54, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -54, right: 0)

        collectionView.register(CommentsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(CommentsFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellId)
        
        navigationItem.title = "Comments"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic-navigate-back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
    }
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override var inputAccessoryView: UIView?{
        get{
            return containerView
        }
    }
    
    lazy var containerView: CommentInputAccessoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 54)
        let comentInputAccessoryView = CommentInputAccessoryView(frame: frame)
        comentInputAccessoryView.delegate = self
        return comentInputAccessoryView
    }()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeComments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommentsCell
        cell.episodeComment = episodeComments[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let commentText = episodeComments[indexPath.item].text
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: commentText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil)
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 63)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath) as! CommentsFooterCell
            return footerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return episodeComments.count == 0 ?  CGSize(width: view.frame.width, height: view.frame.height) : .zero
    }
    
}

extension EpisodeCommentsCollectionView: CommentInputAccessoryViewDelegate {
    
    func didSubmit(for comment: String) {
        print("Text: ", comment)
        self.containerView.clearCommentTextField()
    }
}
