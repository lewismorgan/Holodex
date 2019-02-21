//
//  Colors.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/20/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import Foundation
import UIKit

struct Colors {
  public static let primaryTint = UIColor(red: 255, green: 212, blue: 3)
  public static let primaryBackground = UIColor(red: 44, green: 50, blue: 59)
  public static let secondaryTint = UIColor(red: 62, green: 171, blue: 195)
}

//tabBar.backgroundColor = UIColor(ciColor: CIColor(red: 44, green: 50, blue: 59))
//tabBar.tintColor = UIColor(ciColor: CIColor(red: 44, green: 50, blue: 59))
//tabBar.barTintColor = UIColor(ciColor: CIColor(red: 255, green: 212, blue: 3))

extension UIColor {
  convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
    self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
  }
}
