//
//  HabitEditViewController.swift
//  MyHabits
//
//  Created by Роман on 08.07.2021.
//

import UIKit

class HabitEditViewController: HabitViewController {
    
    var editingHabit: Habit?
    
    var habitDetailsVC: HabitDetailsViewController?
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.turnOnAutoLayout()
        return button
    }()
    
    func twoVCBack() {
        self.presentingViewController?.dismiss(animated: true)
        habitDetailsVC?.popVC()
    }
    
    @objc func pressed() {
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы действительно хотите удалить привычку \(editingHabit?.name ?? "")?", preferredStyle: .alert)
        let abortDeleting = UIAlertAction(title: "Отмена", style: .cancel) {_ in
        }
        guard let editingHabit = editingHabit else { return }
        let deleteHabit = UIAlertAction(title: "Удалить", style: .destructive) {_ in
            if let habitIndex  = HabitsStore.shared.habits.firstIndex(of:editingHabit) {
                HabitsStore.shared.habits.remove(at: habitIndex)
                self.twoVCBack()
            }
        }
        alertController.addAction(abortDeleting)
        alertController.addAction(deleteHabit)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 650),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -52),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 114.5)
        ])
        navigationItem.title = "Править"
    }
    
    override func saveButton() {
        editingHabit?.name = super.titleTextField.text!
        editingHabit?.color = super.roundColorButton.backgroundColor!
        editingHabit?.date = super.datePicker.date
        HabitsStore.shared.save()
        habitDetailsVC?.navigationItem.title = super.titleTextField.text
        habitDetailsVC?.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}


