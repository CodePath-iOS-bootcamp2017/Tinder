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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    fileprivate func setupUI(){
        self.cardInitialCenter = CGPoint(x: self.cardImageView.center.x, y: self.cardImageView.center.y)
        
        self.cardImageView.layer.cornerRadius = 5
        self.cardImageView.layer.masksToBounds = true
        
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(didPanCard(_:)))
        self.cardImageView.addGestureRecognizer(panGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didPanCard(_ sender: UIPanGestureRecognizer) {
        if let cardImage = sender.view as? UIImageView{
            // let location = sender.location(in: view)
            // let velocity = sender.velocity(in: view)
            let translation = sender.translation(in: view)
            print(translation.x)
            let angle = Double(30*translation.x/200)
            let rotation = CGFloat( angle * M_PI / 180)
            
            if sender.state == .began {
                //            print("Gesture began")
//                cardImage.center = CGPoint(x:cardImage.center.x + translation.x, y:cardImage.center.y + translation.y)
            } else if sender.state == .changed {
                //            print("Gesture is changing")
                UIView.animate(withDuration: 1, animations: {
                    cardImage.center = CGPoint(x:cardImage.center.x + translation.x, y:cardImage.center.y + translation.y)
                    cardImage.transform = cardImage.transform.rotated(by: rotation)
                })
            } else if sender.state == .ended {
                if translation.x > -150 && translation.x < 150  {
                    UIView.animate(withDuration: 0.75, animations: {
                        self.cardImageView.transform = CGAffineTransform.identity
                        self.cardImageView.center = self.cardInitialCenter
                    })
                }
            }
        }
        
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
