//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Роман on 30.06.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private let myLayout = UICollectionViewFlowLayout()
    
    lazy var habitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: myLayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(habitsCollectionView)
        habitsCollectionView.backgroundColor = UIColor(named: "GrayBackgroundColor")
        habitsCollectionView.turnOnAutoLayout()
        
        let constraints = [
            habitsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapToAdd))
        
        habitsCollectionView.dataSource = self
        habitsCollectionView.delegate = self
        habitsCollectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitsCollectionViewCell.self))
        habitsCollectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        habitsCollectionView.reloadData()
    }
    
    @objc public func tapToAdd() {
        let newHabitController = storyboard?.instantiateViewController(withIdentifier: "addHabitVC") as! HabitViewController
        let navControllerForNewHabitController = UINavigationController(rootViewController: newHabitController)
        navControllerForNewHabitController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navControllerForNewHabitController, animated: true, completion: nil)
    }
}
//MARK: UICollectionViewDataSource

extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitsCollectionViewCell.self), for: indexPath) as! HabitsCollectionViewCell
            cell.habit = HabitsStore.shared.habits[indexPath.item]
            cell.buttonDelegate = self
            cell.roundMarkingButton.addTarget(cell, action: #selector(cell.tapOnCircle), for: .touchUpInside)
            cell.cellConfig()
            if cell.habit?.isAlreadyTakenToday == true {
                cell.roundMarkingButton.backgroundColor = cell.habit?.color
                let config = UIImage.SymbolConfiguration(textStyle: .headline, scale: .default)
                guard let checkmarkImage = UIImage(systemName: "checkmark", withConfiguration: config) else { return UICollectionViewCell() }
                let finalCheckmark = checkmarkImage.withTintColor(.white, renderingMode: .alwaysOriginal)
                cell.roundMarkingButton.setImage(finalCheckmark, for: .normal)
            } else {
                cell.roundMarkingButton.backgroundColor = .white
            }
            return cell
        } else {
            let cellTwo = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            cellTwo.progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
            cellTwo.percentageLabel.text = "\(Int(cellTwo.progressView.progress * 100))%"
            return cellTwo
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let habitDetailsVC = HabitDetailsViewController()
        habitDetailsVC.selectedHabit = HabitsStore.shared.habits[indexPath.item]
        if indexPath.section == 1 {
            self.navigationController?.pushViewController(habitDetailsVC, animated: true)
        } 
    }
}
//MARK: UICollectionViewDelegateFlowLayout

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 60)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 18, right: 16)
        } else {
            return UIEdgeInsets(top: .zero, left: 16, bottom: 16, right: 16)
        }
    }
}
