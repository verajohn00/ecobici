//
//  Station.swift
//  ecobici
//
//  Created by John A. Cristobal on 2/20/19.
//  Copyright © 2019 example. All rights reserved.
//

import Foundation

struct Station {
    var id: Int?
    var name: String?
    var address: String?
    var bicis: Int?
    var lon: Double?
    var lat: Double?
    var closeStations: Int?
    
    init(id: Int, name:String, address:String,bicis:Int,lon:Double,lat:Double,closeStations:Int) {
        self.id = id
        self.name = name
        self.address = address
        self.bicis = bicis
        self.lon = lon
        self.lat = lat
        self.closeStations = closeStations
    }
}
