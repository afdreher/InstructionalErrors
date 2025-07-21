//
//  StaticLogoView.swift
//  Rotation Demo
//
//  Created by Andrew F. Dreher on 2/20/25.
//

import SwiftUI


// Represent the dynamic logo as an orange rectangle
struct DynamicLogoView: View {
  
  var body: some View {
    Rectangle()
      .fill(Color.orange.opacity(0.7))
      .frame(width: 380, height: 350)
  }

}


#Preview {
  DynamicLogoView()
}

