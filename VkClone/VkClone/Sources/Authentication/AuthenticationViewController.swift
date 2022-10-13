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
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
        button.layer.cornerRadius = 15
        button.layer.shadowRadius = 1
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .vkBlue
        return button
    }()
    
    private let vkLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vk logo")
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.cornerRadius = 25
        imageView.layer.shadowOffset = .zero
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        view.backgroundColor = .white
    }
    
    private func layout() {
        view.addSubview(loginVkWithBrowserButton)
        view.addSubview(vkLogoImageView)
        
        NSLayoutConstraint.activate([
            loginVkWithBrowserButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            loginVkWithBrowserButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -300),
            loginVkWithBrowserButton.widthAnchor.constraint(
                equalToConstant: 150),
            loginVkWithBrowserButton.heightAnchor.constraint(
                equalToConstant: 60),
            
            vkLogoImageView.bottomAnchor.constraint(
                equalTo: loginVkWithBrowserButton.topAnchor,
                constant: -50),
            vkLogoImageView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            vkLogoImageView.widthAnchor.constraint(
                equalToConstant: 150),
            vkLogoImageView.heightAnchor.constraint(
                equalToConstant: 150)
        ])
    }
}
