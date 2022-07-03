//
//  SceneDelegate.swift
//  MyBooks_App
//
//  Created by Felix Titov on 7/2/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit
import WatchConnectivity

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var session: WCSession?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationVC = UINavigationController(rootViewController: BooksViewController())
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        
        setupWatchConnectivity()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to retore the scene back to its current state.
    }
    
        func setupWatchConnectivity() {
            if WCSession.isSupported() {
                session = WCSession.default
                session?.delegate = self
                session?.activate()
            }
        }
    
}

extension SceneDelegate: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WC session activation failde with error: " + "\(error.localizedDescription)")
            return
        }
        print("WC session activated with state: " + "\(activationState.rawValue)")
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        print(#function)
    }

    func sessionDidDeactivate(_ session: WCSession) {
        print(#function)
        WCSession.default.activate()
    }

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print(applicationContext)
        var pickedBooks = [BookItem]()
        if let books = applicationContext["books"] as? [[String: Any]] {
            books.forEach { book in
                if let book = BookItem(data: book) {
                    pickedBooks.append(book)
                }
                    
            }
        }
        
        UserSettings.userBooks = pickedBooks
        
        DispatchQueue.main.async(execute: {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GetBooksFromWatch"), object: nil)
        })
        
    }
}
