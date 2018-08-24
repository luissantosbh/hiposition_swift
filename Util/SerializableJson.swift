//
//  SerializableJson.swift
//  hiposition_swift
//
//  Created by Luís Antônio de Oliveira Santos on 24/08/2018.
//  Copyright © 2018 Hiposition. All rights reserved.
//

import Foundation

class SerializableJson
{
    static let shared : SerializableJson = SerializableJson()
    public  func SerializationObjectToJson(object: AnyObject)  -> String{
        do {
            let stringData = try JSONSerialization.data(withJSONObject: object, options: [])
            if let string = String(data: stringData, encoding: String.Encoding.utf8){
                return string
            }
        }catch _ {
        }
        return "{\"element\":\"jsonError\"}"
    }
}
