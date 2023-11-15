//
//  GameViewViewModel.swift
//  TaskGame
//
//  Created by Oleksandr Smakhtin on 14/11/2023.
//

import Foundation
import Combine

enum GameResult {
    case win
    case lose
}

final class GameViewViewModel: ObservableObject {
    
    @Published var timerValue = 0
    @Published var gameResult: GameResult?
    private var timer: Timer?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    @objc private func timerAction() {
        timerValue += 1
        if timerValue == 30 {
            gameResult = .win
        }
    }
}
