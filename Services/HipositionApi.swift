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
            }
        }
    }
    
    public class func postUser(user: UserJson, onCompletion: @escaping(UserJson?) -> Void)
    {
        let newUser: [String: Any] =
            ["name": user.name ,
             "email": user.email ,
             "password": user.password,
             "phone": user.phone ,
             "connections": user.connections,
             "status": user.status
        ]
        let url = HipositionApi.baseURL + "User"
        Alamofire.request(url, method: .post, parameters: newUser, encoding: JSONEncoding.default)
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
    
    public class func loadCampaignByUUID(beaconUUID: String, onCompletion: @escaping([CampaignJson]?) -> Void) {
        let url = HipositionApi.baseURL + "Campaign/"+beaconUUID+"/beacon";
        Alamofire.request(url).responseJSON { (dataResponse) in
            if let data = dataResponse.data {
                do {
                    let response = try JSONDecoder().decode([CampaignJson].self, from: data)
                    onCompletion(response)
                } catch {
                    print(error)
                    onCompletion(nil)
                }
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
    let connections : Int64
    let status : Int64
    let id : Int64
    let uuid : String
    let registerDate : String
}

struct CampaignJson {
    let name : String
    let title : String
    let url : String
    let littleDescription : String
    let description : String
    let ChatBot : ChatBotJson
    let pictures : [PictureJson]
    let actions : [ActionsJson]
}

struct ChatBotJson {
    let id : Int64
    let uuid : String
}

struct PictureJson {
    let name : String
    let location : String
    let url : String
}

struct ActionsJson {
    let type : String
    let name : String
    let link : String
}















