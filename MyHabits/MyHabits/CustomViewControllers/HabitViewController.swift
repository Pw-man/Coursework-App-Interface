//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Роман on 30.06.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.turnOnAutoLayout()
        return label
    }()
    
    var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.turnOnAutoLayout()
        textField.returnKeyType = .done
        textField.textColor = UIColor(named: "LightBlueInHabitVC")
        return textField
    }()
    
    let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Цвет"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.turnOnAutoLayout()
        return label
    }()
    
    let roundColorButton: UIButton = {
        let rcb = UIButton()
        rcb.backgroundColor = UIColor(named: "OrangeColorSet")
        rcb.layer.cornerRadius = 15
        rcb.layer.masksToBounds = true
        rcb.turnOnAutoLayout()
        return rcb
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.turnOnAutoLayout()
        return label
    }()
    
    let timeEditableTextField : UITextField = {
        let tetf = UITextField()
        tetf.isUserInteractionEnabled = false
        tetf.returnKeyType = .done
        tetf.turnOnAutoLayout()
        return tetf
    }()
    
    let datePicker : UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.preferredDatePickerStyle = .wheels
        dp.turnOnAutoLayout()
        return dp
    }()
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(colorLabel)
        view.addSubview(roundColorButton)
        view.addSubview(timeLabel)
        view.addSubview(timeEditableTextField)
        view.addSubview(datePicker)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        
        titleTextField.delegate = self
        
        navigationItem.title = "Создать"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButton))
        
        timeEditableTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let coloredTextFromFormatter : NSAttributedString = "Каждый день в \(formatter.string(from: datePicker.date))".attributedStringWithColor(["\(formatter.string(from: datePicker.date))"], color: UIColor(named: "PurpleColorSet")!)
        timeEditableTextField.attributedText = coloredTextFromFormatter
        
        roundColorButton.addTarget(self, action: #selector(didTapToSelectColor), for: .touchUpInside)
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            colorLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            roundColorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            roundColorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            roundColorButton.widthAnchor.constraint(equalToConstant: 30),
            roundColorButton.heightAnchor.constraint(equalTo: roundColorButton.widthAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: roundColorButton.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            timeEditableTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeEditableTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            timeEditableTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -160),
            
            datePicker.topAnchor.constraint(equalTo: timeEditableTextField.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func didTapToSelectColor() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true, completion: nil)
    }
    
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButton() {
        let newHabit = Habit(name: titleTextField.text ?? "Nameless habit", date: datePicker.date, color: roundColorButton.backgroundColor!)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dateChanged() {
        getDateFromPicker()
    }
    
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let coloredTextFromFormatter : NSAttributedString = "Каждый день в \(formatter.string(from: datePicker.date))".attributedStringWithColor(["\(formatter.string(from: datePicker.date))"], color: UIColor(named: "PurpleColorSet")!)
        timeEditableTextField.attributedText = coloredTextFromFormatter
    }
}

//MARK: - UITextFieldDelegate

extension HabitViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}

//MARK: - extension String

extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
}

//MARK: - UIColorPickerViewControllerDelegate

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        roundColorButton.backgroundColor = color
    }
}
