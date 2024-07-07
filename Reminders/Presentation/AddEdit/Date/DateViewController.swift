//
//  DateViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/8/24.
//

import UIKit

import FSCalendar

class DateViewController: UIViewController {
    var date = Date()
    
    lazy var fsCal = {
        let cal = FSCalendar()
        cal.locale = Locale(identifier: "ko_KR")
        cal.select(date)
        cal.appearance.headerTitleAlignment = .left
        cal.appearance.headerDateFormat = "YYYY년 MM월"
        cal.appearance.headerTitleColor = .systemTeal
        cal.headerHeight = 45
        cal.appearance.headerMinimumDissolvedAlpha = 0.0
        cal.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 16)
        cal.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        cal.appearance.weekdayTextColor = .systemCyan
        cal.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        cal.backgroundColor = .tertiarySystemBackground
        cal.layer.cornerRadius = 15
        cal.layer.masksToBounds = true
        return cal
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        self.view.addSubview(fsCal)
        fsCal.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(400)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 신호 + 정보 보내기
        self.date = fsCal.selectedDate ?? Date()
        NotificationCenter.default.post(name: NSNotification.Name("memoReceived"), object: nil, userInfo: ["date": date])
    }
}
