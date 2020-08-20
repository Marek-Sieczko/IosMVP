//
//  ViewController.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 16/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import Alamofire
import Outlaw
import Toaster

typealias BlockWithSource = (Source) -> Void
typealias VoidBlock = () -> Void
typealias spiesAndSourceBlock = (Source,[Spy])->Void
typealias spiesBlock = ([Spy]) ->Void

class SpyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
 
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [Spy]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.delegate = self
        SpyCell.register(with: tableView)
        
       // loadData()
        
        
        
    }


}
//MARK: - Data Methods
extension SpyListViewController{
    
    
    var appDelegate: AppDelegate {
        
        return UIApplication.shared.delegate as! AppDelegate
        
    }
    
    var persistentContainer: NSPersistentContainer{
         
        return appDelegate.persistentContainer
    }
    
    var mainContext : NSManagedObjectContext{
        
        return appDelegate.persistentContainer.viewContext
    }
    
    func save(dtos: [SpyDTO], finished: @escaping ()->Void){
        
        clearOldResults()
        
        
    }
    
    
    
    func loadData(finished: @escaping BlockWithSource){
 
        
    }
    
    
}

//MARK: - private Data Methods

extension SpyListViewController{
    
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
}

//MARK: - Model Methods

extension SpyListViewController {
    
    func loadData(resultsLoaded: @escaping spiesAndSourceBlock){
        
        func mainWork(){
            
          
            
            //loadFromDB
            
            //loadFromServer
            
            func loadFromDB(from source: Source){
                
                
            }
        }
        
        
    }
}

extension SpyListViewController {
     
    func createSpyDTOsFromJsonData(_ data: Data) -> [SpyDTO]{
        
        print("converting json to DTOs")
        
        let json : [String:Any] = try! JSON.value(from: data)
        let spies : [SpyDTO] = try! json.value(for: "spies")
        
        return spies
        
    }
    
    func toUnsavedCoreData(from dtos: [SpyDTO], with context: NSManagedObjectContext) -> [Spy]{

        print("converting DTOs to Core Data Objects")

        let spies = dtos.flatMap {  dto in
            
            translate(from: dto, with: context)


        }
        
        return spies

    }
    
}


//MARK: - Spy Translation Methods

extension SpyListViewController{
    
    func translate(from spy: Spy?) -> SpyDTO?{
        
        guard let spy = spy else{ return nil}
        
        let gender = Gender(rawValue: spy.gender!)!
        
        return SpyDTO(age: Int(spy.age), name: spy.name!, gender: gender, password: spy.password!, imageName: spy.imageName!, isIncognito: spy.isIncognito)
        
        
    }
    
    func translate(from dto: SpyDTO?, with context: NSManagedObjectContext) -> Spy?{
    
        guard let dto = dto else { return nil}
        
        let spy = Spy(context: context)
        
        spy.age = Int64(dto.age)
        
        spy.name = dto.name
        spy.gender = dto.gender.rawValue
        spy.password = dto.password
        spy.imageName = dto.imageName
        spy.isIncognito = dto.isIncognito
        
        return spy
        
        
}
    
    
    
}

//MARK: UITableViewDataSource

extension SpyListViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell
        let spy = data[indexPath.row]
        let cell = SpyCell.dequeue(from: tableView, for: indexPath, with: spy)
        return cell
     }
}

