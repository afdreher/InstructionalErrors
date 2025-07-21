//
//  CopilotSplashScreenView.swift
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
///
///
/// This version was created using Microsoft Copilot. Interestingly enough,
/// Copilot generated both the view and view controller whereas the other LLMs
/// generated only a view controller.

// EDIT: Added the prefix Copilot... to avoid name conflicts
class CopilotSplashScreenView: UIView {

  let staticLogoView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  let dynamicLogoView: UIView = {
    let view = UIView()
    view.backgroundColor = .orange
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alpha = 0.0
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .black
    self.addSubview(staticLogoView)
    self.addSubview(dynamicLogoView)

    NSLayoutConstraint.activate([
      staticLogoView.widthAnchor.constraint(equalToConstant: 250),
      staticLogoView.heightAnchor.constraint(equalToConstant: 350),
      staticLogoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      staticLogoView.centerYAnchor.constraint(equalTo: self.centerYAnchor),

      dynamicLogoView.widthAnchor.constraint(equalToConstant: 380),
      dynamicLogoView.heightAnchor.constraint(equalToConstant: 350),
      dynamicLogoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      dynamicLogoView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func animateDynamicLogo() {
    UIView.animate(withDuration: 2.0) {
      self.dynamicLogoView.alpha = 1.0
    }
  }
}
