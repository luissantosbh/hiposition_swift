//
//  BeaconManager.swift
//  hiposition_swift
//
//  Created by Luís Antônio de Oliveira Santos on 22/08/2018.
//  Copyright © 2018 Hiposition. All rights reserved.
//

import Foundation
import CoreData



class UserManager {
    
    static let shared : UserManager = UserManager()
    
    var user : User!
    init() {
        
    }
    
    func loadUser(with context: NSManagedObjectContext) -> User{
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            try self.user = context.fetch(fetchRequest).first
        }
        catch{
            print ("Erro ao recuperar o usuário!")
        }
        return self.user
    }
    
    
    
    func saveUser(_user: UserJson, with context: NSManagedObjectContext) -> Void{
        let user = User()
        user.connections = _user.connections
        user.email = _user.email
        user.id = _user.id
        user.name = _user.name
        user.password = _user.password
        user.status = _user.status
        user.token = _user.token
        
        do{
            try context.save()
        } catch{
            print(error)
        }
        print("User salvo com sucesso!")
    }
}
