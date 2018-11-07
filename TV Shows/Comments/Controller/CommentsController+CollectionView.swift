import UIKit

extension CommentsController {
    
    func reloadCollectionView() {
        collectionView.reloadData()
        let indexPath = IndexPath(item: comments.count - 1, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommentsCell
        let comment = comments[indexPath.item]
        cell.imageName = determinateCommentImage(comment: comment)
        cell.comment = comment
        return cell
    }
    
    func determinateCommentImage(comment: Comment) -> String {
        guard let imageName = commentsImage[comment.userEmail] else {
            var availableImages = ["img-placeholder-user1", "img-placeholder-user2", "img-placeholder-user3"]
            let index = Int.random(in: 0..<availableImages.count)
            let imageName = availableImages[index]
            commentsImage[comment.userEmail] = imageName
            return imageName
        }
        
        return imageName
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let commentText = comments[indexPath.item].text
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: commentText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil)
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 63)
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
        return comments.count == 0 && progressIndicator.alpha == 0 ?  CGSize(width: view.frame.width, height: view.frame.height) : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
