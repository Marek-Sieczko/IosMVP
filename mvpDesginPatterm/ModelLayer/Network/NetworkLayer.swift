//
//  NetworkLayer.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 23/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkLayer {
   func LoadFromServer(finished: @escaping (Data) -> Void)
}
class NetworkLayerImp: NetworkLayer {
    
}

extension NetworkLayerImp{
    
    func LoadFromServer(finished: @escaping (Data) -> Void)  {
        print("Loading data from server")
        AF.request("http://localhost:8080/spies").responseJSON { response in
            
            print("almofire response \(response)")
            guard let data = response.data else{
                 return
            }
            finished(data)
        }
    }
    
}
