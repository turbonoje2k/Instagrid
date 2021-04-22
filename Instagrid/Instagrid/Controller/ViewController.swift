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
    @IBOutlet weak var swipe: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLayout1.setImage(UIImage(named: "Layout1"), for: .normal)
        buttonLayout2.setImage(UIImage(named: "Layout2"), for: .normal)
        buttonLayout3.setImage(UIImage(named: "Layout3"), for: .normal)
        
        buttonLayout1.setImage(UIImage(named: "layoutSelected"), for: .selected)
        buttonLayout2.setImage(UIImage(named: "layoutSelected2"), for: .selected)
        buttonLayout3.setImage(UIImage(named: "layoutSelected3"), for: .selected)
        
        let swipeTop = UISwipeGestureRecognizer(target: self, action: #selector(swipe.returnToSwipeGesture))
        swipeTop.direction = UISwipeGestureRecognizer.Direction.up
        swipe.view.addGestureRecognizer(swipeTop)
        
        let swipeLeft = UISwipeGestureRecognizer(target: swipe, action: #selector(swipe.returnToSwipeGesture))
        swipeTop.direction = UISwipeGestureRecognizer.Direction.left
        swipe.view.addGestureRecognizer(swipeLeft)
    }
    
    func returnToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Up:
                print("swipe top")
            case  UISwipeGestureRecognizer.Left:
                print("swipe left")
            default:
                break
            }
        }
    }
}

