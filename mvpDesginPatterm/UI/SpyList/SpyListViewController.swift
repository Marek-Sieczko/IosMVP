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
    
//    fileprivate func loadSpiesFromDB()->[Spy]{
//
//
//    }
    
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

