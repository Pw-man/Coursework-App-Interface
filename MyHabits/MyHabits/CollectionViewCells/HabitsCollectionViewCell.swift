//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Роман on 02.07.2021.
//

import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    var habit: Habit? {
        didSet {
            guard let habit = habit else { return }
            nameHabitLabel.textColor = habit.color
            timeLabel.text = habit.dateString
            counterLabel.text = "Счётчик: \(habit.trackDates.count)"
            roundMarkingView.layer.borderColor = habit.color.cgColor
        }
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
    
    private let roundMarkingView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 19
        view.layer.borderWidth = 1
        view.turnOnAutoLayout()
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(nameHabitLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(counterLabel)
        contentView.addSubview(roundMarkingView)
        contentView.backgroundColor = .white
        
        let constraints = [
            nameHabitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameHabitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            timeLabel.topAnchor.constraint(equalTo: nameHabitLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            counterLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 30),
            counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            counterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            roundMarkingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            roundMarkingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            roundMarkingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -46)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
