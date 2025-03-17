//
//  ViewController.swift
//  MapRotation
//
//  Created by Andrew F. Dreher on 3/12/25.
//

import MapKit
import UIKit


class ViewController: UIViewController {

  // MARK: Constants / Enums

  enum Constants {

    // Constants defining the view height for different screen configurations
    enum DetailViewHeight {
      static let landscape: CGFloat = 150
      static let portrait: CGFloat = 350
    }
  }

  /// Enum for how the animation should be timed relative to the rotation animation
  enum AnimationOrder: Int {
    case simultaneous = 0
    case sequential = 1
  }

  // MARK: Variables

  @IBOutlet var mapView: MKMapView!

  // Segmented control for picking the animation sequencing
  @IBOutlet var segmentedControl: UISegmentedControl!

  var detailView: UIView = {
    let view = UIView()
    view.backgroundColor = .orange.withAlphaComponent(0.75)
    view.clipsToBounds = true
    return view
  }()

  // These constraints are exposed to allow the detail view to change
  var detailViewHeightConstraint: NSLayoutConstraint!
  var detailViewWidthConstraint: NSLayoutConstraint!

  var detailViewHeight: CGFloat = Constants.DetailViewHeight.portrait {
    didSet { detailViewHeightConstraint?.constant = detailViewHeight }
  }

  var detailViewWidth: CGFloat = 300 {
    didSet { detailViewWidthConstraint?.constant = detailViewWidth }
  }


  // MARK: IBActions

  var animationOrder: AnimationOrder = .sequential

  @IBAction func changeAnimationTiming(_ sender: AnyObject) {
    if let nextActionTiming = AnimationOrder(rawValue: segmentedControl.selectedSegmentIndex) {
      animationOrder = nextActionTiming
    }
  }


  // MARK: View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    // Ensure that the segmented control is synced with the data
    segmentedControl.selectedSegmentIndex = animationOrder.rawValue

    view.addSubview(detailView)
    detailView.translatesAutoresizingMaskIntoConstraints = false

    // Set the constraints
    NSLayoutConstraint.activate([
      detailView.leadingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
        constant: 20
      ),
      detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    detailViewHeightConstraint =
      detailView.heightAnchor.constraint(equalToConstant: detailViewHeight)
    detailViewWidthConstraint =
      detailView.widthAnchor.constraint(equalToConstant: detailViewWidth)
    detailViewHeightConstraint.isActive = true
    detailViewWidthConstraint.isActive = true
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // Set the initial map position and view
    mapView.setCenter(pointOfInterest(forSize: view.bounds.size), animated: false)
    mapView.camera.centerCoordinateDistance = 5000 // Set the initial distance

    setDetailViewHeight(forSize: view.bounds.size)
  }


  // MARK: Transition

  override func viewWillTransition(
    to size: CGSize,
    with coordinator: any UIViewControllerTransitionCoordinator
  ) {
    super.viewWillTransition(to: size, with: coordinator)

    setDetailViewHeight(forSize: size)
    let poi = pointOfInterest(forSize: size)
    coordinator.animate(
      alongsideTransition: { _ in
        self.view.layoutIfNeeded()

        // Set the center *with* the transition if simultaneous
        if self.animationOrder == .simultaneous {
          // NOTE: Every so often there is a render glitch at the end of the
          // transition from PORTRAIT to LANDSCAPE. This glitch is inside
          // MapKit and has been since at least the early iOS 7 days. Example:
          // https://stackoverflow.com/questions/21615551/bug-with-mkmapviews-centercoordinate-during-rotation
          //
          // The "proof" of the glitch is to replace poi with a constant value,
          // such as .ferryBuilding and rotate the screen. The view will have
          // an occasional render glitch as it moves the camera further from
          // the POI.
          self.animateToPointOfInterest(poi)
        }
      },
      completion: { _ in
        if self.animationOrder == .sequential {
          self.animateToPointOfInterest(poi)
        }
      })
  }

  /// Animate the map to a given location
  func animateToPointOfInterest(_ poi: CLLocationCoordinate2D) {
    mapView.setCenter(poi, animated: true)
  }


  // MARK: Support

  /// Get a point of interest in SF dependent on the view size
  ///
  /// I am picking a point of interest based on the view size to simulate the
  /// behavior of moving the map to account for the information view intruding
  /// on the visible area without delving into the computation required. This
  /// is just a gross simplification for demonstration purposes.
  func pointOfInterest(forSize size: CGSize) -> CLLocationCoordinate2D {
    return size.isLandscape ? .transamericaPyramid : .ferryBuilding
  }

  /// Set the height of the detail view
  ///
  /// This simulates the detail screen height change based on the layout.
  func setDetailViewHeight(forSize size: CGSize) {
    detailViewHeight = size.isLandscape
      ? Constants.DetailViewHeight.landscape
      : Constants.DetailViewHeight.portrait
  }

}


// Extension to add some famous San Francisco points of interest
extension CLLocationCoordinate2D {

  static let coitTower = CLLocationCoordinate2D(
    latitude: 37.8024,
    longitude: -122.4058
  )

  static let ferryBuilding = CLLocationCoordinate2D(
    latitude: 37.7954,
    longitude: -122.3936
  )

  static let transamericaPyramid = CLLocationCoordinate2D(
    latitude: 37.7952,
    longitude: -122.4028
  )

}


// Extension to categorize the orientation for the given size
extension CGSize {

  // Not for production!
  var isSquare: Bool { return width == height }
  var isLandscape: Bool { return width > height }
  var isPortrait: Bool { return height > width }

}
