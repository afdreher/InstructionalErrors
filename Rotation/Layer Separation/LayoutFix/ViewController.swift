//
//  ViewController.swift
//  LayoutFix
//
//  Created by Andrew F. Dreher on 1/15/25.
//

import UIKit


class ViewController: BaseViewController {

  // Switching the computation to layout causes the logo to remain centered.
  // Note that this is only one of MANY different places this computation and
  // correction could occur, but the main point is that with the manual offset,
  // we need to recompute the position when the parent view changes.
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    centerDynamicLogo()
  }

}
