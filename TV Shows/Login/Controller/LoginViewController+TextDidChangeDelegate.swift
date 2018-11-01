import Foundation

extension LoginViewController: TextDidChangeDelegate{
    
    func textDidChange(onType: CustomTextFieldView.TextFieldMode, text: String) {
        if onType == .email {
            userEmail = text
        } else {
            userPassword = text
        }
        
        updateLoginButtonColor()
    }
    
}
