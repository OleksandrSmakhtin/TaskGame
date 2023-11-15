//
//  ViewController.swift
//  TaskGame
//
//  Created by Oleksandr Smakhtin on 14/11/2023.
//

import UIKit

class MenuVC: UIViewController {
    
    //MARK: - UI Objects
    private let playBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("PLAY", for: .normal)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.black.cgColor
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        btn.tintColor = .black
        btn.addTarget(nil, action: #selector(didPlayBtnPressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: - Actions
    @objc private func didPlayBtnPressed() {
        let vc = GameVC()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg
        view.backgroundColor = .white
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(playBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let playBtnConstraints = [
            playBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playBtn.heightAnchor.constraint(equalToConstant: 60),
            playBtn.widthAnchor.constraint(equalToConstant: 200)
        ]
        
        NSLayoutConstraint.activate(playBtnConstraints)
    }
}

