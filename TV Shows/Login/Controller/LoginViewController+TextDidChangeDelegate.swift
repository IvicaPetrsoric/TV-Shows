import Foundation

extension LoginViewController: TextDidChangeDelegate{
    
    func textDidChange(onType: CustomTextFieldView.TextFieldMode, text: String) {
        if onType == .email {
            emailText = text
        } else {
            passwordText = text
        }
        
        updateLoginButtonColor()
    }
    
}
