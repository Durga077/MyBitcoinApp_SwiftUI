//
//  HomeViewModal.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 13/11/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var allCoins: [CoinModel] = []
    var filtredCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var showPortFolio: Bool = false
    
    //    let networkManager: NetworkManager?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchAllCoins()
        addSubscribers()
    }
    
    func fetchAllCoins() {
        let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&sparkline=false"
        let method = "GET"
        
        let params: [String: Any] = ["x-cg-demo-api-key": "CG-qx9BczUEb8nqdmo9WS9spr1K"]
        let jsonData = try?JSONSerialization.data(withJSONObject: params)
        
        let header = ["Content-Type": "application/json"]
        
        NetworkManager.fetchDataFromApi(url: url, method: method, body: jsonData, header: header)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] allcoins in
                self?.allCoins = allcoins
                self?.filtredCoins = allcoins
                print(allcoins)
            })
            .store(in: &cancellables)
    }
    
    func addSubscribers() {
        $searchText                            // $searchText and $allCoins are publisher so also can be a subscriber to give output data
            .combineLatest($allCoins)          // combined 2 subscribers to give 2 outputs
//            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)   // delay for search 0.5 sec
            .map(filterCoins)   // filterCoins(searchedText: output of searchText, fetchedCoins: output of allCoins)
            .sink { filtredCoins in
                self.filtredCoins = filtredCoins
            }
            .store(in: &cancellables)
    }
    
    func filterCoins(searchedText: String, fetchedCoins: [CoinModel]) -> [CoinModel] {
        guard !searchedText.isEmpty else {
            return allCoins
        }
        let searchedlowerCaseText = searchedText.lowercased()
        
        return fetchedCoins.filter { coin in
            return coin.name.lowercased().contains(searchedlowerCaseText) ||
            coin.symbol.lowercased().contains(searchedlowerCaseText) ||
            coin.id.lowercased().contains(searchedlowerCaseText)
        }
    }
    
}
