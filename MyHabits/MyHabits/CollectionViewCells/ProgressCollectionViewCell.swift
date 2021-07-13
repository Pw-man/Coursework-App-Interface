//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Роман on 05.07.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    var progressView = UIProgressView()
    
    private let userSupportingTitle: UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.turnOnAutoLayout()
        return label
    }()
    
    var percentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.turnOnAutoLayout()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(progressView)
        contentView.addSubview(userSupportingTitle)
        contentView.addSubview(percentageLabel)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        progressView.progressViewStyle = .default
        progressView.progressTintColor = UIColor(named: "PurpleColorSet")
        progressView.progress = HabitsStore.shared.todayProgress
        progressView.turnOnAutoLayout()
        
        let constraints = [
            userSupportingTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userSupportingTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            userSupportingTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -115),
            
            percentageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            percentageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            progressView.topAnchor.constraint(equalTo: userSupportingTitle.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

