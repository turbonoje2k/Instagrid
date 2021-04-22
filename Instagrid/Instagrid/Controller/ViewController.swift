//
//  ViewController.swift
//  Instagrid
//
//  Created by noje on 16/03/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonLayout1: UIButton!
    @IBOutlet weak var buttonLayout2: UIButton!
    @IBOutlet weak var buttonLayout3: UIButton!
    @IBOutlet weak var swipeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLayout1.setImage(UIImage(named: "Layout1"), for: .normal)
        buttonLayout2.setImage(UIImage(named: "Layout2"), for: .normal)
        buttonLayout3.setImage(UIImage(named: "Layout3"), for: .normal)
        
        buttonLayout1.setImage(UIImage(named: "layoutSelected"), for: .selected)
        buttonLayout2.setImage(UIImage(named: "layoutSelected2"), for: .selected)
        buttonLayout3.setImage(UIImage(named: "layoutSelected3"), for: .selected)
        swipeLabel.isUserInteractionEnabled = true 
        
        let gestureSwipeTop = UISwipeGestureRecognizer(target: self, action: #selector(returnToSwipeGesture))
        gestureSwipeTop.direction = UISwipeGestureRecognizer.Direction.up
        swipeLabel.addGestureRecognizer(gestureSwipeTop)
        
        let gestureSwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(returnToSwipeGesture))
        gestureSwipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        swipeLabel.addGestureRecognizer(gestureSwipeLeft)
    }
    
    @objc func returnToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .up:
                print("swipe top")
            case  .left:
                print("swipe left")
            default:
                break
            }
        }
    }
}

