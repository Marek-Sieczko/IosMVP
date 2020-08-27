//
//  DetailsPresenter.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 22/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation
protocol DetailsPresenter {
    
    var spy:SpyDTO! { get }
    var imagename: String{ get}
    var name: String { get }
    var age: String { get }
    var gender: String { get}
    
    
}
class DetailsPresenterImp: DetailsPresenter{
    
    var spy:SpyDTO!
    
    var imagename: String{ return spy.imageName}
    var name: String { return spy.name }
    var age: String { return "\(spy.age)"  }
    var gender: String { return spy.gender.rawValue}
    
    
    init(with spy: SpyDTO) {
        
        self.spy = spy
    }
    
    
}
