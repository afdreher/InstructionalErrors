//
//  ViewController.swift
//  LLM-Llama405B
//
//  Created using Llama 3.1 405B 3/19/25.
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
/// This version was generated using Llama 3.1-405B running on SambaNova's
/// cloud. It is *almost* a correct solution. As written, one will see only a
/// black screen because setting
/// `translatesAutoresizingMaskIntoConstraints = false` means that the height
/// and width set during construction will not be converted into constraints.
/// One can correct the code by adding the height and width constraints for the
/// individual views. As with the others, the background was set to black
/// because the prompt did not initially include this specification, and the
/// LLM generated the code with `.white`.

// EDIT: Added the prefix Llama405B... to avoid name conflicts
class Llama405BSplashScreenViewController: UIViewController {

  // Create static and dynamic logo views
  let staticLogoView: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
    view.backgroundColor = .red
    return view
  }()

  let dynamicLogoView: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 380, height: 350))
    view.backgroundColor = .orange
    view.alpha = 0.0 // Start with alpha 0.0 to fade in later
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Configure the primary view's background color
    view.backgroundColor = .black // EDIT: Changed from .white to .black

    // Add static and dynamic logo views to the primary view
    view.addSubview(dynamicLogoView) // Add dynamic view first for z-index
    view.addSubview(staticLogoView) // Add static view second for higher z-index

    // Apply constraints to center static and dynamic logo views inside the primary view
    staticLogoView.translatesAutoresizingMaskIntoConstraints = false
    dynamicLogoView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      staticLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      staticLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

      dynamicLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      dynamicLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

      // EDIT: Uncomment the following lines for the correct constraints
      // staticLogoView.widthAnchor.constraint(equalToConstant: 250),
      // staticLogoView.heightAnchor.constraint(equalToConstant: 350),
      // dynamicLogoView.widthAnchor.constraint(equalToConstant: 380),
      // dynamicLogoView.heightAnchor.constraint(equalToConstant: 350)
    ])
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Fade the dynamic logo view into view after the view appears on screen
    UIView.animate(withDuration: 2.0) {
      self.dynamicLogoView.alpha = 1.0
    }
  }

}
