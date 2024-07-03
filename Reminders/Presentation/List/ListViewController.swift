//
//  ListViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

class ListViewController: UIViewController {
    
    let listView = ListView()
    override func loadView() {
        view = listView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
