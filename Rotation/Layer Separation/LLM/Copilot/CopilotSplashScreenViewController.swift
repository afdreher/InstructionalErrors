//
//  CopilotSplashScreenViewController.swift
//  LLM-Copilot
//
//  Created using Copilot on 3/17/25.
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
///
///
/// This version was created using Microsoft Copilot. Interestingly enough, on
/// the first run, Copilot generated both a view and view controller file,
/// whereas on the second run, it followed the other LLMs and only generated
/// a view controller. It did, however, fix a mistake in the previous run by
/// reordering the view layers.
///
// EDIT: Added the prefix Copilot... to avoid name conflicts
class CopilotSplashScreenViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  private func setupViews() {
    // Main view background color
    view.backgroundColor = .black // Edit: Changed from .white to .black

    // Static logo (red rectangle)
    let staticLogo = UIView()
    staticLogo.backgroundColor = .red
    staticLogo.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(staticLogo)

    // Dynamic logo (orange rectangle)
    let dynamicLogo = UIView()
    dynamicLogo.backgroundColor = .orange
    dynamicLogo.alpha = 0 // Start fully transparent
    dynamicLogo.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(dynamicLogo)

    // Constraints for static logo
    NSLayoutConstraint.activate([
      staticLogo.widthAnchor.constraint(equalToConstant: 250),
      staticLogo.heightAnchor.constraint(equalToConstant: 350),
      staticLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      staticLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])

    // Constraints for dynamic logo
    NSLayoutConstraint.activate([
      dynamicLogo.widthAnchor.constraint(equalToConstant: 380),
      dynamicLogo.heightAnchor.constraint(equalToConstant: 350),
      dynamicLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      dynamicLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])

    // Bring static logo to the front
    view.bringSubviewToFront(staticLogo)

    // Animate the fade-in of the dynamic logo
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Slight delay after view appears
      UIView.animate(withDuration: 2.0) {
        dynamicLogo.alpha = 1.0 // Fade in
      }
    }
  }

}
