//
//  spyDTO.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 16/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation
import Outlaw


private var numImagesPerGender = 6

struct SpyDTO{
    
    var age:Int
    var name: String
    var gender: Gender
    var password: String
    var imageName: String = ""
    var isIncognito:Bool
    
    
}

extension SpyDTO: Deserializable{
    
    init(object:Outlaw.Extractable) throws{
     
        let genderString :String = try object.value(for: "gender")
        
        gender = Gender(rawValue: genderString) ?? .female
        
        name = try object.value(for: "name")
        age = try object.value(for: "age")
        password = try object.value(for: "password")
        isIncognito =  try object.value(for: "isIncognito")
        imageName =  try object.value(for: "imageName")
        
    
    }
    
    var randomImage: String{
        let imageIndex =  Int(arc4random_uniform(UInt32(numImagesPerGender))) + 1
        let imageGender = gender == .female ? "F" : "M"
        
        print("=======================",String(format: "Spy%@%02d", imageGender,imageIndex))
        
        return String(format: "Spy%@%02d", imageGender,imageIndex)
    }
}

extension SpyDTO: Serializable{
    
    func serialized() -> [String:Any] {
        
        return ["name": name,
                "age": age,
                "gender": gender,
                "password": password,
                "isIncogito": isIncognito,
                "imageName": imageName]
            
                
        
        
    }
}
