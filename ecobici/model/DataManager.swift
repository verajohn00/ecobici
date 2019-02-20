//
//  DataManager.swift
//  ecobici
//
//  Created by John A. Cristobal on 2/20/19.
//  Copyright © 2019 example. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataManager{
    
    static let shared = DataManager()
    var token = ""
    
    func getToken(completion: @escaping (String) -> Void){
        let url = "https://pubsbapi.smartbike.com/oauth/v2/token?client_id=1641_46hamktnoc4kwgos44w0g08cgss0wskoggo0gkc88wo4c0ksos&client_secret=1ysm825wdq00k00sokw4cgc84ggosos80ss40g04gwo0s04s0o&grant_type=client_credentials"
        
        request(url,method: .get, parameters: nil, headers:nil).responseJSON(){
            (response) in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)// as? [String:AnyObject]
                self.token = json["access_token"].description
                completion(self.token)
                
            case .failure(_):
                completion("error")
                
            }
        }
    }
    
    func getData(token: String, completion: @escaping ([Station]) -> Void ){
        let url = "https://pubsbapi.smartbike.com/api/v1/stations.json?access_token=\(token)"
        
        request(url,method: .get, parameters: nil, headers:nil).responseJSON(){
            (response) in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)// as? [String:AnyObject]
                var stationData : [Station] = []
                let data = JSON(json["stations"])
                
                for item in data{
                    let id = item.1["id"].int!
                    let name = item.1["name"].description
                    let address = item.1["address"].description
                    let lon = JSON(item.1["location"])["lon"].double!
                    let lat = JSON(item.1["location"])["lat"].double!
                    let stations = item.1["nearbyStations"][0].int!
                    
                    let station = Station(id:id, name: name, address: address, bicis: 0,lon:lon,lat:lat,closeStations:stations)
                    
                    //stationData[id] = station
                    stationData.append(station)
                }
                
                completion(stationData)
                
            case .failure(_):
                completion([])
            }
        }
    }
    
    func getBicis(stations: [Station],completion: @escaping ([Station]) -> Void ){
        let url = "https://pubsbapi.smartbike.com/api/v1/stations/status.json?access_token=\(token)"
        
        request(url,method: .get, parameters: nil, headers:nil).responseJSON(){
            (response) in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)// as? [String:AnyObject]
                let data = JSON(json["stationsStatus"])
                var stationData : [Station] = []
                
                for item in data{
                    let id = item.1["id"].int!
                    let bikes = JSON(item.1["availability"])["bikes"].int!

                    if let foo = stations.first(where: {$0.id == id}) {
                        var tempStation = foo
                        tempStation.bicis = bikes
                        stationData.append(tempStation)
                    }
                }
                
                completion(stationData)
                
            case .failure(_):
                completion([])
            }
        }
    }
}
