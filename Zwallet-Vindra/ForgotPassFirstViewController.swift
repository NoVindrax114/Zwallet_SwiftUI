//
//  ForgotPassFirstViewController.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 16/08/23.
//

import UIKit

class ForgotPassFirstViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailSeparator: UIView!
    @IBOutlet weak var confirmButton: RoundedButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func isEmailValid(email: String) -> Bool {
        return email.isEmail
    }
    
    func setConfirmButton(enabled: Bool) {
        confirmButton.isEnabled = enabled
        switch enabled {
        case true:
            confirmButton.backgroundColor = UIColor(named: "Primary")
            confirmButton.setTitleColor(UIColor.white, for: .normal)
        case false:
            confirmButton.backgroundColor = UIColor(named: "ButtonDefault")
            confirmButton.setTitleColor(UIColor(named: "LoginDefault"), for: .normal)
        }
    }
    
    func validate(email: String){
        let isValid = isEmailValid(email: email)
        setConfirmButton(enabled: isValid)
    }
    
    func setup() {
        cardView.layer.cornerRadius = 32
        
        emailTextField.delegate = self
        
        confirmButton.isEnabled = false
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        showForgotPassSecondViewController(emailResetPassword: emailTextField.text!)
    }
}

extension ForgotPassFirstViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        switch textField {
        case emailTextField:
            validate(email: text)
        default:
            break
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            emailIcon.tintColor = UIColor(named: "Primary")
            emailSeparator.backgroundColor = UIColor(named: "Primary")
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case emailTextField:
            if !(emailTextField.text ?? "").isEmpty {
                emailIcon.tintColor = UIColor(named: "Primary")
                emailSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                emailIcon.tintColor = UIColor.separator
                emailSeparator.backgroundColor = UIColor.separator
            }
        default:
            break
        }
    }
}

extension UIViewController {
    func showForgotPassFirstViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ForgotPass1")
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
