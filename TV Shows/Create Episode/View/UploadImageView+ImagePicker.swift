import UIKit

extension UploadImageView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    func handleSelectImageFrom(_ source: ImageSource){
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        
        currentVC?.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            addImageButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            currentImage = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            addImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
            currentImage = originalImage
        }
        
        updateViews()
        roundCornerPickImage()
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func updateViews() {
        if cameraButton.alpha == 1 {
            addImageButton.alpha = 1
            cameraButton.alpha = 0
            uploadImageLabel.alpha = 0
        }
    }
    
}
