//
//  User.swift
//  Hipostion_Swfit_v1.0
//
//  Created by Luís Antônio de Oliveira Santos on 04/08/2018.
//  Copyright © 2018 Luís Antônio de Oliveira Santos. All rights reserved.
//

import Foundation

class User{
    
    
    var id: Int
    var uuid: String
    var name: String
    var eMail: String
    var password: String
    var phone: String
    var connections: Int
    var status: Int
    
    
    
    init(id: Int, uuid: String, name: String, eMail: String, password: String, phone: String, connections: Int, status: Int) {
        self.id = id
        self.uuid = uuid
        self.name = name
        self.eMail = eMail
        self.password = password
        self.phone = phone
        self.connections = connections
        self.status = status
    }
    
}
