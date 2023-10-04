//
//  AppDelegate.swift
//  noStoryboard
//
//  Created by Dajun Xian on 2023/10/2.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        dummyViewController.delegate = self
        window?.rootViewController = loginViewController
        //window?.rootViewController = OnboardingContainerViewController()
        //window?.rootViewController = OnboardingViewController(heroImageName: "delorean", titleText: "Look at my awsome delorean dmc-12. Wanna take a ride?")
        return true
    }


}

extension AppDelegate: LoginViewControllerDelegate,         OnboardingContainerViewControllerDelegate,
                       LogoutDelegate{
    func didLogout() {
        setRootViewController(loginViewController)
    }
    
    func onboardingFinished() {
        LocalState.hasOnboarded = true
        setRootViewController(dummyViewController)
    }
    
    func didLogIn() {
        if LocalState.hasOnboarded {
            setRootViewController(dummyViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
        
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, 
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
