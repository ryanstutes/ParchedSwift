//
//  ViewController.swift
//  Parched
//
//  Created by Krystin Stutesman on 9/17/16.
//  Copyright © 2016 Krystin Stutesman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var nextRefillLabel: UILabel!
    @IBOutlet weak var finishedEarlyButton: UIButton!
    @IBOutlet weak var amountDrankTodayLabel: UILabel!
    @IBOutlet weak var unitOfMeasurementSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dailyAmountTextField: UITextField!
    @IBOutlet weak var unitsForDailyAmountLabel: UILabel!
    @IBOutlet weak var containerSizeTextField: UITextField!
    @IBOutlet weak var unitsForContainerSizeLabel: UILabel!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var endTimeButton: UIButton!
    @IBOutlet weak var pushNotificationsSwitch: UISwitch!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var timeLeftContainerView: UIView!
    @IBOutlet weak var finishedEarlyCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var finishedEarlyWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressBarContainerView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBarRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var timePickerBottomConstraint: NSLayoutConstraint!
    
    private var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settingsViewModel = SettingsViewModel()
        viewModel = MainViewModel(settingsViewModel: settingsViewModel)
        
        setupNSNotifications()
        updateAllInfo()
        addBarButtons()
    }
    
    // MARK: Private functions
    private func addBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(showSettings))
//        (image: UIImage(named: "settings"), style: .plain, target: self, action: )
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCustomAmount))
    }
    
    private func updateAllInfo() {
        populateSettingsFromViewModel()
        updateProgressBarAndLabel()
        resetTimer()
    }
    
    @objc private func showSettings() {
        
    }
    
//    private func setupPickerViewForSettings() {
//        let doneButtonView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneWithPickerTapped()))
//        timePicker.inputView = doneButtonView
//    }
    
    // TODO: Observables
    private func populateSettingsFromViewModel() {
//        dailyAmountTextField.text = String(viewModel.dailyAmount)
//        containerSizeTextField.text = String(viewModel.containerSize)
//        startTimeButton.titleLabel?.text = viewModel.startTimeString
//        endTimeButton.titleLabel?.text = viewModel.startTimeString
//        unitOfMeasurementSegmentedControl.selectedSegmentIndex = viewModel.unitOfMesaurement
    }
    
    @objc private func doneWithPickerTapped() {
        
    }
    
    private func setupNSNotifications() {
        
    }
    
    private func resetTimer() {
        
    }
    
    private func updateProgressBarAndLabel() {
        
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }

    // MARK: Actions & Selectors

    @objc private func addCustomAmount() {
        
    }
    
//    @objc private func timePickerChanged() {
//        if startTimePickerIsShowing {
//            update(startTime: timePicker.date)
//            // TODO: Update time for start day notification
//        } else if endTimePickerIsShowing {
//            updateEndTimeIfValid(endTime: timePicker.date)
//            // TODO: If they changed the end time in the middle of a day, we need to redo our math
//        }
//    }
    
//    private func update(startTime: Date) {
//        if let endTime = viewModel.endTime, endTime < startTime {
//            viewModel.endTime = Date(timeInterval: 3600 * 8, since: startTime)
//        }
//        viewModel.startTime = startTime
//        startTimeButton.titleLabel?.text = viewModel.startTimeString
//    }
    
    // TODO: Logic like this probably shouldn't be in the ViewController ^
//    private func updateEndTimeIfValid(endTime: Date) {
//        guard let startTime = viewModel.startTime, startTime < endTime else {
//            showAlert(title: "Whoops", message: "End time cannot be before start time. Please try again.")
//            return
//        }
//        viewModel.endTime = endTime
//        endTimeButton.titleLabel?.text = viewModel.endTimeString
//    }
    
    @IBAction func finishedEarlyButtonClicked(_ sender: AnyObject) {
        
    }
    
//    private var startTimePickerIsShowing = false
//    @IBAction func startTimeButtonClicked(_ sender: AnyObject) {
//        view.endEditing(true)
//        if startTimePickerIsShowing {
//            hidePicker()
//        } else {
//            showPicker()
//            if viewModel.startTime == nil {
//                viewModel.startTime = timePicker.date
//                startTimeButton.titleLabel?.text = viewModel.startTimeString
//            }
//        }
//        endTimePickerIsShowing = !endTimePickerIsShowing
//        startTimePickerIsShowing = !startTimePickerIsShowing
//    }
//    
//    private var endTimePickerIsShowing = false
//    @IBAction func endTimeButtonClicked(_ sender: AnyObject) {
//        view.endEditing(true)
//        if endTimePickerIsShowing {
//            hidePicker()
//        } else {
//            showPicker()
//            if viewModel.endTime == nil {
//                viewModel.endTime = timePicker.date
//                endTimeButton.titleLabel?.text = viewModel.endTimeString
//            }
//        }
//        endTimePickerIsShowing = !endTimePickerIsShowing
//        startTimePickerIsShowing = !startTimePickerIsShowing
//    }
//    
//    private func hidePicker() {
//        view.endEditing(true)
//        self.timePickerBottomConstraint.constant = -self.timePicker.frame.height
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
//    }
//    
//    private func showPicker() {
//        view.endEditing(true)
//        self.timePickerBottomConstraint.constant = 0
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
//    }
//
//    @IBAction func backgroundTapped(_ sender: Any) {
//        if endTimePickerIsShowing || startTimePickerIsShowing {
//            hidePicker()
//        } else {
//            view.endEditing(true)
//        }
//    }

}

