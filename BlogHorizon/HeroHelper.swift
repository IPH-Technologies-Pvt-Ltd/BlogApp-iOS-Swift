//
//  HeroHelper.swift
//  BlogHorizon
//
//  Created by IPH Technologies Pvt. Ltd. on 19/06/23.
//

import Foundation
import UIKit
import Hero
extension UIViewController{
    func disableHero(){
      
        navigationController?.hero.isEnabled = false
    }
    
    func enableHero(){
        hero.isEnabled = true
        navigationController?.hero.isEnabled = true
    }
    
    func showHero(_ viewController: UIViewController, navigationAnimationType: HeroDefaultAnimationType = .autoReverse(presenting: .zoomSlide(direction: .leading))){
        viewController.hero.isEnabled = true
        navigationController?.hero.isEnabled = true
        navigationController?.hero.navigationAnimationType = navigationAnimationType
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UINavigationController{
    func show(_ viewController: UIViewController, navigationAnimationType: HeroDefaultAnimationType = .autoReverse(presenting: .zoomSlide(direction: .leading))){
        viewController.hero.isEnabled = true
        hero.isEnabled = true
        hero.navigationAnimationType = navigationAnimationType
        pushViewController(viewController, animated: true)
    }
}
