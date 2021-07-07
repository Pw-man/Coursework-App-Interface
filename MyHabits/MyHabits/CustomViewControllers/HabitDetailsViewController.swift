//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Роман on 06.07.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController, UITableViewDelegate {
    
    var selectedHabit: Habit?

    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.turnOnAutoLayout()
        view.addSubview(tableView)
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = selectedHabit?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editButtonPressed))
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func editButtonPressed() {
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    
}

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        guard let selectedHabit = selectedHabit else { return UITableViewCell()}
        if selectedHabit.isAlreadyTakenToday {
            cell.tintColor = UIColor(named: "PurpleColorSet")
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    
}

