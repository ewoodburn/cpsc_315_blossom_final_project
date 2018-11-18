//
//  LoginViewController.swift
//  Final Project - Blossom
//  Icon from https://www.flaticon.com/free-icon/lotus-flower_1151960#term=flower&page=1&position=5
//  Created by Emma Woodburn on 11/17/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //setting up all the UI components
    @IBOutlet var blossomHeaderLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var blossomSloganLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        iconImageView.image = UIImage(named: "blossomIcon.png")
    }

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier{
            if identifier == "LoginSegue"{
                print("segue from login segue to activity log view controller")
            }
        }
    }


}
