//
//  CoinRowView.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 13/11/25.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    var showHoldingsColumn: Bool
    
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

#Preview(traits: .fixedLayout(width: 100, height: 100)) {
    CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
        //        .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
}
#Preview(traits: .fixedLayout(width: 100, height: 100)) {
    CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
            .preferredColorScheme(.dark)
}

extension CoinRowView {
    var leftColumn : some View {
        HStack(spacing: 5) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 20)
            CoinImageView(coinModel: coin)
                .frame(width: 30, height: 30)
            Text(coin.name)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    var centerColumn : some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    var rightColumn : some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "0")
                .foregroundStyle(
                    coin.priceChangePercentage24H ?? 0 >= 0 ?
                    Color.theme.green :
                        Color.theme.red )
        }
        .padding(.leading, 20)
    }
}
