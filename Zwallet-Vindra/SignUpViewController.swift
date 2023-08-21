//
//  SignUpViewController.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 13/08/23.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var usernameIcon: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameSeparator: UIView!
    
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailSeparator: UIView!
    
    @IBOutlet weak var passIcon: UIImageView!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var passSeparator: UIView!
    @IBOutlet weak var showPassButton: UIButton!
    
    @IBOutlet weak var signUpButton: RoundedButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    func isUsernameValid(username: String) -> Bool {
        return username.isUsername
    }
    
    func isEmailValid(email: String) -> Bool {
        return email.isEmail
    }
    
    func isPasswordValid(password: String) -> Bool {
        return password.isSecurePassword
    }
    
    func validate(username: String, email: String, password: String){
        let isValid = isUsernameValid(username: username) && isEmailValid(email: email) && isPasswordValid(password: password)
        setSignUpButton(enabled: isValid)
    }
    
    func setSignUpButton(enabled: Bool) {
        signUpButton.isEnabled = enabled
        switch enabled {
        case true:
            signUpButton.backgroundColor = UIColor(named: "Primary")
            signUpButton.setTitleColor(UIColor.white, for: .normal)
        case false:
            signUpButton.backgroundColor = UIColor(named: "ButtonDefault")
            signUpButton.setTitleColor(UIColor(named: "LoginDefault"), for: .normal)
        }
        
    }
    func setup() {
        cardView.layer.cornerRadius = 32
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passTextField.delegate = self
        
        signUpButton.isEnabled = false

        
        let text1 = "Already have an account? Let’s"
        let text2 = "Login"
        
        let attText = NSMutableAttributedString(string: "\(text1) \(text2)")
        attText.addAttributes(
            [
                .foregroundColor: UIColor(named: "Text80")!,
                .font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ], range: NSString(string: attText.string).range(of: text1)
        )
        attText.addAttributes(
            [
                .foregroundColor: UIColor(named: "Primary")!,
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
            ], range: NSString(string: attText.string).range(of: text2)
        )
        loginButton.setAttributedTitle(attText, for: .normal)
    }
    
    @IBAction func showPassButtonTapped(_ sender: Any) {
        let isSecureTextEntry = passTextField.isSecureTextEntry
        passTextField.isSecureTextEntry = !isSecureTextEntry
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        ApiService().signUp(username: usernameTextField.text!, email: emailTextField.text!, password: passTextField.text!) { data, error in
            if let signUpData = data {
                let message = signUpData.message
                let status = signUpData.status
                
                switch status {
                case 200:
                    self.showOTPViewController()
                default:
                    let alertController = UIAlertController(title: "Sign Up Error", message: message, preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) {
                        (action: UIAlertAction!) in
                    }
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                let alertController = UIAlertController(title: "Sign Up Error", message: "Error", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) {
                    (action: UIAlertAction!) in
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        showLoginViewController()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        switch textField {
        case usernameTextField:
            validate(username: text, email: emailTextField.text ?? "", password: passTextField.text ?? "")
        case emailTextField:
            validate(username: usernameTextField.text ?? "", email: text, password: passTextField.text ?? "")
        case passTextField:
            validate(username: usernameTextField.text ?? "", email: emailTextField.text ?? "", password: text)
        default:
            break
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case usernameTextField:
            usernameIcon.tintColor = UIColor(named: "Primary")
            usernameSeparator.backgroundColor = UIColor(named: "Primary")
        case emailTextField:
            emailIcon.tintColor = UIColor(named: "Primary")
            emailSeparator.backgroundColor = UIColor(named: "Primary")
        case passTextField:
            passIcon.tintColor = UIColor(named: "Primary")
            passSeparator.backgroundColor = UIColor(named: "Primary")
            
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case usernameTextField:
            if !(usernameTextField.text ?? "").isEmpty {
                usernameIcon.tintColor = UIColor(named: "Primary")
                usernameSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                usernameIcon.tintColor = UIColor.separator
                usernameSeparator.backgroundColor = UIColor.separator
            }
        case emailTextField:
            if !(emailTextField.text ?? "").isEmpty {
                emailIcon.tintColor = UIColor(named: "Primary")
                emailSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                emailIcon.tintColor = UIColor.separator
                emailSeparator.backgroundColor = UIColor.separator
            }
        case passTextField:
            if !(passTextField.text ?? "").isEmpty {
                passIcon.tintColor = UIColor(named: "Primary")
                passSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                passIcon.tintColor = UIColor.separator
                passSeparator.backgroundColor = UIColor.separator
            }
        default:
            break
        }
    }
}

extension UIViewController {
    func showSignUpViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Signup")
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
