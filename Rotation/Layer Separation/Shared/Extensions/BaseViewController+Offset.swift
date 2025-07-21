//
//  BaseViewController+Offset.swift
//  Rotation Demo
//
//  Created by Andrew F. Dreher on 1/15/25.
//

import UIKit


extension BaseViewController {

  /// Function to update the offset of the dynamic logo.
  func centerDynamicLogo() {
    if let dynamicLogo {
      let centerOffset = dynamicLogo.offsetToCenter(in: view)
      dynamicLogo.frame = CGRect(origin: centerOffset, size: dynamicLogo.bounds.size)
    }
  }

}
