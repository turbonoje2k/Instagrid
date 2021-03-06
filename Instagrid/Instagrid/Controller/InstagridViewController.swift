//
//  InstagridViewController.swift
//  Instagrid
//
//  Created by noje on 16/03/2021.
//

import UIKit
import Photos

class InstagridViewController: UIViewController {

    // MARK:- IBoutlet
    // 3 button Unik Layout
    @IBOutlet weak var buttonLayout1: UIButton!
    @IBOutlet weak var buttonLayout2: UIButton!
    @IBOutlet weak var buttonLayout3: UIButton!
    
    // swipe label change by orientation
    @IBOutlet weak var swipeLabel: UILabel!
    
    // 4 box for pics
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    // 1 box for all pics
    @IBOutlet weak var centralView: UIView!
    
    // change the centralView Constraint
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerXConstraint: NSLayoutConstraint!
    
    //MARK:- class var
    private var buttonImage: UIButton?
    private var imagePicker: UIImagePickerController?
    private var activityController: UIActivityViewController?
    private let screenWidth = UIScreen.main.bounds.width
    private var translationTransform: CGAffineTransform?
    
    //MARK:- APP LIFE CYCLE
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // check the status
        if checkAccess() {
            print("OK we have the cleareance")
        }
        setupTargetButton()
        // button layout not selected
        buttonLayout1.setImage(UIImage(named: "Layout1"), for: .normal)
        buttonLayout2.setImage(UIImage(named: "Layout2"), for: .normal)
        buttonLayout3.setImage(UIImage(named: "Layout3"), for: .normal)
        
        // button layout selected
        buttonLayout1.setImage(UIImage(named: "layoutSelected"), for: .selected)
        buttonLayout2.setImage(UIImage(named: "layoutSelected2"), for: .selected)
        buttonLayout3.setImage(UIImage(named: "layoutSelected3"), for: .selected)
        
        buttonLayout3.isSelected = true
        
        // tap trigger button
        [buttonLayout1, buttonLayout2, buttonLayout3].forEach {
            $0.addTarget(self, action: #selector(changeLayoutButton(sender:)), for: .touchUpInside)
        }
        
        // tag for the buttons
        buttonLayout1.tag = 1
        buttonLayout2.tag = 2
        buttonLayout3.tag = 3
       
        // var for gesture recognizer Top
        let gestureSwipeTop = UISwipeGestureRecognizer(target: self, action: #selector(shareSwipeGesture))
        gestureSwipeTop.direction = UISwipeGestureRecognizer.Direction.up
        view.addGestureRecognizer(gestureSwipeTop)
        
        // var for gesture recognizer left
        let gestureSwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(shareSwipeGesture))
        gestureSwipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(gestureSwipeLeft)
        
        changeUILabelText(bool: UIApplication.shared.statusBarOrientation.isPortrait)
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .savedPhotosAlbum
    }
    //MARK: View Will Transition
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        changeUILabelText(bool: UIDevice.current.orientation.isPortrait)
    }
    //MARK:- FUNCTIONS
    //MARK: Swipe
    @objc func shareSwipeGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up, UIDevice.current.orientation.isPortrait {
            self.animateCentralViewInY(constraint: -UIScreen.main.bounds.height)
        } else {
            self.animateCentralViewInX(constraint: -UIScreen.main.bounds.width)
        }
        guard let imageToShare = centralView.asImage() else { return }
        
        activityController = UIActivityViewController(activityItems: [imageToShare as UIImage], applicationActivities: nil)
        guard let activityVC = activityController else { return }
        activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?,
                                                  completed: Bool,
                                                  returnedItems: [Any]?,
                                                  error: Error?) in
                switch gesture.direction {
                case .up where UIDevice.current.orientation.isPortrait:
                    print("swipe top")
                    self.animateCentralViewInY(constraint: 0)
                    
                case .left where UIDevice.current.orientation.isLandscape:
                    print("swipe left")
                    self.animateCentralViewInX(constraint: 0)
                default:
                    break
                }
        }
        present(activityVC, animated: true, completion: nil)
    }
    // func to change the view when swipe 
    private func animateCentralViewInY(constraint: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.centerYConstraint.constant = constraint
            self.view.layoutIfNeeded()
        }
    }
    private func animateCentralViewInX(constraint: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.centerXConstraint.constant = constraint
            self.view.layoutIfNeeded()
        }
    }
    // MARK: UI label change with Orientation
    private func changeUILabelText(bool: Bool) {
        swipeLabel.text = (bool) ? "^\nSwipe up to Share" : "<\nSwipe left to Share"
        }
    // MARK: Change Layout
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
    // MARK: Acces Check
    // acces to the photo Library need authorization
    func checkAccess() -> Bool {
        var status: Bool = false
        
        let autorisationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch autorisationStatus {
        case .authorized:
            status = true
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    status = true
                }
            }
        case .denied:
            break
        case .restricted:
            break
        case .limited:
            break
        default:
            break
        }
        return status
    }
    // MARK: Target Button
    func setupTargetButton() {
        topLeftButton.addTarget(self, action: #selector(addNewPhoto(_:)), for: .touchUpInside)
        topRightButton.addTarget(self, action: #selector(addNewPhoto(_:)), for: .touchUpInside)
        bottomLeftButton.addTarget(self, action: #selector(addNewPhoto(_:)), for: .touchUpInside)
        bottomRightButton.addTarget(self, action: #selector(addNewPhoto(_:)), for: .touchUpInside)
    }
    // MARK: Add Photo
    @objc func addNewPhoto(_ sender: UIButton) {
        if checkAccess() {
            guard let secureImagePicker = imagePicker else { return }
            buttonImage = sender
            present(secureImagePicker, animated: true, completion: nil)
        } else {
            let error = UIAlertController(title: "Authorisation refused" , message: "please authorise in the options menu", preferredStyle: .alert)
            error.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(error, animated: true, completion: nil)
        }
    }
}
// MARK:- EXTENSIONS
// extend my Main class with new funcs
extension InstagridViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            buttonImage?.setImage(nil, for: .normal)
            buttonImage?.setBackgroundImage(pickedImage, for: .normal)
            dismiss(animated: true, completion: nil)
        }
    }
}
