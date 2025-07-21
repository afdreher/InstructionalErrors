//
//  CopilotSplashScreenViewController.swift
//  LLM-Copilot
//
//  Created using Copilot on 2/21/25.
//

import UIKit


/// This is a demonstration of the code created using LLMs
///
/// The prompt:
/// Please create a UIView and associated UIViewController for iOS to serve as
/// a splash screen that has two subviews, representing a “static” and a
/// “dynamic” logo. These subviews should be centered inside the primary view,
/// and the z-index of the static logo view above that of the dynamic one. When
/// the view finishes appearing on screen, the dynamic logo view should slowly
/// (e.g., 2 seconds) fade into view. Because the art department has not yet
/// completed the real assets, please represent the static logo as a red
/// rectangle of size 250 pixels wide by 350 pixels tall, and the dynamic logo
/// as an orange rectangle of size 380 pixels wide and 350 pixels tall.

class SplashScreenViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let splashScreenView = CopilotSplashScreenView(frame: self.view.bounds)
    self.view.addSubview(splashScreenView)

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      splashScreenView.animateDynamicLogo()
    }
  }

}
