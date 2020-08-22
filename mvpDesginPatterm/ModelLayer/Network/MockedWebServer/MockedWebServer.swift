//
//  MockedWebServer.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 17/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation
import Swifter
import Alamofire

class MockedWebServer{
    
    static let sharedInstance = MockedWebServer()
    
    let server : HttpServer
    let json: AnyObject
    
    fileprivate init(){
        let url = Bundle.main.url(forResource: "spies", withExtension: ".json")!
        let data = try! Data(contentsOf: url)
        
        json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
        
        server = HttpServer()
        
        server["/spies"] = { request in
            
            Thread.sleep(forTimeInterval: 4)
            
            print("self.json \(self.json)")
            return .ok(.json(self.json))
            
        }

        
    }
    
    func start(){
        
        try! server.start()
    }
}
