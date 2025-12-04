//
//  CoinImageViewModal.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 18/11/25.
//

import Foundation
import Combine
import SwiftUI

class CoinImageViewModal: ObservableObject {
    
    @Published var coinImage: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let fileManager = LocalFileManager.instance
    private let coinModel: CoinModel
    private let imageUrl: String
    private let imageName: String
    private let folderName = "coin_images"
    private var cancellables = Set<AnyCancellable>()
    
    
    init(coinModel: CoinModel) {
        self.coinModel = coinModel
        self.imageUrl = coinModel.image
        self.imageName = coinModel.id
        self.getCoinImage()
    }
    
    func getCoinImage() {
//        print("getting image from Coin directory")
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            coinImage = savedImage
        } else {
            fetchCoinImage()
        }
    }
    
    func fetchCoinImage() {
//        print("Downloading Coin")
        isLoading = true
        let url = imageUrl
        
            NetworkManager.fetchDataFromApi(url: url, method: "GET")
            .compactMap({ (data) -> UIImage? in
                    guard let image = UIImage(data: data) else {
                        return nil
                    }
                return image
                })
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] dowloadedImage in
                    guard let self = self else { return }
                    self.isLoading = false
                    self.coinImage = dowloadedImage
                    self.fileManager.saveImage(image: dowloadedImage, imageName: self.imageName, foldeName: self.folderName)
                })
                .store(in: &cancellables)
    }
}
