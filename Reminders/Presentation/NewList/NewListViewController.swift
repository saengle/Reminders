//
//  NewListViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/9/24.
//

import UIKit

class NewListViewController: UIViewController {
    
    let newListView = NewListView()
    
    override func loadView() {
        view = newListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
