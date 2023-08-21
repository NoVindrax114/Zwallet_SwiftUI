//
//  ForgotPassSecondViewController.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 16/08/23.
//

import UIKit

class ForgotPassSecondViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var newPassIcon: UIImageView!
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var newPassSeparator: UIView!
    @IBOutlet weak var showNewPassButton: UIButton!
    
    @IBOutlet weak var confirmPassIcon: UIImageView!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var confirmPassSeparator: UIView!
    @IBOutlet weak var showConfirmPassButton: UIButton!
    
    @IBOutlet weak var resetPassButton: RoundedButton!
    
    var emailResetPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        return password.count > 3
    }
    
    func isPasswordSame(newPassword: String, confirmPassword: String) -> Bool {
        return newPassword == confirmPassword
    }
    
    func setResetPassButton(enabled: Bool) {
        resetPassButton.isEnabled = enabled
        switch enabled {
        case true:
            resetPassButton.backgroundColor = UIColor(named: "Primary")
            resetPassButton.setTitleColor(UIColor.white, for: .normal)
        case false:
            resetPassButton.backgroundColor = UIColor(named: "ButtonDefault")
            resetPassButton.setTitleColor(UIColor(named: "LoginDefault"), for: .normal)
        }
    }
    
    func validate(newPassword: String, confirmPassword: String){
        let isValid = isPasswordValid(newPassword) && isPasswordValid(confirmPassword)
        setResetPassButton(enabled: isValid)
    }
    
    func setup() {
        cardView.layer.cornerRadius = 32
        
        newPassTextField.delegate = self
        confirmPassTextField.delegate = self
        
        resetPassButton.isEnabled = false
    }
    
    @IBAction func showNewPass(_ sender: Any) {
        let isSecureTextEntry = newPassTextField.isSecureTextEntry
        newPassTextField.isSecureTextEntry = !isSecureTextEntry
    }
    
    @IBAction func showConfirmPass(_ sender: Any) {
        let isSecureTextEntry = confirmPassTextField.isSecureTextEntry
        confirmPassTextField.isSecureTextEntry = !isSecureTextEntry
    }
    @IBAction func resetPassButtonTapped(_ sender: Any) {
        if newPassTextField.text == confirmPassTextField.text {
            ApiService().resetPassword(email: self.emailResetPassword, newPassword: newPassTextField.text!, completion: { data, error in
                if let resetPassData = data {
                    let message = resetPassData.message
                    let status = resetPassData.status
                    
                    switch status {
                    case 200...299:
                        let alertController = UIAlertController(title: "Reset Password Success", message: "Please login with your new password", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) {
                            (action: UIAlertAction!) in
                            self.showLoginViewController()
                        }
                        alertController.addAction(OKAction)
                        self.present(alertController, animated: true, completion: nil)
                    default:
                        let alertController = UIAlertController(title: "Reset Password Error, Status not 200", message: message, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) {
                            (action: UIAlertAction!) in
                        }
                        alertController.addAction(OKAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                } else {
                    let alertController = UIAlertController(title: "Reset Password Error", message: "Error", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) {
                        (action: UIAlertAction!) in
                    }
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
            })
        } else {
            let alertController = UIAlertController(title: "Reset Password Failed", message: "The password didn't match", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction!) in
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}

extension ForgotPassSecondViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        switch textField {
        case newPassTextField:
            validate(newPassword: text, confirmPassword: confirmPassTextField.text ?? "")
        case confirmPassTextField:
            validate(newPassword: newPassTextField.text ?? "", confirmPassword: text)
        default:
            break
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case newPassTextField:
            newPassIcon.tintColor = UIColor(named: "Primary")
            newPassSeparator.backgroundColor = UIColor(named: "Primary")
        case confirmPassTextField:
            confirmPassIcon.tintColor = UIColor(named: "Primary")
            confirmPassSeparator.backgroundColor = UIColor(named: "Primary")
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case newPassTextField:
            if !(newPassTextField.text ?? "").isEmpty {
                newPassIcon.tintColor = UIColor(named: "Primary")
                newPassSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                newPassIcon.tintColor = UIColor.separator
                newPassSeparator.backgroundColor = UIColor.separator
            }
        case confirmPassTextField:
            if !(confirmPassTextField.text ?? "").isEmpty {
                confirmPassIcon.tintColor = UIColor(named: "Primary")
                confirmPassSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                confirmPassIcon.tintColor = UIColor.separator
                confirmPassSeparator.backgroundColor = UIColor.separator
            }
        default:
            break
        }
    }
}

extension UIViewController {
    func showForgotPassSecondViewController(emailResetPassword: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ForgotPass2") as? ForgotPassSecondViewController
        viewController?.emailResetPassword = emailResetPassword
        navigationController?.setViewControllers([viewController!], animated: true)
    }
}
