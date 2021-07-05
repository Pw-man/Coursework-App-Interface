//
//  TabBarController.swift
//  MyHabits
//
//  Created by Роман on 30.06.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.tintColor = UIColor(named: "PurpleColorSet")
}
}
