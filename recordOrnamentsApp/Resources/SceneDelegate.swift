//
//  SceneDelegate.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/03.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

//                let window = UIWindow(windowScene: scene as! UIWindowScene)
//                self.window = window
//                window.makeKeyAndVisible()
//                //ここから下で最初に表示する画面を設定する
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let ornamentViewController = storyboard.instantiateViewController(identifier: "OrnamentViewController") as! OrnamentViewController
//                //ornamentViewController.checkIfUserIsLoggedIn()
//            let navornamentViewController = UINavigationController(rootViewController: ornamentViewController)
//               // window.rootViewController = ornamentViewController
//                window.rootViewController = navornamentViewController
        guard let _ = (scene as? UIWindowScene) else { return }
        if Auth.auth().currentUser != nil {
            skipLogin()
        }
    }
    func skipLogin() {
        //使ってるストーリーボード（何もいじってない限り ファイル名は"Main.storyboard" なので "Main" と記入。
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        //ログイン後に飛びたいストーリボード。Identifier は Main.storyboard で設定。
        let ornamentViewController = storyboard.instantiateViewController(identifier: "OrnamentViewController")

        //rootViewController (初期画面）を homeViewController にする。
       let navornamentViewController = UINavigationController(rootViewController: ornamentViewController)
        //window?.rootViewController = ornamentViewController
        window?.rootViewController =  navornamentViewController
        //画面を表示。
        window?.makeKeyAndVisible()
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
        // to restore the scene back to its current state.
    }
    
    
}

