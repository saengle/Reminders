//
//  PrioritySegmentViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/8/24.
//

import UIKit

class PrioritySegmentViewController: UIViewController {
    
    var prioritySegNum = 0
    
    lazy var segCon = {
        let sc: UISegmentedControl = UISegmentedControl(items: array)
        sc.center = CGPoint(x: self.view.frame.width/2, y: 400)
        sc.backgroundColor = UIColor.gray
        sc.tintColor = UIColor.white
        sc.addTarget(self, action: #selector(segconChanged(segcon:)), for: .valueChanged)
        sc.selectedSegmentIndex = prioritySegNum
        return sc
    }()
    
    let array: [String] = ["없음", "낮음", "중간", "높음"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.segCon)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 신호 + 정보 보내기
        NotificationCenter.default.post(name: NSNotification.Name("memoReceived"), object: nil, userInfo: ["priority": prioritySegNum])
         
    }
    
    @objc
    private func segconChanged(segcon: UISegmentedControl) {
        prioritySegNum = segcon.selectedSegmentIndex
    }
    
    @objc
    private func backButtonClicked(_: UIBarButtonItem) {
        print("ehlasid")
    }
}
