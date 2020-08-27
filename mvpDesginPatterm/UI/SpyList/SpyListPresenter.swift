//
//  SpyListPresenter.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 22/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation
import CoreData
import Alamofire
import Outlaw

typealias BlockWithSource = (Source) -> Void
typealias VoidBlock = () -> Void


protocol SpyListPresenter {
    var data : [SpyDTO] { get }
    func loadData(finished: @escaping BlockWithSource)
    //var modelLayer : ModelLayer { get}
}
class SpyListPresenterImp: SpyListPresenter {
    
      var data = [SpyDTO]()
    var modelLayer : ModelLayer
    
    init(modelLayer:ModelLayer) {
        self.modelLayer = modelLayer
    }
    
    func loadData(finished: @escaping BlockWithSource){
              
           modelLayer.loadData { [weak self] source, spies in
                  
                  self?.data =  spies
                  
                  finished(source)
              }
       
              
          }
    
}


//MARK: - private Data Methods



//MARK: - Model Methods



//MARK: - Network Methods





//MARK: - Spy Translation Methods


