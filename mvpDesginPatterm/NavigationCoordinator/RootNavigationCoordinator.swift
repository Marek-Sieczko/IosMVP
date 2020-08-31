//
//  RootNavigationCoordinator.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 24/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationCoordinator:class {
    func next(arguments: Dictionary<String,Any>?)
    
    func movingBack()
}

enum navigationState{
    case atSpyList,
         atSpyListDetails,
         atSecretDetails,
         inSignupProcess
    
}
class RootNavigationCoordinatorImpl: NavigationCoordinator{

    
    
    var registry:DependencyRegistry
    var rootViewController:UIViewController
    
    var navState: navigationState = .atSpyList
    
    init(registry: DependencyRegistry, rootViewController: UIViewController) {
        self.registry = registry
        self.rootViewController = rootViewController
        
    }
    
    
       func next(arguments: Dictionary<String, Any>?) {
           
           switch navState {
           case .atSpyList:
               showDetails(argument:arguments)
           case .atSpyListDetails:
            showSecretDetails(argument: arguments)
           case .atSecretDetails:
               showSpyList()
           case .inSignupProcess:
               break
    
           }
           
       }

    
  
    func movingBack() {
        switch navState {
        case .atSpyList: // not possible to move back stay at the current state
            break
        case .atSpyListDetails:
            navState = .atSpyList
        case .atSecretDetails:
            navState = .atSpyListDetails
        case .inSignupProcess: // example do nothing
            break
        }
    }
        
   func showDetails(argument: Dictionary<String,Any>?){
            
            
            guard let spy = argument?["spy"] as? SpyDTO else{ notifyNilArgument(); return}
            
            let detailsViewController = registry.makeDetailViewController(with: spy)
            rootViewController.navigationController?.pushViewController(detailsViewController, animated: true)
            navState = .atSpyListDetails
            
           // let detailsViewController =
            
            
        }
        
    func showSecretDetails(argument: Dictionary<String,Any>?){
            
            guard let spy = argument?["spy"] as? SpyDTO else { notifyNilArgument(); return}
            
            let secretViewController = registry.makeSecretDetailsViewController(with: spy)
            rootViewController.navigationController?.pushViewController(secretViewController, animated: true)
            
            navState = .atSecretDetails
            
        }
        
    func showSpyList(){
            rootViewController.navigationController?.popToRootViewController(animated: true)
            navState = .atSpyList
            
        }
    func notifyNilArgument(){
            print("notify user of error")
            
        }
    }


