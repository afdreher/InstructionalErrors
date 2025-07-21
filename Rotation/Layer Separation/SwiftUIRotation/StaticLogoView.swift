//
//  StaticLogoView.swift
//  Rotation Demo
//
//  Created by Andrew F. Dreher on 2/20/25.
//

import SwiftUI


// Represent the static logo as a red rectangle
struct StaticLogoView: View {

  var body: some View {
    Rectangle()
      .fill(Color.red)
      .frame(width: 250, height: 350)
  }

}


#Preview {
  StaticLogoView()
}
