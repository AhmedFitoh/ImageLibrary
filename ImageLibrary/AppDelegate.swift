//
//  AppDelegate.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setInitialScreen()
        return true
    }

    private func setInitialScreen(){
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = ImageListWireframe().navigationController
        window.makeKeyAndVisible()
    }
}



