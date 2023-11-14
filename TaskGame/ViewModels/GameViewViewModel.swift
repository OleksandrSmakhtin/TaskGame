//
//  GameViewViewModel.swift
//  TaskGame
//
//  Created by Oleksandr Smakhtin on 14/11/2023.
//

import Foundation
import Combine


final class GameViewViewModel: ObservableObject {
    
    @Published var timerValue = 0
    
    private var timer: Timer?
    private var subscriptions: Set<AnyCancellable> = []
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        timerValue += 1
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
}
