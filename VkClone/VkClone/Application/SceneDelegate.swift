//
//  SceneDelegate.swift
//  VkClone
//
//  Created by Намик on 8/27/22.
//

import UIKit
import VK_ios_sdk

final class SceneDelegate: UIResponder, UIWindowSceneDelegate, AuthServiceDelegate {
    
    var window: UIWindow?
    var authService: AuthService!
    
    static func shared() -> SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        let sd: SceneDelegate = (((scene?.delegate as? SceneDelegate)!))
        return sd
    }
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        authService = AuthService()
        authService.delegate = self
        window?.rootViewController = AuthenticationViewController()
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene,
               openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(
                url,
                fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }
    
    // MARK: - AuthServiceDelegate
    func authServiceShouldShow(viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true)
    }
    
    func authServiceSignIn() {
        print(#function)
        window?.rootViewController = NewsFeedViewController()
    }
    
    func authServiceSignInDidFail() {
        print(#function)
    }
}
