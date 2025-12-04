//
//  MyBitcoinApp.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 07/08/25.
//

import SwiftUI


@main
struct MyBitcoinApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
//                HomeView()
                ImagedemoView()
                    .navigationBarHidden(true)
            }
        }
        .environmentObject(vm)
    }
}
