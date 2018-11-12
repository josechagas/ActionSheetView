//
//  MKLocalSearchHelper.swift
//  ActionSheetView_Example
//
//  Created by José Lucas Souza das Chagas on 11/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import MapKit

class MKLocalSearchHelper{
    
    class func newSearchFor(Text text:String,completion:@escaping(_ success:Bool,_ items:[MKMapItem]?)->Void){
        let localSearchRequest = MKLocalSearch.Request()
        localSearchRequest.naturalLanguageQuery = text
        let localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (mkResponse, error) in
            
            guard let _ = error else{
                completion(true,mkResponse?.mapItems)
                return
            }
            completion(false,nil)
            
        }
        
    }
    
}
