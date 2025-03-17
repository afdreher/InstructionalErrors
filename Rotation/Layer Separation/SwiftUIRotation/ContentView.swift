//
//  ContentView.swift
//  SwiftUIRotation
//
//  Created by Andrew F. Dreher on 2/20/25.
//

import SwiftUI


struct ContentView: View {

  /// Boolean indicating if the current view will animate on launch.
  @Environment(\.isAnimatedOnLaunch) private var isAnimatedOnLaunch

  /// Is the dynamic logo currently showing
  @State var dynamicLogoIsShowing = false

  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()

      // Stack the "logos"
      ZStack(alignment: .center) {
        // Add the dynamic logo *if* the state value is true, creating the
        // fade-in effect
        if dynamicLogoIsShowing {
          DynamicLogoView()
            .transition(.opacity)
        }
        StaticLogoView()
      }
      // The value part of the animation is irrelevant since we aren't
      // monitoring the environmental variable. The duration is either 0
      // to skip the animation or 2s to match the UIKit examples.
      .animation(
        Animation.easeInOut(duration: isAnimatedOnLaunch ? 2 : 0),
        value:dynamicLogoIsShowing
      )
      .onAppear {
        // Set the value to true triggering the animation (or not)
        self.dynamicLogoIsShowing = true
      }
    }
  }

}


#Preview {
    ContentView()
}
