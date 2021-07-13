//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Роман on 06.07.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController, UITableViewDelegate {
    
    var selectedHabit: Habit?
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.turnOnAutoLayout()
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = selectedHabit?.name
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editButtonPressed))
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func editButtonPressed() {
        let habitEditVC = HabitEditViewController()
        habitEditVC.titleTextField.text = selectedHabit?.name
        habitEditVC.roundColorButton.backgroundColor = selectedHabit?.color
        habitEditVC.roundColorButton.layer.borderColor = selectedHabit?.color.cgColor
        habitEditVC.timeEditableTextField.text = selectedHabit?.dateString
        habitEditVC.editingHabit = selectedHabit
        habitEditVC.habitDetailsVC = self
        let navHabitEdit = UINavigationController(rootViewController: habitEditVC)
        navHabitEdit.modalPresentationStyle = .fullScreen
        navigationController?.present(navHabitEdit, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
}

//MARK: - UITableViewDataSource
extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        guard let selectedHabit = selectedHabit else { return UITableViewCell()}
        cell.tintColor = UIColor(named: "PurpleColorSet")
        for date in HabitsStore.shared.dates  {
            for date1 in selectedHabit.trackDates {
                if Calendar.current.isDate(date, equalTo: date1, toGranularity: .day) {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
            }
        }
        return cell
    }
}

//MARK: - PopVCFunc

extension HabitDetailsViewController {
    func popVC() {
        self.navigationController?.popViewController(animated: false)
    }
}

