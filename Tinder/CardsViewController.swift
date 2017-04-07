//
//  CardsViewController.swift
//  Tinder
//
//  Created by Satyam Jaiswal on 4/4/17.
//  Copyright © 2017 Satyam Jaiswal. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var navBarImageView: UIImageView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var actionsImageView: UIImageView!
    
    var cardInitialCenter: CGPoint!
    var fadeTransition: FadeTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    fileprivate func setupUI(){
        print("card center y: \(self.cardImageView.center.y)")
        self.cardInitialCenter = CGPoint(x: self.cardImageView.center.x, y: self.cardImageView.center.y)
        
        self.cardImageView.layer.cornerRadius = 5
        self.cardImageView.layer.masksToBounds = true
        
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(didPanCard(_:)))
        self.cardImageView.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(didTapCard(_:)))
        self.cardImageView.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapCard(_ sender: UITapGestureRecognizer){
        performSegue(withIdentifier: "showProfile", sender: sender)
    }
    
    func didPanCard(_ sender: UIPanGestureRecognizer) {
        if let cardImage = sender.view as? UIImageView{
             let location = sender.location(in: view)
            // let velocity = sender.velocity(in: view)
            let translation = sender.translation(in: view)
            print(translation.x)
            let angle = Double(30*translation.x/200)
            var rotation = CGFloat( angle * M_PI / 180)
            
            if sender.state == .began {
                //            print("Gesture began")
//                cardImage.center = CGPoint(x:cardImage.center.x + translation.x, y:cardImage.center.y + translation.y)
            } else if sender.state == .changed {
                //            print("Gesture is changing")
                var buffer: CGFloat = 50
                if translation.x<0{
                    buffer = -50
                }
                
                if location.y > self.cardInitialCenter.y {
                    rotation = 0-rotation
                }
                UIView.animate(withDuration: 1, animations: {
                    cardImage.center = CGPoint(x:cardImage.center.x + translation.x + buffer, y:cardImage.center.y + translation.y)
                    cardImage.transform = cardImage.transform.rotated(by: rotation)
                })
            } else if sender.state == .ended {
                if translation.x > -50 && translation.x < 50  {
                    UIView.animate(withDuration: 0.75, animations: {
                        self.cardImageView.transform = CGAffineTransform.identity
                        self.cardImageView.center = self.cardInitialCenter
                    })
                }
            }
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfile" {
            let vc = segue.destination as! ProfileViewController
            vc.profileImage = self.cardImageView.image
            
            //custom modal presentation
            vc.modalPresentationStyle = UIModalPresentationStyle.custom
            fadeTransition = FadeTransition()
            vc.transitioningDelegate = fadeTransition
            fadeTransition.duration = 0.5
            
        }
    }
    

}
