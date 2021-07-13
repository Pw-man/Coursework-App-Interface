//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Роман on 30.06.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    private let staticHabitText : UILabel = {
        let label = UILabel()
        label.text = "Привычка за 21 день"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.turnOnAutoLayout()
        return label
    }()
    
    private let bigTextView : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.turnOnAutoLayout()
        label.text = """
            Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
            
            1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.
            
            2. Выдержать 2 дня в прежнем состоянии самоконтроля.
            
            3. Отметить в дневнике первую неделю изменений и подвести первые итоги – что оказалось тяжело, что – легче, с чем еще предстоит серьезно бороться.
            
            4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.
            
            5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
            
            6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
            
            Источник: psychbook.ru
            """
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Информация"
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        scrollView.addSubview(staticHabitText)
        scrollView.addSubview(bigTextView)
        scrollView.turnOnAutoLayout()
        containerView.turnOnAutoLayout()
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            staticHabitText.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22),
            staticHabitText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            bigTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            bigTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            bigTextView.topAnchor.constraint(equalTo: staticHabitText.bottomAnchor, constant: 16),
            bigTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
