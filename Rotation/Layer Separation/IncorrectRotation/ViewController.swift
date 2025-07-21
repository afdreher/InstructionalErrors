//
//  ViewController.swift
//  IncorrectRotation
//
//  Created by Andrew F. Dreher on 1/13/25.
//

import UIKit


class ViewController: BaseViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Center the dynamic logo when the the view controller initially loads.
    // This is the source of the problem, causing the incorrect rotation.
    centerDynamicLogo()
  }

}
