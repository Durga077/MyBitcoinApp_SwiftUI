//
//  SwiftUIView.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 18/11/25.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm: CoinImageViewModal
    
    
    init(coinModel: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModal(coinModel: coinModel))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.coinImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
               Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

#Preview {
//    CoinImageView(imageUrl: "")
}
