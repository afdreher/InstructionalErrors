//
//  ViewController.swift
//  LLM-Gemini
//
//  Created using Gemini on 2/20/25.
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
/// This version was generated using Google Gemini 2.0 Flash. It is a correct
/// solution. The background was set to black manually because the prompt did
/// not initially include this specification.

// EDIT: Added the prefix Gemini... to avoid name conflicts
class GeminiSplashScreenViewController: UIViewController {

  private let staticLogoView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()

  private let dynamicLogoView: UIView = {
    let view = UIView()
    view.backgroundColor = .orange
    view.alpha = 0 // Initially hidden
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black // Or any background color you desire

    view.addSubview(staticLogoView)
    view.addSubview(dynamicLogoView)

    setupConstraints()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animateDynamicLogo()
  }

  private func setupConstraints() {
    staticLogoView.translatesAutoresizingMaskIntoConstraints = false
    dynamicLogoView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      // Static Logo Constraints
      staticLogoView.widthAnchor.constraint(equalToConstant: 250),
      staticLogoView.heightAnchor.constraint(equalToConstant: 350),
      staticLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      staticLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

      // Dynamic Logo Constraints
      dynamicLogoView.widthAnchor.constraint(equalToConstant: 380),
      dynamicLogoView.heightAnchor.constraint(equalToConstant: 350),
      dynamicLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      dynamicLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])

    // Ensure static logo is above dynamic logo
    view.bringSubviewToFront(staticLogoView)
  }

  private func animateDynamicLogo() {
    UIView.animate(withDuration: 2.0) {
      self.dynamicLogoView.alpha = 1
    }
  }

}
