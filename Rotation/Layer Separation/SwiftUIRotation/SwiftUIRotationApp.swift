//
//  SwiftUIRotationApp.swift
//  SwiftUIRotation
//
//  Created by Andrew F. Dreher on 2/20/25.
//

import SwiftUI


// Support an enviromental variable. This is overkill here, but it emulates
// having a global theme. We might want to use this, for example, to reduce
// motion effects, etc. based on user accessibility preferences.
private struct AnimateOnLaunchKey: EnvironmentKey {
  static let defaultValue: Bool = false
}

extension EnvironmentValues {

  var isAnimatedOnLaunch: Bool {
    get { self[AnimateOnLaunchKey.self] }
    set { self[AnimateOnLaunchKey.self] = newValue }
  }

}


@main
struct SwiftUIRotationApp: App {

  @Environment(\.isAnimatedOnLaunch) var isAnimatedOnLaunch

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.isAnimatedOnLaunch, false)
    }
  }

}
