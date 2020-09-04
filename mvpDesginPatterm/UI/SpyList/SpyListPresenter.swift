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
import RxSwift
import RxDataSources

struct SpySection{
    var header: String
    var items: [Item]
    
}
extension SpySection: SectionModelType{
    
    typealias Item = SpyDTO
    init(original: SpySection, items: [SpyDTO]) {
        self = original
        self.items = items
    }
}
typealias BlockWithSource = (Source) -> Void
typealias VoidBlock = () -> Void


protocol SpyListPresenter {
    
    var section : Variable<[SpySection]> {get}
   // var data : [SpyDTO] { get }
    func loadData(finished: @escaping BlockWithSource)
    func makeSomeChanges()
    //var modelLayer : ModelLayer { get}
}
class SpyListPresenterImp: SpyListPresenter {

    
    var section: Variable<[SpySection]> =  Variable<[SpySection]>([])
    
    
     // var data = [SpyDTO]()
    var modelLayer : ModelLayer
    fileprivate var bag = DisposeBag()
    fileprivate var spies = Variable<[SpyDTO]>([])
    
    init(modelLayer:ModelLayer) {
        self.modelLayer = modelLayer
        setupObservers()
    }
    
    func loadData(finished: @escaping BlockWithSource){
              
           modelLayer.loadData { [weak self] source, spies in
                  
            self?.spies.value =  spies
                  
                  finished(source)
              }
       
              
          }
    
    func makeSomeChanges() {
        
        let newSpy = SpyDTO(age: 23, name: "Adam Smith", gender: Gender.male, password: "asdjqwebbqwe12", imageName: "AdamSmith", isIncognito: true)
        spies.value.insert(newSpy, at: 0)
        
    }
    
}
extension SpyListPresenterImp{
    
    func setupObservers(){
        spies.asObservable().subscribe(onNext: { [weak self] newSpies in
            
            self?.updateNewSections(with: newSpies)
            
            }).disposed(by: bag)
    }
    
    func updateNewSections(with spies: [SpyDTO]){
        
        func mainWork(){
            section.value = filter(with: spies)
            
        }
        
        func filter(with spies: [SpyDTO])-> [SpySection]{
            
            let isIncognito = spies.filter { $0.isIncognito}
            let everyDaySpy = spies.filter { !$0.isIncognito }
            
            
            return [SpySection(header: "normal", items: isIncognito),
                    SpySection(header: "special", items: everyDaySpy)]
            
            }
        
         mainWork()
            
        }
        
       
        
    }
        
    



//MARK: - private Data Methods



//MARK: - Model Methods



//MARK: - Network Methods





//MARK: - Spy Translation Methods


