//
//  ProfileViewController.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 15/08/23.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var phoneUserLabel: UILabel!
    
    @IBOutlet weak var personalInfoButton: RoundedButton!
    @IBOutlet weak var changePasswordButton: RoundedButton!
    @IBOutlet weak var changePinButton: RoundedButton!
    @IBOutlet weak var logoutButton: RoundedButton!
    
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var switchButton: UISwitch!
    
    var token = Constant.token
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        notificationView.layer.cornerRadius = 12
        phoneUserLabel.text = "123456"
        
//        imageViewUser.kf.setImage(with: URL(string: "\(Constant.baseURL)\(Constant.image)"))
        DispatchQueue.global().async {
            let imageData = try? Data(contentsOf: URL(string: Constant.image as! String)!)
            if let imageData = imageData {
                DispatchQueue.main.async { [self] in
                    imageViewUser.image = UIImage(data: imageData)
                }
            }
        }
        nameUserLabel.text = "\(Constant.firstName ?? "") \(Constant.lastName ?? "")"
    }
    
    @IBAction func switchButtonTapped(_ sender: Any) {
        let state = switchButton.isOn
        switch state {
        case true:
            personalInfoButton.backgroundColor = UIColor(named: "ButtonDefault")
            changePasswordButton.backgroundColor = UIColor(named: "ButtonDefault")
            changePinButton.backgroundColor = UIColor(named: "ButtonDefault")
            notificationView.layer.backgroundColor = UIColor(named: "ButtonDefault")?.cgColor
            logoutButton.backgroundColor = UIColor(named: "ButtonDefault")
            logoutButton.contentHorizontalAlignment = .leading
            logoutButton.setTitleColor(UIColor(named: "Text80"), for: .normal)
        case false:
            personalInfoButton.backgroundColor = UIColor.white
            changePasswordButton.backgroundColor = UIColor.white
            changePinButton.backgroundColor = UIColor.white
            notificationView.layer.backgroundColor = UIColor.white.cgColor
            logoutButton.backgroundColor = UIColor.white
            
            logoutButton.contentHorizontalAlignment = .center
            logoutButton.setTitleColor(UIColor(named: "Error"), for: .normal)
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure want to logout?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) {
            (action: UIAlertAction!) in
            ApiService().logout(token: self.token) { data in
                if let logoutData = data {
                    let alert = UIAlertController(title: "Logout Succes", message: logoutData.message, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default) { _ in
                        self.showLoginViewController()
                    }
                    alert.addAction(ok)
                    self.present(alert, animated: true)
                }
            }
        }
        let noAction = UIAlertAction(title: "No", style: .cancel) {
            (action: UIAlertAction!) in
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
        UserDefaults.standard.set(nil, forKey: "AccessToken")
    }
}

