//
//  ResourcesViewController.swift
//  Final Project - Blossom
//  Resources icon provided by the following website:
//  https://www.flaticon.com/free-icon/human-resources_1322254#term=resources&page=1&position=77
//  Created by Emma Woodburn on 12/2/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit
import SafariServices

class ResourcesViewController: UIViewController, SFSafariViewControllerDelegate {
    
    //@IBOutlet var resourcesLinkLabel: UILabel!
    //@IBOutlet var resourchesLinkTextView: UITextView!
    
    let urlString = "https://www.nami.org/Find-Support/NAMI-HelpLine/Top-25-HelpLine-Resources"


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
        //displayInformation()
    }
    
    @IBAction func displayInformation(_ sender: UIButton){
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            vc.delegate = self
            
            present(vc, animated: true)
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
