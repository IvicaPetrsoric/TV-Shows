import UIKit

class CommentsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    var episodeId: String? {
        didSet {
            guard let id = self.episodeId else { return }
            progressIndicator.animate(show: true)

            ServiceApi.shared.getData(id: id, endpoint: .episodeDetailsComments, type: [Comment].self) { [weak self] (comments, response) in
                self?.progressIndicator.animate(show: false)

                if response == .error {
                    self?.showAllert(message: .errorPostingComment)
                    return
                }
                
                guard let comments = comments else { return }
                self?.comments = comments
                
                DispatchQueue.main.async {
                    self?.reloadCollectionView()
                }
            }
        }
    }
    
    lazy var containerView: CommentInputAccessoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 54)
        let comentInputAccessoryView = CommentInputAccessoryView(frame: frame)
        comentInputAccessoryView.delegate = self
        comentInputAccessoryView.commentTextField.delegate = self
        return comentInputAccessoryView
    }()
    
    var comments = [Comment]()
    var commentsImage = [String: String]()
    let cellId = "cell"
    let footerCellId = "footerCellId"
    let progressIndicator = PrgoressIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
        setupCollectionView()
        setupViews()
        setupNotificationObservers()
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Comments"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic-navigate-back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
    }
    
    fileprivate func setupViews() {
        view.addSubview(progressIndicator)
        progressIndicator.fillSuperview()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView?.keyboardDismissMode = .interactive
        collectionView.register(CommentsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(CommentsFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellId)
    }
    
    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification){
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification ? true : false
        let keyboardHeight = keyboardFrame?.height ?? 270
        let newBottomInests: CGFloat = keyboardHeight > 54 ?    50 : 5
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: newBottomInests, right: 0)
            self.collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: newBottomInests, right: 0)
        }) { (completed) in
            
            if isKeyboardShowing{
                let indexPath = IndexPath(item: self.comments.count - 1, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addNewComment(id: String, comment: String) {
        let userEmail = UserDefaults.standard.string(forKey: UserDefaults.Keys.userEmail.rawValue) ?? ""
        let newComment = Comment.init(id: "", episodeId: id, text: comment, userEmail: userEmail)
        self.comments.append(newComment)
        self.reloadCollectionView()
        self.containerView.clearCommentTextField()
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override var inputAccessoryView: UIView?{
        get{
            return containerView
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
