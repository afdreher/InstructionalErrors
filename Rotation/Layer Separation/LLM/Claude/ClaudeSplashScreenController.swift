//
//  ClaudeSplashScreenController.swift
//  LLM-Claude
//
//  Created using Claude.ai on 2/20/25.
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
/// This version was created using Claude 3.5 Sonnet from Claude.ai. The
/// solution works as expected. The background was set to black manually
/// because the prompt did not initially include this specification.

// EDIT: Added the prefix Claude... to avoid name conflicts
class ClaudeSplashViewController: UIViewController {

  private let staticLogoView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let dynamicLogoView: UIView = {
    let view = UIView()
    view.backgroundColor = .orange
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alpha = 0 // Start invisible
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  private func setupViews() {
    // Set background color
    view.backgroundColor = .black // Edit: changed from .white to .black

    // Add subviews
    view.addSubview(dynamicLogoView)
    view.addSubview(staticLogoView)

    // Configure constraints
    NSLayoutConstraint.activate([
      // Static logo constraints
      staticLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      staticLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      staticLogoView.widthAnchor.constraint(equalToConstant: 250),
      staticLogoView.heightAnchor.constraint(equalToConstant: 350),

      // Dynamic logo constraints
      dynamicLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      dynamicLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      dynamicLogoView.widthAnchor.constraint(equalToConstant: 380),
      dynamicLogoView.heightAnchor.constraint(equalToConstant: 350)
    ])
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animateDynamicLogo()
  }

  private func animateDynamicLogo() {
    UIView.animate(withDuration: 2.0) {
      self.dynamicLogoView.alpha = 1.0
    }
  }
}
