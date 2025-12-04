//
//  NetworkManager.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 15/11/25.
//

import Foundation
import Combine

class NetworkManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unkoown
    }

    static func fetchDataFromApi(url: String, method: String, body: Data? = nil, header: [String: String]? = nil)
    -> AnyPublisher<Data, Error> {
        
        guard let url = URL(string: url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
     
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)                                                // only data transformation no error throw
            .tryMap({ try self.handleURLResponse(output: $0, url: url) })           // .tryMap - Transforms data and also thorw errors if any
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
//          .subscribe()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
//            throw URLError(.badServerResponse)
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<any Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Api Error: \(error.localizedDescription)")
        }
    }
}
