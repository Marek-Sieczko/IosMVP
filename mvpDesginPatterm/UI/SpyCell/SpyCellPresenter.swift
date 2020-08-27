//
//  SpyCellPresenter.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 23/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation

protocol SpyCellPresenter {
    
    var age: Int{ get }
    var name: String { get }
    var imageName: String{ get }
    
}
class SpyCellPresenterImp: SpyCellPresenter{
    
    
    var spy:SpyDTO
    
    var age: Int{ return Int(spy.age)}
    var name: String {return spy.name}
    var imageName: String{ return spy.imageName}
    
    init(spy: SpyDTO) {
        self.spy = spy
    }
     
    
    
    
}
