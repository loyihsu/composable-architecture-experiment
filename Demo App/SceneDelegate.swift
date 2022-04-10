//
//  SceneDelegate.swift
//  Demo App
//
//  Created by Yu-Sung Loyi Hsu on 2022/4/10.
//

import UIKit
import ComposableArchitecture
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return true
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        
        self.window = (scene as? UIWindowScene).map(UIWindow.init(windowScene:))
        
        let store = Store<LoginState, LoginAction>(
            initialState: LoginState(),
            reducer: loginReducer,
            environment: LoginEnvironment(mainQueue: .main)
        )
        
        let loginViewController = LoginViewController(store: store)
        
        self.window?.rootViewController = loginViewController
        self.window?.makeKeyAndVisible()
    }
}
