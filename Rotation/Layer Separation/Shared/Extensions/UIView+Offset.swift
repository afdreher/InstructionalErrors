//
//  UIView+Offset.swift
//  Rotation Demo
//
//  Created by Andrew F. Dreher on 1/15/25.
//

import UIKit


extension UIView {

  /// Function to compute the offset required to center the current view inside
  /// a parent view.
  func offsetToCenter(in view: UIView) -> CGPoint {
    return offsetToCenter(in: view.bounds.size)
  }

  func offsetToCenter(in size: CGSize) -> CGPoint {
    return CGPoint(
      x: (size.width - self.bounds.size.width) / 2,
      y: (size.height - self.bounds.size.height) / 2
    )
  }

}
