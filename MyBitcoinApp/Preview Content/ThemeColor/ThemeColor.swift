//
//  ColorTheme.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 07/08/25.
//

import Foundation
import SwiftUI

extension Color {
    static let colorTheme = ThemeColor()
}

struct ThemeColor {
    static let colorTheme = ThemeColor()
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}
