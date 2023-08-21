//
//  OTPViewController.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 13/08/23.
//

import UIKit

class OTPViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var otpTextField1: UITextField!
    @IBOutlet weak var otpTextField2: UITextField!
    @IBOutlet weak var otpTextField3: UITextField!
    @IBOutlet weak var otpTextField4: UITextField!
    @IBOutlet weak var otpTextField5: UITextField!
    @IBOutlet weak var otpTextField6: UITextField!
    
    @IBOutlet weak var confirmButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func isOTPValid(_ otp1: String, _ otp2: String, _ otp3: String, _ otp4: String, _ otp5: String, _ otp6: String) -> Bool {
        return otp1.count == 1 && otp2.count == 1 && otp3.count == 1 && otp4.count == 1 && otp5.count == 1 && otp6.count == 1
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
    
    func validate(_ otp1: String, _ otp2: String, _ otp3: String, _ otp4: String, _ otp5: String, _ otp6: String){
        let isValid = isOTPValid(otp1, otp2, otp3, otp4, otp5, otp6)
        setConfirmButton(enabled: isValid)
    }
    
    func setup() {
        cardView.layer.cornerRadius = 32
        
        otpTextField1.delegate = self
        otpTextField2.delegate = self
        otpTextField3.delegate = self
        otpTextField4.delegate = self
        otpTextField5.delegate = self
        otpTextField6.delegate = self
    
        confirmButton.isEnabled = false
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "New Account Created", message: "Please login with your new account", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction!) in
            self.showLoginViewController()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension OTPViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        if text.count == 1 {
            switch textField {
            case otpTextField1:
                otpTextField1.text = text
                validate(text, otpTextField2.text ?? "", otpTextField3.text ?? "", otpTextField4.text ?? "", otpTextField5.text ?? "", otpTextField6.text ?? "")
                otpTextField2.becomeFirstResponder()
            case otpTextField2:
                otpTextField2.text = text
                validate(otpTextField1.text ?? "", text, otpTextField3.text ?? "", otpTextField4.text ?? "", otpTextField5.text ?? "", otpTextField6.text ?? "")
                otpTextField3.becomeFirstResponder()
            case otpTextField3:
                otpTextField3.text = text
                validate(otpTextField1.text ?? "", otpTextField2.text ?? "", text, otpTextField4.text ?? "", otpTextField5.text ?? "", otpTextField6.text ?? "")
                otpTextField4.becomeFirstResponder()
            case otpTextField4:
                otpTextField4.text = text
                validate(otpTextField1.text ?? "", otpTextField2.text ?? "", otpTextField3.text ?? "", text, otpTextField5.text ?? "", otpTextField6.text ?? "")
                otpTextField5.becomeFirstResponder()
            case otpTextField5:
                otpTextField5.text = text
                validate(otpTextField1.text ?? "", otpTextField2.text ?? "", otpTextField3.text ?? "", otpTextField4.text ?? "", text, otpTextField6.text ?? "")
                otpTextField6.becomeFirstResponder()
            case otpTextField6:
                otpTextField6.text = text
                validate(otpTextField1.text ?? "", otpTextField2.text ?? "", otpTextField3.text ?? "", otpTextField4.text ?? "", otpTextField5.text ?? "", text)
                otpTextField6.resignFirstResponder()
            default:
                break
            }
            return true
        } else if text.count == 0 {
            switch textField {
            case otpTextField1:
                validate(text, otpTextField2.text ?? "", otpTextField3.text ?? "", otpTextField4.text ?? "", otpTextField5.text ?? "", otpTextField6.text ?? "")
            case otpTextField2:
                validate(otpTextField1.text ?? "", text, otpTextField3.text ?? "", otpTextField4.text ?? "", otpTextField5.text ?? "", otpTextField6.text ?? "")
            case otpTextField3:
                validate(otpTextField1.text ?? "", otpTextField2.text ?? "", text, otpTextField4.text ?? "", otpTextField5.text ?? "", otpTextField6.text ?? "")
            case otpTextField4:
                validate(otpTextField1.text ?? "", otpTextField2.text ?? "", otpTextField3.text ?? "", text, otpTextField5.text ?? "", otpTextField6.text ?? "")
            case otpTextField5:
                validate(otpTextField1.text ?? "", otpTextField2.text ?? "", otpTextField3.text ?? "", otpTextField4.text ?? "", text, otpTextField6.text ?? "")
            case otpTextField6:
                validate(otpTextField1.text ?? "", otpTextField2.text ?? "", otpTextField3.text ?? "", otpTextField4.text ?? "", otpTextField5.text ?? "", text)
            default:
                break
            }
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case otpTextField1:
            otpTextField1.layer.borderColor = UIColor(named: "Primary")?.cgColor
        case otpTextField2:
            otpTextField2.layer.borderColor = UIColor(named: "Primary")?.cgColor
        case otpTextField3:
            otpTextField3.layer.borderColor = UIColor(named: "Primary")?.cgColor
        case otpTextField4:
            otpTextField4.layer.borderColor = UIColor(named: "Primary")?.cgColor
        case otpTextField5:
            otpTextField5.layer.borderColor = UIColor(named: "Primary")?.cgColor
        case otpTextField6:
            otpTextField6.layer.borderColor = UIColor(named: "Primary")?.cgColor
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case otpTextField1:
            if !(otpTextField1.text ?? "").isEmpty {
                otpTextField1.layer.borderColor = UIColor.blue.cgColor
            } else {
                otpTextField1.layer.borderColor = UIColor.separator.cgColor
            }
        case otpTextField2:
            if !(otpTextField2.text ?? "").isEmpty {
                otpTextField2.layer.borderColor = UIColor(named: "Primary")?.cgColor
            } else {
                otpTextField2.layer.borderColor = UIColor.separator.cgColor
            }
        case otpTextField3:
            if !(otpTextField3.text ?? "").isEmpty {
                otpTextField3.layer.borderColor = UIColor(named: "Primary")?.cgColor
            } else {
                otpTextField3.layer.borderColor = UIColor.separator.cgColor
            }
        case otpTextField4:
            if !(otpTextField4.text ?? "").isEmpty {
                otpTextField4.layer.borderColor = UIColor(named: "Primary")?.cgColor
            } else {
                otpTextField4.layer.borderColor = UIColor.separator.cgColor
            }
        case otpTextField5:
            if !(otpTextField5.text ?? "").isEmpty {
                otpTextField5.layer.borderColor = UIColor(named: "Primary")?.cgColor
            } else {
                otpTextField5.layer.borderColor = UIColor.separator.cgColor
            }
        case otpTextField6:
            if !(otpTextField6.text ?? "").isEmpty {
                otpTextField6.layer.borderColor = UIColor(named: "Primary")?.cgColor
            } else {
                otpTextField6.layer.borderColor = UIColor.separator.cgColor
            }
        default:
            break
        }
    }
}

extension UIViewController {
    func showOTPViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Otp")
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
