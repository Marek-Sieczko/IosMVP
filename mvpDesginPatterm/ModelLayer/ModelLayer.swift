//
//  ModelLayer.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 23/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation
import Swifter
import CoreData
import Outlaw

typealias spiesAndSourceBlock = (Source,[SpyDTO])->Void


protocol ModelLayer {
    func loadData(resultsLoaded: @escaping spiesAndSourceBlock)
    
    //func loadFromDB(from source: Source)
}
class ModelLayerImp: ModelLayer{
    
    fileprivate var networkLayer : NetworkLayer!
    fileprivate var dataBaseLayer : DatabaseLayer!
    fileprivate var translationLayer : TranslationLayer!
    
    init(networkLayer:NetworkLayer, dataBaseLayer:DatabaseLayer, translationLayer:TranslationLayer) {
        self.dataBaseLayer = dataBaseLayer
        self.translationLayer = translationLayer
        self.networkLayer = networkLayer
    }
    
    
    
    
    
    func loadData(resultsLoaded: @escaping spiesAndSourceBlock){
        
        func mainWork(){
            
          
            
            //loadFromDB
            
            loadFromDB(from: .local)
            
            //loadFromServer
            
            networkLayer.LoadFromServer { data in
                let dtos = self.translationLayer.createSpyDTOsFromJsonData(data)
                self.dataBaseLayer.save(dtos: dtos, translationLayer: self.translationLayer) {
                    
                    loadFromDB(from: .network)
                }
            }
            
        }
        
        func loadFromDB(from source: Source){
            
            dataBaseLayer.loadFromDB { spies in
               let dtos = self.translationLayer.toSpyDTOs(from: spies)
                resultsLoaded(source,dtos)
            }
            
            
        }
        
        mainWork()

        
        
    }
    
}
extension ModelLayer {
     

    
}
