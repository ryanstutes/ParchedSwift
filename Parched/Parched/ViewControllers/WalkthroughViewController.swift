//
//  WalkthroughViewController.swift
//  Parched
//
//  Created by Ryan Stutesman on 9/17/16.
//  Copyright © 2016 Ryan Stutesman. All rights reserved.
//

import UIKit

class WalkthroughViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dailyAmountTextField: UITextField!
    @IBOutlet weak var unitOfMeasurementSegmentedControl: UISegmentedControl!
    @IBOutlet weak var containerSizeTextField: UITextField!
    @IBOutlet weak var containerUnitsLabel: UILabel!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var descriptionLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleView: UIView!
    
    var currentSection = 0
    var amountMovedForKeyboard: CGFloat = 0.0
    var settingsViewModel: SettingsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsViewModel = SettingsViewModel()
        
        startTimeTextField.inputView = startTimePicker
        endTimeTextField.inputView = endTimePicker
        startTimeTextField.text = settingsViewModel?.startTimeString
        endTimeTextField.text = settingsViewModel?.endTimeString
        
        unitOfMeasurementSegmentedControl.selectedSegmentIndex = 0
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.descriptionLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            self.descriptionLabel.alpha = 1;
        }) 
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // TODO: Wtf is this? Make a custom TextField
//    func setupTextFieldBorders() {
//        let width = CGFloat(1)
//
//        let dailyAmountBorder = CALayer()
//        dailyAmountBorder.borderColor = UIColor.white.cgColor
//        dailyAmountBorder.frame = CGRect(x: 0, y: dailyAmountTextField.frame.size.height - width, width:  dailyAmountTextField.frame.size.width, height: dailyAmountTextField.frame.height)
//        dailyAmountBorder.borderWidth = width
//        dailyAmountTextField.layer.addSublayer(dailyAmountBorder)
//        dailyAmountTextField.layer.masksToBounds = true
//     
//        let containerSizeBorder = CALayer()
//        containerSizeBorder.borderColor = UIColor.white.cgColor
//        containerSizeBorder.frame = CGRect(x: 0, y: containerSizeTextField.frame.size.height - width, width:  containerSizeTextField.frame.size.width, height: containerSizeTextField.frame.height)
//        containerSizeBorder.borderWidth = width
//        containerSizeTextField.layer.addSublayer(containerSizeBorder)
//        containerSizeTextField.layer.masksToBounds = true
//        
//        let startTimeBorder = CALayer()
//        startTimeBorder.borderColor = UIColor.white.cgColor
//        startTimeBorder.frame = CGRect(x: 0, y: startTimeTextField.frame.size.height - width, width:  startTimeTextField.frame.size.width, height: startTimeTextField.frame.height)
//        startTimeBorder.borderWidth = width
//        startTimeTextField.layer.addSublayer(startTimeBorder)
//        startTimeTextField.layer.masksToBounds = true
//        
//        
//        let endTimeBorder = CALayer()
//        endTimeBorder.borderColor = UIColor.white.cgColor
//        endTimeBorder.frame = CGRect(x: 0, y: endTimeTextField.frame.size.height - width, width:  endTimeTextField.frame.size.width, height: endTimeTextField.frame.height)
//        endTimeBorder.borderWidth = width
//        endTimeTextField.layer.addSublayer(endTimeBorder)
//        endTimeTextField.layer.masksToBounds = true
//    }
    
    func moveLabelsForward() {
        currentSection += 1
        if currentSection == 3 {
            proceedButton.titleLabel?.text = "Done"
        } else {
             proceedButton.titleLabel?.text = "Continue"
        }
        descriptionLabelLeadingConstraint.constant -= descriptionLabel.frame.size.width + 40
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) 
    }
    
    // MARK: Keyboard
    @objc func keyboardWillShow(_ notification: Notification) {
        if let info = (notification as NSNotification).userInfo, let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {
            let keyboardEndY = (info[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue.origin.y
            let proceedButtonBottom = proceedButton.frame.origin.y + proceedButton.frame.size.height;
            if keyboardEndY > proceedButtonBottom {
                return
            } else {
                let needMoveUp = proceedButtonBottom - keyboardEndY + 10
                amountMovedForKeyboard = needMoveUp
                titleViewTopConstraint.constant -= needMoveUp
                UIView.animate(withDuration: duration, animations: {
                    self.titleView.alpha = 0
                    self.view.layoutIfNeeded()
                }) 
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard amountMovedForKeyboard != 0  else {
            return
        }
        
        if let info = (notification as NSNotification).userInfo, let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {
            titleViewTopConstraint.constant += amountMovedForKeyboard
            amountMovedForKeyboard = 0
            UIView.animate(withDuration: duration, animations: {
                self.titleView.alpha = 1
                self.view.layoutIfNeeded()
            }) 
        }
    }
    
    // MARK: Actions
    @IBAction func unitsSegmentedControlValueChanged(_ sender: AnyObject) {
        let control = sender as! UISegmentedControl
        settingsViewModel?.unitOfMesaurement = control.selectedSegmentIndex
    }
    
    @IBAction func proceedButtonClicked(_ sender: AnyObject) {
        switch currentSection {
        case 0:
            moveLabelsForward()
            self.dailyAmountTextField.becomeFirstResponder()
        case 1:
            guard let text = dailyAmountTextField.text, let amount = Int(text) else { return }
            settingsViewModel?.setDailyGoal(amount) { (errorString) in
                if let error = errorString {
                    self.showErrorAlert("Oops", message: error)
                } else {
                    self.moveLabelsForward()
                    self.containerSizeTextField.becomeFirstResponder()
                }
            }
        case 2:
            guard let text = containerSizeTextField.text, let size = Int(text) else { return }
            settingsViewModel?.setContainerSize(size) { (errorString) in
                if let error = errorString {
                    self.showErrorAlert("Oops", message: error)
                } else {
                    self.moveLabelsForward()
                    self.startTimeTextField.becomeFirstResponder()
                }
            }
        case 3:
            settingsViewModel?.startTime = startTimePicker.date
            settingsViewModel?.setEndTime(endTimePicker.date) { (errorString) in
                if let error = errorString {
                    self.showErrorAlert("Oops", message: error)
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let homeVc = storyboard.instantiateInitialViewController() {
                        self.present(homeVc, animated: true, completion: nil)
                    }
                }
            }
        default:
            break
        }
    }
    
    @IBAction func backgroundTapped(_ sender: AnyObject) {
        view.endEditing(true)
    }
}
