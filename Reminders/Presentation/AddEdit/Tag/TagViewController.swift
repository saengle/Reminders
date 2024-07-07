//
//  TagViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/8/24.
//

import UIKit

class TagViewController: UIViewController {
    
    var tagString = ""
    
    lazy var tagTextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.gray
        tf.tintColor = UIColor.white
        tf.addTarget(self, action: #selector(textfieldChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        self.view.addSubview(self.tagTextField)
        tagTextField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 신호 + 정보 보내기
        NotificationCenter.default.post(name: NSNotification.Name("memoReceived"), object: nil, userInfo: ["tag": tagString])
    }
    
    @objc
    func textfieldChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        if text.isEmpty {
            
        } else {
            tagString = text
        }
    }
}
