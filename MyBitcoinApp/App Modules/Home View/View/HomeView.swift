//
//  ContentView.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 07/08/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        ZStack {
            Color.colorTheme.background
                .ignoresSafeArea()
            VStack {
                columnTitles
                SearchbarView(searchText: $vm.searchText)
                if vm.showPortFolio {
                    portFolioCoinsView
                        .transition(.move(edge: .trailing))
                } else {
                    allCoinsView
                        .transition(.move(edge: .leading))
                }
            }
        }
        .topNavBar(navBarTitle: "BitCoins")
    }
}

#Preview {
    HomeView()
        .environmentObject(DeveloperPreview.instance.homeVM)
}

extension HomeView {
    private var columnTitles : some View {
        HStack {
            Text("Coin")
            Spacer()
            if vm.showPortFolio {
                Text("Holdings")
            }
            Text("Price")
                .padding(.leading, 95)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal, 20)
    }
    
    var allCoinsView : some View {
        List {
            ForEach(vm.searchText.isEmpty ? vm.allCoins : vm.filtredCoins) { coin in
                CoinRowView(coin: coin,showHoldingsColumn: false)
            }
        }
        .listStyle(.plain)
    }
    
    var portFolioCoinsView : some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin,showHoldingsColumn: true)
            }
        }
        .listStyle(.plain)
    }
}
