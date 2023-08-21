//
//  HomeViewController.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 15/08/23.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ApiService().loadProfile { data, error in
            if let profileData = data {
                UserDefaults.standard.set(profileData.image, forKey: Constant.kImage)
                UserDefaults.standard.set(profileData.firstname, forKey: Constant.kFirstnameKey)
                UserDefaults.standard.set(profileData.lastname, forKey: Constant.kLastnameKey)
                UserDefaults.standard.set(profileData.email, forKey: Constant.kEmail)
                UserDefaults.standard.set(profileData.phone , forKey: Constant.kPhone)
                DispatchQueue.global().async {
                    let imageData = try? Data(contentsOf: URL(string: Constant.image as! String)!)
                    if let imageData = imageData {
                        DispatchQueue.main.async { [self] in
                            userImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            } else {
                print(error ?? "error")
            }
            self.nameLabel.text = "\(Constant.firstName ?? "")"
        }
    }
}

extension UIViewController {
    func showHomeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Tab")
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
