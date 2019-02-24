//
//  UIImage.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/23/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit

extension UIImage {
  convenience init(glyph: Glyph, textColor: UIColor = .black, backgroundColor: UIColor = .clear, size: CGSize) {
    let drawText = glyph.rawValue
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = NSTextAlignment.center

    let fontSize = min(size.width / 1.285_714_29, size.height)
    let attributes = [NSAttributedString.Key.font: UIFont.glyph(ofSize: fontSize),
                      NSAttributedString.Key.foregroundColor: textColor,
                      NSAttributedString.Key.backgroundColor: backgroundColor,
                      NSAttributedString.Key.paragraphStyle: paragraphStyle]

    let attributedString = NSAttributedString(string: drawText, attributes: attributes)
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    attributedString.draw(in: CGRect(x: 0, y: (size.height - fontSize) * 0.5, width: size.width, height: fontSize))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    if let image = image {
      self.init(cgImage: image.cgImage!, scale: image.scale, orientation: image.imageOrientation)
    } else {
      self.init()
    }
  }

  static func glyph(from: Glyph, color: UIColor, size: CGSize) -> UIImage {
    return UIImage(glyph: from, textColor: color, backgroundColor: .clear, size: size)
  }
}
