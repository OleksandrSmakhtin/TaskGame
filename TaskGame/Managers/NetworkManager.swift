//
//  NetworkManager.swift
//  TaskGame
//
//  Created by Oleksandr Smakhtin on 14/11/2023.
//

import Foundation
import Combine


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func getUrls() {
        let url = URL(string: K.requestUrl)!
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Urls.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { urls in
                print(urls)
                UserDefaults.standard.setValue(urls.winner, forKey: K.win)
                UserDefaults.standard.setValue(urls.loser, forKey: K.lose)
            }.store(in: &subscriptions)
    }
    
    
}
