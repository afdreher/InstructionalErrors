//
//  LLamaSplashScreenController.swift
//  LLM-Llama8B
//
//  Created using Ollma and Llama 3.2 8B on 2/20/25.
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
/// This example, which fails to compile, was created using Llama 3.2-8B
/// running on Ollama. Unlike the others, Llama 3.2 8B is a small local
/// model, so we should not expect the same quality of result, which we,
/// indeed, do not get. Unlike the online LLM versions, this version requires
/// cleanup to compile. I have fixed the compilation errors to see what would
/// happen with running code, but have minimally adjusted the logic.
///
/// Interestingly, if one replaces "should be centered inside" with " should
/// remain centered inside," the overall code quality sometimes improves
/// because the LLM switches to use NSLayoutConstraints. However, this does
/// not always occur.
///
/// Note that like the first (February) Copilot run, this model generates the
/// incorrect layer order.

// EDIT: Added the prefix Llama8B... to avoid name conflicts
class Llama8BSplashScreenViewController: UIViewController {

  // Constants for the logos' sizes
  let staticLogoWidth = 250
  let staticLogoHeight = 350
  let dynamicLogoWidth = 380
  let dynamicLogoHeight = 350

  // Properties to hold references to the logos' views
  var staticLogoView: UIView! // EDIT: Changed from let to var
  var dynamicLogoView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Create and configure the static logo view
    let staticLogo = UIView(
      frame: CGRect(
        x: (Int(view.bounds.width) - staticLogoWidth) / 2,
        y: (Int(view.bounds.height) - staticLogoHeight) / 2,
        width: staticLogoWidth,
        height: staticLogoHeight
      )
    )
    staticLogo.backgroundColor = .red
    staticLogoView = staticLogo

    // Create and configure the dynamic logo view
    let dynamicLogo = UIView(
      frame: CGRect(
        x: (Int(view.bounds.width) - dynamicLogoWidth) / 2,
        y: (Int(view.bounds.height) - dynamicLogoHeight) / 2,
        width: dynamicLogoWidth,
        height: dynamicLogoHeight))
    dynamicLogo.backgroundColor = .orange
    dynamicLogoView = dynamicLogo

    // Add the static logo view to the top and the dynamic logo view below it
    self.view.addSubview(staticLogoView)
    self.view.addSubview(dynamicLogoView)

    // Disable auto layout to make this custom code work
    dynamicLogoView.autoresizingMask = [] // EDIT: Replaced .none, marked as unavailable, with []

    // Animate the appearance of the dynamic logo
//    let animation = CABasicAnimation(keyPath: "opacity")
//    animation.fromValue = 1.0
//    animation.toValue = 0.0
//    animation.duration = 2.0
//    dynamicLogoView.layer.add(animation, forKey: nil)
  }

}


// ORIGINAL
//class SplashScreenViewController: UIViewController {
//
//    // Constants for the logos' sizes
//    let staticLogoWidth = 250
//    let staticLogoHeight = 350
//    let dynamicLogoWidth = 380
//    let dynamicLogoHeight = 350
//
//    // Properties to hold references to the logos' views
//    let staticLogoView: UIView!
//    let dynamicLogoView: UIView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Create and configure the static logo view
//        let staticLogo = UIView(frame: CGRect(x: (view.bounds.width - staticLogoWidth) / 2, y: (view.bounds.height -
//staticLogoHeight) / 2, width: staticLogoWidth, height: staticLogoHeight))
//        staticLogo.backgroundColor = .red
//        staticLogoView = staticLogo
//
//        // Create and configure the dynamic logo view
//        let dynamicLogo = UIView(frame: CGRect(x: (view.bounds.width - dynamicLogoWidth) / 2, y: (view.bounds.height -
//dynamicLogoHeight) / 2, width: dynamicLogoWidth, height: dynamicLogoHeight))
//        dynamicLogo.backgroundColor = .orange
//        dynamicLogoView = dynamicLogo
//
//        // Add the static logo view to the top and the dynamic logo view below it
//        self.view.addSubview(staticLogoView)
//        self.view.addSubview(dynamicLogoView)
//
//        // Positioning the views at different z-index levels
//        staticLogoView.zPosition = 1
//        dynamicLogoView.zPosition = 0
//
//        // Disable auto layout to make this custom code work
//        dynamicLogoView.autoresizingMask = .none
//
//        // Animate the appearance of the dynamic logo
//        let animation = CABasicAnimation(keyPath: "opacity")
//        animation.fromValue = 1.0
//        animation.toValue = 0.0
//        animation.duration = 2.0
//        dynamicLogoView.layer.add(animation, forKey: nil)
//
//    }
//
//}
