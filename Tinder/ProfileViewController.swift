//
//  ProfileViewController.swift
//  Tinder
//
//  Created by Satyam Jaiswal on 4/6/17.
//  Copyright © 2017 Satyam Jaiswal. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var navBarImageView: UIImageView!
    
    var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = profileImage{
            self.profileImageView.image = image
        }
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(didTap(_:)))
        self.navBarImageView.addGestureRecognizer(tapGesture)
        self.navBarImageView.isUserInteractionEnabled = true
    }
    
    func didTap(_ sender: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
