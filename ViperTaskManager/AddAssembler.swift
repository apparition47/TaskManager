
//  AddAssembler.swift
//  ViperTaskManager
//
//  Created by Aaron Lee on 19/02/16.
//  Copyright © 2016 One Fat Giraffe. All rights reserved.
//
//  Generated by Swift-Viper templates. Find latest version at https://github.com/Nikita2k/SwiftViper
//

import UIKit
import Swinject

class AddAssembler: Assembler {
    
    init(parentAssembler: Assembler) {
        try! super.init(assemblies: [AddContainer()], parentAssembler: parentAssembler)
    }
}

extension AddAssembler {
    
    func presentAddViewController(fromViewController fromViewController: UIViewController, project: Project?) {
        let viewController = storyboard().instantiateViewControllerWithIdentifier("AddTableViewControllerID") as! AddTableViewController
        viewController.project = project
        
        viewController.presenter.delegate = fromViewController as? AddViewControllerDelegate
    
        let idiom = UIDevice.currentDevice().userInterfaceIdiom
        switch idiom {
        case .Phone:
            let navigationController = UINavigationController(rootViewController: viewController)
            fromViewController.presentViewController(navigationController, animated: true, completion: nil)
            
        case .Pad:
            // TODO split screen
            fromViewController.navigationController!.pushViewController(viewController, animated: true)
        
        default:
            fatalError("Device is not supported yet")
        }
    }
    
    func storyboard() -> SwinjectStoryboard {
        return SwinjectStoryboard.create(name: "List", bundle: NSBundle.mainBundle(), container: resolver)
    }
}
