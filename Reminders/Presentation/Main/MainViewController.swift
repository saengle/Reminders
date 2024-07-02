//
//  MainViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

class MainViewController: UIViewController {
    
    private let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
