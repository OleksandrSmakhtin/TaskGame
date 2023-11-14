//
//  GameVC.swift
//  TaskGame
//
//  Created by Oleksandr Smakhtin on 14/11/2023.
//

import UIKit
import SpriteKit
import Combine


class GameVC: UIViewController {
    
    //MARK: - ViewModel
    private var viewModel = GameViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - Scene
    private lazy var gameView = SKView(frame: view.frame)
    private lazy var gameScene = GameScene(size: view.frame.size)
    
    //MARK: - UI Objects
    private let timerLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "30"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // add subviews
        addSubviews()

    }
    
    //MARK: - Bind views
    private func bindViews() {
        
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(gameView)
        gameView.presentScene(gameScene)
        view.addSubview(timerLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let timerLblConstraints = [
            timerLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerLbl
        ]
    }

}
