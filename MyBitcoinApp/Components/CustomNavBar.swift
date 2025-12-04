//
//  CustomNavBar.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 08/08/25.
//

import SwiftUI
extension View {
    public func topNavBar(navBarTitle: String) -> some View {
        modifier(CustomNavBar(title: navBarTitle))
    }
}

struct CustomNavBar: ViewModifier {
    @EnvironmentObject var vm: HomeViewModel
    var title: String
    @State var isToggleButton = false
    
    func body(content: Content) -> some View {
        VStack {
            HStack(alignment: .center) {
                CircleButton(isBackbtn: false, imageName: isToggleButton ? "plus" : "info", isToggleButton: $isToggleButton) {
                    if isToggleButton {
                        print("Pluse button pressed")
                    } else {
                        print("Information button pressed")
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $isToggleButton)
                )
                .padding(.leading, 20)
                .frame(alignment: .leading)
                Spacer()
                Text(vm.showPortFolio ? "Portfolio" : "Live Prices")
                    .bold()
                    .font(.headline)
                    .frame(alignment: .center)
                Spacer()
                CircleButton(isBackbtn: true, imageName: "chevron.right", isToggleButton: $isToggleButton) {
                    if isToggleButton {
                        print("Back button pressed")
                        withAnimation() {
                            vm.showPortFolio = false
                        }
                    } else {
                        print("Next button pressed")
                        withAnimation() {
                            vm.showPortFolio = true
                        }
                    }
                }
                .rotationEffect(Angle(degrees: isToggleButton ? 180 : 0))
                .padding(.trailing, 20)
                .frame(alignment: .trailing)
            }
            content
                .navigationBarHidden(true)
        }
    }
}

//#Preview {
//    CustomNavBar(title: "Custom Navbar")
//}
