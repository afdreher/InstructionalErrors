//
//  ViewController.swift
//  WillTransitionFix
//
//  Created by Andrew F. Dreher on 3/12/25.
//

import UIKit


class ViewController: BaseViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // As with the Incorrect Rotation, we set the dynamic view's center on load
    centerDynamicLogo()
  }

  // Since the view will transition to a new size, we need to update the center
  // of the dynamic logo. This update needs to occur simultaneously with the
  // transition animation, so we need to perform the update using the
  // coordinator's alongsideTransition(:)
  override func viewWillTransition(
    to size: CGSize,
    with coordinator: any UIViewControllerTransitionCoordinator
  ) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: { _ in
      self.centerDynamicLogo()
    })
  }

}

