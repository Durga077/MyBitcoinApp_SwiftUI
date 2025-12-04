//
//  CircleButtonAnimationView.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 18/08/25.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeInOut(duration: 1.0) : .none, value: animate)
            .foregroundStyle(.red)
            .frame(width: 70, height: 70)
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
        .foregroundStyle(.red)
        .frame(width: 100, height: 100)
}
