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
        lbl.textColor = .black
        lbl.layer.borderWidth = 3
        lbl.layer.borderColor = UIColor.black.cgColor
        lbl.font = .systemFont(ofSize: 25, weight: .bold)
        lbl.textAlignment = .center
        lbl.frame = CGRect(x: 0, y: 0, width: 70, height: 40)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let backBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("MENU", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        btn.tintColor = .black
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.black.cgColor
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: - Actions
    @objc private func didPressBackBtn() {
        navigationController?.popViewController(animated: false)
    }

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // bind views
        bindViews()
        // start timer
        viewModel.startTimer()
        // apply delegates
        applyGameDelegate()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        // timer
        viewModel.$timerValue.sink { [weak self] value in
            self?.timerLbl.text = "\(value)"
        }.store(in: &subscriptions)
        // result
        viewModel.$gameResult.sink { [weak self] result in
            guard let result = result else { return }
            self?.gameView.isPaused = true
            let vc = ResultVC()
            vc.loadResult(with: result)
            self?.navigationController?.pushViewController(vc, animated: true)
        }.store(in: &subscriptions)
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(gameView)
        gameView.presentScene(gameScene)
        view.addSubview(timerLbl)
        view.addSubview(backBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let timerLblConstraints = [
            timerLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            timerLbl.heightAnchor.constraint(equalToConstant: 40),
            timerLbl.widthAnchor.constraint(equalToConstant: 70)
        ]
        
        let backBtnConstraints = [
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            backBtn.topAnchor.constraint(equalTo: timerLbl.topAnchor),
            backBtn.heightAnchor.constraint(equalToConstant: 40),
            backBtn.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(timerLblConstraints)
        NSLayoutConstraint.activate(backBtnConstraints)
    }
    
    //MARK: - Configure nav bar
    func configureNavBar() {
        backBtn.addTarget(self, action: #selector(didPressBackBtn), for: .touchUpInside)
        let leftBtn = UIBarButtonItem(customView: backBtn)
        let rightBtn = UIBarButtonItem(customView: timerLbl)
        navigationItem.leftBarButtonItem = leftBtn
        navigationItem.rightBarButtonItem = rightBtn
    }
}

//MARK: - GameDelegate
extension GameVC: GameDelegate {
    // apply game delegate
    private func applyGameDelegate() {
        gameScene.gameDelegate = self
    }
    // did lose
    func didLose() {
        viewModel.gameResult = .lose
    }
}
