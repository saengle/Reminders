//
//  UIView+Extension.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

protocol ReuseIdentifying {
    static var identifier: String { get }
}

extension UIView {
    static var id: String {
          return String(describing: self)
      }
}
