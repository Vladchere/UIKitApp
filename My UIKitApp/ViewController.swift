//
//  ViewController.swift
//  My UIKitApp
//
//  Created by Vladislav on 22.05.2020.
//  Copyright © 2020 Vladislav Cheremisov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	// MARK: - IB Outlets
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var slider: UISlider!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var hideSwitch: UISwitch!
    @IBOutlet var switchLabel: UILabel!
	@IBOutlet var doneButtonLabel: UIButton!

	// MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

		// Slider
		slider.value = 0.5
		slider.minimumValue = 0
		slider.maximumValue = 1
		slider.minimumTrackTintColor = .white
		slider.maximumTrackTintColor = .black
		slider.thumbTintColor = .green
        
        // Label
        mainLabel.font = mainLabel.font.withSize(35)
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 2
		mainLabel.text = String(slider.value)
        
        // Segemented control
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: false)

        // Date picker
        datePicker.locale = Locale(identifier: "ru_RU")
        
        // Switch
        hideSwitch.onTintColor = .red

		// Clear Button
		doneButtonLabel.setTitle("Done", for: .normal)
		doneButtonLabel.layer.cornerRadius = 10

		// Text field
		userNameTextField.backgroundColor = .systemBackground
		self.hideKeyboardWhenTappedAround()

		// Background Color
		view.backgroundColor = view.backgroundColor?.withAlphaComponent(CGFloat(slider.value))
    }

	// MARK: - IB Actions
    @IBAction func chooseSegment() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mainLabel.text = "The first segment"
			mainLabel.textColor = .red
        case 1:
            mainLabel.text = "The second segment"
            mainLabel.textColor = .yellow
        case 2:
            mainLabel.text = "The third segment"
            mainLabel.textColor = .blue
        default:
            break
        }
    }
    
    @IBAction func sliderAction() {
		mainLabel.text = String(round(slider.value * 10) / 10)
        let sliderValue = CGFloat(slider.value)
        view.backgroundColor = view.backgroundColor?.withAlphaComponent(sliderValue)
    }
    
    @IBAction func doneButtonPressed() {
        guard let inputText = userNameTextField.text, !inputText.isEmpty else {
            showAlert(with: "Text field is empty", and: "Please enter your name")
            print("Text field is empty")
            return
        }
        
        if let _ = Double(inputText) {
            showAlert(with: "Wrong format", and: "Please enter your name")
            print("Wrong format")
            return
        }
        
        mainLabel.text = inputText
        userNameTextField.text = ""
    }
    
    @IBAction func chooseDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ru_RU")
        mainLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func switchAction() {
        stackView.isHidden.toggle()
        switchLabel.text = hideSwitch.isOn ? "Show all elements" : "Hide all elements"
    }
}

// MARK: - Extension with private methods (AlertController, HideKeyboard)
extension ViewController {
	private func showAlert(with title: String, and message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
			self.userNameTextField.text = ""
		}
		alert.addAction(okAction)
		present(alert, animated: true)
	}

	private func hideKeyboardWhenTappedAround() {
		let tapGesture = UITapGestureRecognizer(target: self,
												action: #selector(hideKeyboard))
		view.addGestureRecognizer(tapGesture)
	}

	@objc private func hideKeyboard() {
		view.endEditing(true)
	}
}

