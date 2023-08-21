//
//  ViewController.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 11/08/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailSeparator: UIView!
    
    @IBOutlet weak var passIcon: UIImageView!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var passSeparator: UIView!
    @IBOutlet weak var showPassButton: UIButton!
    
    @IBOutlet weak var forgotPassButton: UIButton!
    
    @IBOutlet weak var loginButton: RoundedButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    func isEmailValid(email: String) -> Bool {
        return email.isEmail
    }
    
    func isPasswordValid(password: String) -> Bool {
//        return password.isSecurePassword
        return password.count > 3
    }
    
    func validate(email: String, password: String){
        let isValid = isEmailValid(email: email) && isPasswordValid(password: password)
        setLoginButton(enabled: isValid)
    }
    
    func setLoginButton(enabled: Bool) {
        loginButton.isEnabled = enabled
        switch enabled {
        case true:
            loginButton.backgroundColor = UIColor(named: "Primary")
            loginButton.setTitleColor(UIColor.white, for: .normal)
        case false:
            loginButton.backgroundColor = UIColor(named: "ButtonDefault")
            loginButton.setTitleColor(UIColor(named: "LoginDefault"), for: .normal)
        }
    }
    
    func setup() {
        cardView.layer.cornerRadius = 32
        
        emailTextField.delegate = self
        passTextField.delegate = self
        
        loginButton.isEnabled = false
        
        let text1 = "Don’t have an account? Let's"
        let text2 = "Sign Up"
        
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
        signUpButton.setAttributedTitle(attText, for: .normal)
    }
    
    @IBAction func showPassButton(_ sender: Any) {
        let isSecureTextEntry = passTextField.isSecureTextEntry
        passTextField.isSecureTextEntry = !isSecureTextEntry
    }
    @IBAction func forgotPassButtonTapped(_ sender: Any) {
        showForgotPassFirstViewController()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        view.endEditing(true)
        ApiService().login(email: emailTextField.text!, password: passTextField.text!) { data, error in
            if let loginData = data {
                UserDefaults.standard.set(loginData.token, forKey: Constant.kAccessTokenKey)
                self.showHomeViewController()
            }
            else {
                let alertController = UIAlertController(title: "Error", message: "Your email or password is wrong", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) {
                    (action: UIAlertAction!) in
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
        
        @IBAction func signUpButtonTapped(_ sender: Any) {
            showSignUpViewController()
        }
        
    }

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        switch textField {
        case emailTextField:
            validate(email: text, password: passTextField.text ?? "")
        case passTextField:
            validate(email: emailTextField.text ?? "", password: text)
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
        case passTextField:
            passIcon.tintColor = UIColor(named: "Primary")
            passSeparator.backgroundColor = UIColor(named: "Primary")
            
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
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Login")
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
