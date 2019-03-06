//
//  ViewController.swift
//  VKtest
//
//  Created by Sunrizz on 04/03/2019.
//  Copyright © 2019 Алексей Усанов. All rights reserved.
//

import UIKit
import SwiftyVK

class ViewController: UIViewController, SwiftyVKDelegate {
    
    let VK_APP_ID = "6878042"
    
    override func viewDidLoad() {
        VK.setUp(appId: VK_APP_ID, delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if VK.sessions.default.state == .authorized {
            self.showFeedScreen()
        }
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        VK.sessions.default.logIn(
            onSuccess: { _ in
                self.showFeedScreen()
        },
            onError: { _ in
        }
        )
    }
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return Scopes([.wall, .friends])
    }
    
    func vkNeedToPresent(viewController: VKViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func showFeedScreen() {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "mainfeed")
        self.present(newVC!, animated: true, completion: nil)
    }
}

