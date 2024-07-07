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
    
    let newReminder = {
        let item = UITabBarItem()
        item.title = "New Reminder"
        return item
    }()
    
    let addList = {
        let item = UITabBarItem()
        item.title = "Add List"
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.mainCollectionView.dataSource = self
        mainView.mainCollectionView.delegate = self
        mainView.mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
        self.tabBarController?.delegate = self
        self.navigationItem.backButtonTitle = "Lists"
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell()}
        switch indexPath.row {
        case 0:
            cell.configureCell(color: .systemBlue, image: UIImage(systemName: "08.circle.fill")!, title: "Today", number: 5)
        case 1:
            cell.configureCell(color: .systemRed, image: UIImage(systemName: "calendar.circle.fill")!, title: "Scheduled", number: 5)
        case 2:
            cell.configureCell(color: .systemGray, image: UIImage(systemName: "tray.circle.fill")!, title: "All", number: 5)
        case 3:
            cell.configureCell(color: .systemOrange, image: UIImage(systemName: "flag.circle.fill")!, title: "Flagged", number: 5)
        case 4:
            cell.configureCell(color: #colorLiteral(red: 0.6099210665, green: 0.6504435934, blue: 0.7140484248, alpha: 1)
, image: UIImage(systemName: "checkmark.circle.fill")!, title: "Completed", number: 5)
        default: print("문제가 발생했습니다.")
        }
        #colorLiteral(red: 0.6099210665, green: 0.6504435934, blue: 0.7140484248, alpha: 1)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath.item)
        let vc = ListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch tabBarController.selectedIndex {
        case 0:
            let nav = UINavigationController(rootViewController: AddEditViewController())
            present(nav, animated: true)
        case 1:
            let nav = UINavigationController(rootViewController: AddEditViewController())
            present(nav, animated: true)
        default:
            print("Error")
        }
    }
}
