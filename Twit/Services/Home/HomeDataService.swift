//
//  HomeDataService.swift
//  Twit
//
//  Created by Corey Baines on 5/09/2016.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import Alamofire

extension DataService {
    
    
    func downloadFromTwit(url:String, download:Bool, complete:DownloadComplete, error:DownloadError) {
        
        var coreUrl = "https://twit.tv/api/v1.0/\(url)"
        
        
    
        Alamofire.request(.GET, coreUrl, headers: twitHeaders).responseJSON { response in
          //  print(response.request)  // original URL request
          //  print(response.response) // URL response
           // print(response.data)     // server data
          //  print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
              //  print("JSON: \(JSON)")
            }
            
            let dict = response.result.value!["shows"] as? NSArray
            
            for shows in dict! {
               // print(shows)
                print(shows["label"])
            }
           // for descArry = JSON["descriptions"] as? [Dictionary<String, String>] {
                
            //}
           // print(response.response)
            //print(response.response?.allHeaderFields["age"])
            //print(response.response?.allHeaderFields["Last-Modified"])
        }
    }
    
    
}