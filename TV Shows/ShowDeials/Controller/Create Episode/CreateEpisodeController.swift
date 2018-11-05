import UIKit

class CreateEpisodeController: UIViewController {
    
    fileprivate lazy var uploadImageView: UploadImageView = {
        let uploadView = UploadImageView()
        uploadView.currentVC = self
        return uploadView
    }()
    
    lazy var episodeTitleTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldMode = .email
        textField.placeholderLabel.text = "Episode title"
        textField.myTextField.textColor = .color(key: .buttonLogInEnabled)
        return textField
    }()
    
    lazy var seasonAndEpisodeTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldMode = .email
        textField.placeholderLabel.text = "Season & Episode"
        textField.delegate = self
        textField.myTextField.textColor = .color(key: .buttonLogInEnabled)
        textField.updateTextField(text: "8 & 6")
        return textField
    }()
    
    lazy var seasonAndEpisodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Season 8, Ep 6"
        label.textColor = .color(key: .buttonLogInEnabled)
        label.textAlignment = .right
        return label
    }()
    
    lazy var episodeDescriptionTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldMode = .email
        textField.placeholderLabel.text = "Episode description"
        textField.myTextField.textColor = .color(key: .buttonLogInEnabled)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavBar()
        setupViews()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Add episode"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = .color(key: .buttonLogInEnabled)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAddEpisode))
        navigationItem.rightBarButtonItem?.tintColor = .color(key: .buttonLogInEnabled)
    }
    
    fileprivate func setupViews() {
        view.addSubview(uploadImageView)
//        view.addSubview(episodeTitleTextField)
//        view.addSubview(seasonAndEpisodeTextField)
        view.addSubview(seasonAndEpisodeLabel)
//        view.addSubview(episodeDescriptionTextField)
        
        uploadImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
                               padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 60))

//        episodeTitleTextField.anchor(top: uploadImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
//                                     padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 64))
//        seasonAndEpisodeTextField.anchor(top: episodeTitleTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
//                                        size: .init(width: 0, height: 64))
//        seasonAndEpisodeLabel.anchor(top: seasonAndEpisodeTextField.topAnchor, leading: seasonAndEpisodeTextField.leadingAnchor,
//                                     bottom: seasonAndEpisodeTextField.bottomAnchor, trailing: seasonAndEpisodeTextField.trailingAnchor)
//        episodeDescriptionTextField.anchor(top: seasonAndEpisodeTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
//                                           size: .init(width: 0, height: 64))
        
        let stackView = UIStackView(arrangedSubviews: [episodeTitleTextField, seasonAndEpisodeTextField, episodeDescriptionTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        view.addSubview(stackView)
        stackView.anchor(top: uploadImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 192))
        
        seasonAndEpisodeLabel.anchor(top: seasonAndEpisodeTextField.myTextField.topAnchor, leading: seasonAndEpisodeTextField.myTextField.leadingAnchor,
                                     bottom: seasonAndEpisodeTextField.myTextField.bottomAnchor, trailing: seasonAndEpisodeTextField.myTextField.trailingAnchor,
                                     padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        

    }
    
    @objc func handleCancel() {
        print("cancel")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleAddEpisode() {
        print("Add episode")
    }
    
}

extension CreateEpisodeController: TextDidChangeDelegate {
    
    func textDidChange(onType: CustomTextFieldView.TextFieldMode, text: String) {
        print(text)
        
        let textArray = text.components(separatedBy: "&")
        
        if textArray.count > 0 && textArray.count < 2 {
            let season: String = textArray[0].replacingOccurrences(of: " ", with: "")
            seasonAndEpisodeLabel.text = "Season \(season), Ep"
        } else if textArray.count > 1 && textArray.count < 3 {
            let season: String = textArray[0].replacingOccurrences(of: " ", with: "")
            let episode: String = textArray[1].replacingOccurrences(of: " ", with: "")
            seasonAndEpisodeLabel.text = "Season \(season), Ep \(episode)"
        }
    }
    
    
}

