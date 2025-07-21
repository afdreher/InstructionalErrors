//
//  BaseViewController.swift
//  Rotation Demo
//
//  Created by Andrew F. Dreher on 1/13/25.
//

import Foundation
import UIKit


/// This is a common base class to store and interact with the static and
/// dynamic logos. I have added some animation on load so that the dynamic
/// logo fades in, just like in the 'real' app; however, I am leaving the
/// static logo in-place to highlight the relative positions. One can easily
/// disable the animate on launch feature by setting animateOnLaunch to False.
class BaseViewController: UIViewController {

  /// Proxy view representing the video that plays under the static logo
  @IBOutlet var dynamicLogo: UIView?

  /// Proxy view representing the static logo
  @IBOutlet var staticLogo: UIView?

  /// Should the 'dynamic logo' be animated, similar to the real app
  let animateOnLaunch: Bool = false

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if animateOnLaunch {
      dynamicLogo?.alpha = 0  // Set the dynamic logo to zero to simulate the fade in
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if animateOnLaunch, let dynamicLogo {
      // Animate the fade the fade in just like in the 'real' app
      UIView.animate(
        withDuration: 2.0,
        animations: { dynamicLogo.alpha = 1.0 }
      )
    }
  }

}
