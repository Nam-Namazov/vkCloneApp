//
//  AuthenticationViewController.swift
//  VkClone
//
//  Created by Намик on 8/27/22.
//

import UIKit

final class AuthenticationViewController: UIViewController {
    private let loginVkWithBrowserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти в VK", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared().authService
        style()
        layout()
        buttonTarget()
    }
    
    private func buttonTarget() {
        loginVkWithBrowserButton.addTarget(
            self,
            action: #selector(signInTouch),
            for: .touchUpInside
        )
    }
    
    @objc
    private func signInTouch() {
        authService.wakeUpSession()
    }
    
    private func style() {
        view.backgroundColor = .vkBlue
    }
    
    private func layout() {
        view.addSubview(loginVkWithBrowserButton)
        NSLayoutConstraint.activate([
            loginVkWithBrowserButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            loginVkWithBrowserButton.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            loginVkWithBrowserButton.widthAnchor.constraint(
                equalToConstant: 150),
            loginVkWithBrowserButton.heightAnchor.constraint(
                equalToConstant: 40)
        ])
    }
}
