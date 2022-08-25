//
//  SceneDelegate.swift
//  SpaceX
//
//  Created by Анна Сычева on 12.08.2022.
//

import UIKit

//MARK: - SceneDelegate

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    //MARK: - Public property

    var window: UIWindow?
    
    //MARK: - Public method

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        let viewController = FirstViewController()
        let navigationViewController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationViewController
    }
}
