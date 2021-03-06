import UIKit

protocol CreateEpisodeDelegate: class {
    func updateShowDetailsTable(newEpisode: ShowEpisodesDetaills)
}

class CreateEpisodeController: UIViewController {
    
    var showId: String?
    weak var delegate: CreateEpisodeDelegate?
    
    lazy var uploadImageView: UploadImageView = {
        let uploadView = UploadImageView()
        uploadView.currentVC = self
        return uploadView
    }()
    
    lazy var episodeTitleTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldMode = .email
        textField.placeholderLabel.text = "Episode title"
        textField.myTextField.textColor = .color(key: .pinkEnabled)
        return textField
    }()
    
    lazy var seasonAndEpisodeTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldMode = .email
        textField.placeholderLabel.text = "Season & Episode"
        textField.delegate = self
        textField.myTextField.textColor = .color(key: .pinkEnabled)
        textField.updateTextField(text: "8 & 6")
        return textField
    }()
    
    lazy var seasonAndEpisodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Season 8, Ep 6"
        label.textColor = .color(key: .pinkEnabled)
        label.textAlignment = .right
        return label
    }()
    
    lazy var episodeDescriptionTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldMode = .email
        textField.placeholderLabel.text = "Episode description"
        textField.myTextField.textColor = .color(key: .pinkEnabled)
        return textField
    }()
    
    typealias seasonAndEpisodeType = (season: String, episode: String)
    var seasonAndEpisode: seasonAndEpisodeType = (season: "8", episode: "6")
    let progressIndicator = PrgoressIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavBar()
        setupViews()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Add episode"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = .color(key: .pinkEnabled)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAddEpisode))
        navigationItem.rightBarButtonItem?.tintColor = .color(key: .pinkEnabled)
    }
    
    fileprivate func setupViews() {
        view.addSubview(uploadImageView)
        view.addSubview(seasonAndEpisodeLabel)
        view.addSubview(progressIndicator)
        
        uploadImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
                               padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 60))
        
        let stackView = UIStackView(arrangedSubviews: [episodeTitleTextField, seasonAndEpisodeTextField, episodeDescriptionTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        view.addSubview(stackView)
        stackView.anchor(top: uploadImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
                         padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 192))
        
        seasonAndEpisodeLabel.anchor(top: seasonAndEpisodeTextField.myTextField.topAnchor, leading: seasonAndEpisodeTextField.myTextField.leadingAnchor,
                                     bottom: seasonAndEpisodeTextField.myTextField.bottomAnchor, trailing: seasonAndEpisodeTextField.myTextField.trailingAnchor)
        
        progressIndicator.fillSuperview()
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleAddEpisode() {
        uploadImageData()
    }

}
