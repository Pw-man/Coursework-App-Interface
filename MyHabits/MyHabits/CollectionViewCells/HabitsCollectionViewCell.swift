//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Роман on 02.07.2021.
//

import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    var buttonDelegate: HabitsViewController?
    
    var habit: Habit?
    
    func cellConfig() {
                guard let habit = habit else { return }
                nameHabitLabel.text = habit.name
                nameHabitLabel.textColor = habit.color
                timeLabel.text = habit.dateString
                counterLabel.text = "Счётчик: \(habit.trackDates.count)"
                roundMarkingButton.layer.borderColor = habit.color.cgColor
            }
    
    private let nameHabitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.turnOnAutoLayout()
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray2
        label.turnOnAutoLayout()
        return label
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray2
        label.text = "Счётчик: "
        label.turnOnAutoLayout()
        return label
    }()
    
    lazy var roundMarkingButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 1
        button.turnOnAutoLayout()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(nameHabitLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(counterLabel)
        contentView.addSubview(roundMarkingButton)
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        
        let constraints = [
            nameHabitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameHabitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            timeLabel.topAnchor.constraint(equalTo: nameHabitLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            counterLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 30),
            counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            counterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            roundMarkingButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            roundMarkingButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            roundMarkingButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -46),
            roundMarkingButton.widthAnchor.constraint(equalToConstant: 38),
            roundMarkingButton.heightAnchor.constraint(equalToConstant: 38),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapOnCircle() {
        guard let habit = habit else { return }
        if habit.isAlreadyTakenToday {
            roundMarkingButton.isUserInteractionEnabled = false
        } else {
            HabitsStore.shared.track(habit)
            buttonDelegate?.habitsCollectionView.reloadData()
        }
    }
}
