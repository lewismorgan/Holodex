//
//  HoloDex+UIColor.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/23/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
    self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
  }

  class var tint: UIColor { return UIColor(red: 255, green: 212, blue: 3) }
  class var background: UIColor { return UIColor(red: 37, green: 37, blue: 37) }
}
