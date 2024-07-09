//
//  NewListViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/9/24.
//

import UIKit

class AddListViewController: UIViewController {
    
    let newListView = AddListView()
    
    override func loadView() {
        view = newListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
