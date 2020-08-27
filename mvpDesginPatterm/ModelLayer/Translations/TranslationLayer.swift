//
//  TranslationLayer.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 23/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation
import CoreData
import Swifter
import Alamofire
import Outlaw

protocol TranslationLayer {
    
    func toUnsavedCoreData(from dtos: [SpyDTO], with context: NSManagedObjectContext) -> [Spy]
    
    func createSpyDTOsFromJsonData(_ data: Data) -> [SpyDTO]
    
    func toSpyDTOs(from spies: [Spy]) -> [SpyDTO]
    
}
class TranslationLayerImp: TranslationLayer {
    
    fileprivate var spyTranslator : SpyTranslator
    
    init(spyTranslator:SpyTranslator) {
        self.spyTranslator = spyTranslator
    }
    
}

extension TranslationLayerImp{
    
    
    
    func toUnsavedCoreData(from dtos: [SpyDTO], with context: NSManagedObjectContext) -> [Spy]{

        print("converting DTOs to Core Data Objects")

        let spies = dtos.flatMap {  dto in
            
            spyTranslator.translate(from: dto, with: context)

        }
        
        return spies

    }
    
    func createSpyDTOsFromJsonData(_ data: Data) -> [SpyDTO]{
        
        print("converting json to DTOs")
        
        let json : [String:Any] = try! JSON.value(from: data)
        let spies : [SpyDTO] = try! json.value(for: "spies")
        
        return spies
        
    }
    

    func toSpyDTOs(from spies: [Spy]) -> [SpyDTO]{
        
        let dtos = spies.flatMap { spyTranslator.translate(from: $0)
        }
        
        return dtos
    }

    
    
    
}
