//
//  HipositionApi.swift
//  hiposition_swift
//
//  Created by Luís Antônio de Oliveira Santos on 21/08/2018.
//  Copyright © 2018 Hiposition. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class  HipositionApi{
    
    static let baseURL = "http://bitwinteligence-001-site1.htempurl.com/api/v1/"
    var arrRes = [BeaconJson]() //Array of dictionary
    var beaconJson : BeaconJson!
    
    
    public class func loadDefaultBeacon(onCompletion: @escaping(BeaconJson?) -> Void) {
        let url = HipositionApi.baseURL + "Beacon/1"
        Alamofire.request(url).responseJSON { (dataResponse) in
            if let data = dataResponse.data {
                do {
                    let response = try JSONDecoder().decode(BeaconJson.self, from: data)
                    onCompletion(response)
                } catch {
                    print(error)
                    onCompletion(nil)
                }
                return
            }
        }
    }
    
    public class func createUserEventData(user: User, onCompletion: @escaping(UserJson?) -> Void){
        let newUser: [String: Any] =
            ["name": user.name,
             "email": user.eMail,
             "password": user.password,
             "phone": user.phone,
             "connections": user.connections,
             "status": user.status
            ]
        let url = HipositionApi.baseURL + "User"
        Alamofire.request(url, method: .post, parameters: newUser,
                          encoding: JSONEncoding.default)
        .responseJSON { (dataResponse) in
            if let data = dataResponse.data {
                do {
                    let response = try JSONDecoder().decode(UserJson.self, from: data)
                    onCompletion(response)
                } catch {
                    print(error)
                    onCompletion(nil)
                }
                return
            }
        }
    }
}





struct BeaconJson : Codable {
    
    let campainID : Int64
    let clientID : Int64
    let major : String
    let minor : String
    let title : String
    let description : String
    let picture : String
    let id : Int64
    let uuid : String
    let registerDate : String
    
}

struct UserJson: Codable{
    let name : String
    let email : String
    let password : String
    let facebookID : String
    let birthDate : String
    let lastEntry : String
    let picture : String
    let token : String
    let phone : String
    let connections : String
    let status : Int
    let id : Int64
    let uuid : String
    let registerDate : String
}














