//
//  AddEditViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

class AddEditViewController: UIViewController {
    
    private let addEditView = AddEditView()
    
    override func loadView() {
        view = addEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
