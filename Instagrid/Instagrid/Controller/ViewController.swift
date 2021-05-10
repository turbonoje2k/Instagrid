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
    
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLayout1.setImage(UIImage(named: "Layout1"), for: .normal)
        buttonLayout2.setImage(UIImage(named: "Layout2"), for: .normal)
        buttonLayout3.setImage(UIImage(named: "Layout3"), for: .normal)
        
        buttonLayout1.setImage(UIImage(named: "layoutSelected"), for: .selected)
        buttonLayout2.setImage(UIImage(named: "layoutSelected2"), for: .selected)
        buttonLayout3.setImage(UIImage(named: "layoutSelected3"), for: .selected)
        
        buttonLayout1.addTarget(self, action: #selector(changeLayoutButton(sender:)), for: .touchUpInside)
        buttonLayout2.addTarget(self, action: #selector(changeLayoutButton(sender:)), for: .touchUpInside)
        buttonLayout3.addTarget(self, action: #selector(changeLayoutButton(sender:)), for: .touchUpInside)
        
        buttonLayout1.tag = 1
        buttonLayout2.tag = 2
        buttonLayout3.tag = 3
       
        
        let gestureSwipeTop = UISwipeGestureRecognizer(target: self, action: #selector(returnToSwipeGesture))
        gestureSwipeTop.direction = UISwipeGestureRecognizer.Direction.up
        view.addGestureRecognizer(gestureSwipeTop)
        
        let gestureSwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(returnToSwipeGesture))
        gestureSwipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(gestureSwipeLeft)
        
        changeUILabelText(bool: UIApplication.shared.statusBarOrientation.isPortrait)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        changeUILabelText(bool: UIDevice.current.orientation.isPortrait)
    }
    
    @objc func returnToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .up where UIDevice.current.orientation.isPortrait:
                print("swipe top")
            case .left where UIDevice.current.orientation.isLandscape:
                print("swipe left")
            default:
                break
            }
        }
    }
    
    private func changeUILabelText(bool: Bool) {
        swipeLabel.text = (bool) ? "^\nSwipe up to Share" : "<\nSwipe left to Share"
        }
    
    @objc func changeLayoutButton(sender: UIButton) {
        switch sender.tag {
        case 1:
            buttonLayout1.isSelected = true
            buttonLayout2.isSelected = false
            buttonLayout3.isSelected = false
            topRightButton.isHidden = true
            bottomLeftButton.isHidden = false
        case 2:
            buttonLayout2.isSelected = true
            buttonLayout1.isSelected = false
            buttonLayout3.isSelected = false
            bottomLeftButton.isHidden = true
            topRightButton.isHidden = false
        case 3:
            buttonLayout3.isSelected = true
            buttonLayout2.isSelected = false
            buttonLayout1.isSelected = false
            bottomLeftButton.isHidden = false
            topRightButton.isHidden = false
        default:
            break
        }
    }
    
    func pickerImage(<#parameters#>) -> <#return type#> {
        <#function body#>
    }
}

