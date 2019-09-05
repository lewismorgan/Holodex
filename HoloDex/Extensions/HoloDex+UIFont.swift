//
//  HoloDex+UIFont.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/23/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit

extension UIFont {
  static func glyph(ofSize size: CGFloat) -> UIFont {
    return UIFont(font: FontFamily.HolodexGlyphs.regular, size: size)
  }
}
