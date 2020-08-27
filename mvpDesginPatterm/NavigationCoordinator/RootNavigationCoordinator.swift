//
//  RootNavigationCoordinator.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 24/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation
import UIKit

//protocol NavigationCoordinator:class {
//    func next(arguments: Dictionary<String,Any>?)
//    
//    func movingBack()
//}
//
//
//class RootNavigationCoordinatorImpl: NavigationCoordinator{
//    
//    var registry:DependencyRegistry
//    var rootViewController:UIViewController
//    
//    var navState: navigationState = .atSpyList
//    
//    init(registry: DependencyRegistry, rootViewController: UIViewController) {
//        self.registry = registry
//        self.rootViewController = rootViewController
//    }
//    
//    
//    func next(arguments: Dictionary<String, Any>?) {
//        
//    }
//    
//    func movingBack() {
//        switch navState {
//        case .atSpyList: // not possible to move back stay at the current state
//            break
//        case .atSpyListDetails:
//            navState = .atSpyList
//        case .atSecretDetails:
//            navState = .atSpyListDetails
//        case .inSignUpProcess: // example do nothing
//            break
//        }
//        
//        func showDetails(argument: Dictionary<String,Any>?){
//            
//            
//            guard let spy = argument?["spy"] as? SpyDTO else{ notifyNilArgument(); return}
//            
//           // let detailsViewController =
//            
//            
//        }
//        
//        func showSecretDetails(){
//            
//            
//        }
//        
//        func showSpyList(){
//            
//            
//        }
//        func notifyNilArgument(){
//            print("notify user of error")
//            
//        }
//    }
//    
//    
//    
//}
