//
//  ViewController.swift
//  TaskGame
//
//  Created by Oleksandr Smakhtin on 14/11/2023.
//

import UIKit

class MenuVC: UIViewController {
    
    //MARK: - UI Objects
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Mr. Ball")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logoLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Mr. Ball"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 45, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let playBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("PLAY", for: .normal)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 4
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
        view.addSubview(logoImageView)
        view.addSubview(logoLbl)
        view.addSubview(playBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let logoImageViewConstraints = [
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            logoImageView.heightAnchor.constraint(equalToConstant: 260),
            logoImageView.widthAnchor.constraint(equalToConstant: 260)
        ]
        
        let logoLblConstraints = [
            logoLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLbl.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30)
        ]
        
        let playBtnConstraints = [
            playBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playBtn.topAnchor.constraint(equalTo: logoLbl.bottomAnchor, constant: 30),
            playBtn.heightAnchor.constraint(equalToConstant: 60),
            playBtn.widthAnchor.constraint(equalToConstant: 200)
        ]
        
        NSLayoutConstraint.activate(logoImageViewConstraints)
        NSLayoutConstraint.activate(logoLblConstraints)
        NSLayoutConstraint.activate(playBtnConstraints)
    }
}

