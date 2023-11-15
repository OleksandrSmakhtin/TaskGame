//
//  ResultVC.swift
//  TaskGame
//
//  Created by Oleksandr Smakhtin on 14/11/2023.
//

import UIKit
import WebKit

class ResultVC: UIViewController {
    
    //MARK: - UI Objects
    private let goToMenuBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("MENU", for: .normal)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.black.cgColor
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        btn.tintColor = .black
        btn.addTarget(nil, action: #selector(didMenuBtnPressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let webView: WKWebView = {
        let wv = WKWebView()
        wv.translatesAutoresizingMaskIntoConstraints = false
        return wv
    }()
    
    //MARK: - Actions
    @objc private func didMenuBtnPressed() {
        navigationController?.popToRootViewController(animated: false)
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
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(webView)
        view.addSubview(goToMenuBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let webViewConstraints = [
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let goToMenuBtnConstraints = [
            goToMenuBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToMenuBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            goToMenuBtn.heightAnchor.constraint(equalToConstant: 60),
            goToMenuBtn.widthAnchor.constraint(equalToConstant: 200)
        ]
        
        NSLayoutConstraint.activate(goToMenuBtnConstraints)
        NSLayoutConstraint.activate(webViewConstraints)
    }
    
    //MARK: - Load Win Screen
    func loadResult(with result: GameResult) {
        
        var urlString: String?
        
        switch result {
        case .win:
            urlString = UserDefaults.standard.string(forKey: K.win)
        case .lose:
            urlString = UserDefaults.standard.string(forKey: K.lose)
        }
        guard let urlString = urlString else { return }
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    //MARK: - Configure nav bar
    func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
