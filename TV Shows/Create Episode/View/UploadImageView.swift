import UIKit

class UploadImageView: BaseView {
    
    weak var currentVC: CreateEpisodeController?
    
    let cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "ic-camera")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleUploadImage), for: .touchUpInside)
        return button
    }()
    
    let uploadImageLabel: UILabel = {
        let label = UILabel()
        label.text = "Upload photo"
        label.textColor = .color(key: .buttonLogInEnabled)
        label.textAlignment = .center
        return label
    }()
    
    lazy var addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleUploadImage), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    var currentImage: UIImage?
    var currentImageUrl: String?
    
    override func setupViews() {
        addSubview(cameraButton)
        addSubview(uploadImageLabel)
        addSubview(addImageButton)
        
        cameraButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, size: .init(width: 24, height: 24))
        cameraButton.anchorCenterXToSuperview()
        uploadImageLabel.anchor(top: cameraButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 22))
        
        addImageButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 58, height: 58))
        addImageButton.anchorCenterSuperview()
        addImageButton.alpha = 0
        roundCornerPickImage()
    }
    
    func roundCornerPickImage() {
        addImageButton.layer.cornerRadius = 29
        addImageButton.layer.borderColor = UIColor.color(key: .buttonLogInEnabled).cgColor
        addImageButton.layer.borderWidth = 2
        addImageButton.clipsToBounds = true
    }
    
    @objc func handleUploadImage() {
        let alert = UIAlertController(title: "Upload image", message: "Select option for uploading image", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                 self.handleSelectImageFrom(.photoLibrary)
                return
            }
            self.handleSelectImageFrom(.camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Library Photos", style: .default , handler:{ (UIAlertAction)in
            self.handleSelectImageFrom(.photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        
        currentVC?.present(alert, animated: true)
    }
    
}
