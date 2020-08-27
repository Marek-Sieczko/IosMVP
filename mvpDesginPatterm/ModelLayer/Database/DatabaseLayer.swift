//
//  DatabaseLayer.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 23/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation
import CoreData
import UIKit
typealias spiesBlock = ([Spy]) ->Void

protocol DatabaseLayer {
    
    func save(dtos: [SpyDTO], translationLayer:TranslationLayer, finished: @escaping ()->Void)
    
    func loadFromDB(finished: spiesBlock)
    
   
    
}

class DatabaseLayerImp:DatabaseLayer {
    
    
     // var translateLayer = TranslationLayer()
    
     fileprivate func loadSpiesFromDB()->[Spy]{
        
        let sortOn = NSSortDescriptor(key: "name", ascending: true)
        
        let fetchRequest : NSFetchRequest<Spy> = Spy.fetchRequest()
        
        fetchRequest.sortDescriptors = [sortOn]
        
        let spies = try! persistentContainer.viewContext.fetch(fetchRequest)
        return spies


    }
    
    //MARK: - Helper Methods
    
    fileprivate func clearOldResults(){
        
        print("clearing old results")
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = Spy.fetchRequest()
        
        let deleteRequest =  NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try! persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: persistentContainer.viewContext)
        
        persistentContainer.viewContext.reset()
    }
    
       var appDelegate: AppDelegate {
           
           return UIApplication.shared.delegate as! AppDelegate
           
       }
       
       var persistentContainer: NSPersistentContainer{
            
           return appDelegate.persistentContainer
       }
       
       var mainContext : NSManagedObjectContext{
           
           return appDelegate.persistentContainer.viewContext
       }
       
    func save(dtos: [SpyDTO], translationLayer:TranslationLayer, finished: @escaping ()->Void){
           
           clearOldResults()
        _ = translationLayer.toUnsavedCoreData(from: dtos, with: mainContext)
           
           try! mainContext.save()
           
           finished()
           
           
           
           
       }
       
       func loadFromDB(finished: spiesBlock){
           
           print("loading data locally")
           
           let spies = loadSpiesFromDB()
           
           finished(spies)
           
       }
       
       
       

       
}
