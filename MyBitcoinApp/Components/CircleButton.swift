//
//  CircleButton.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 07/08/25.
//

import SwiftUI

struct CircleButton: View {
    var isBackbtn: Bool
    var imageName = "heart.fill"
    @Binding var isToggleButton: Bool
    var navigationAction: () -> Void
    var body: some View {
        Image(systemName: imageName)
        //            .font(.headline)
            .foregroundStyle(Color.colorTheme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.colorTheme.background)
            )
            .shadow(color: Color.colorTheme.accent.opacity(0.25),radius: 10)
            .onTapGesture {
                navigationAction()
                if isBackbtn {
                    withAnimation {
                        isToggleButton.toggle()
                    }
                    
                }
            }
    }
}

//#Preview(traits: .sizeThatFitsLayout) {
//    Group {
//        CircleButton()
//            .colorScheme(.light)
//        
//        CircleButton()
//            .colorScheme(.dark)
//    }
//}
