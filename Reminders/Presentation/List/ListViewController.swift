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
    lazy var imageWitdh = view.window?.windowScene?.screen.bounds.width
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
}
extension ListViewController {
    private func configureViewController() {
        listView.configureView(title: "임시제목")
        listView.tableView.dataSource = self
        listView.tableView.delegate = self
        listView.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
        listView.tableView.rowHeight = UITableView.automaticDimension
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        if let imageWitdh {
            cell.configureCell(width:imageWitdh)
        }
        return cell
    }
}
