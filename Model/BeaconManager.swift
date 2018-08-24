//
//  BeaconManager.swift
//  hiposition_swift
//
//  Created by Luís Antônio de Oliveira Santos on 22/08/2018.
//  Copyright © 2018 Hiposition. All rights reserved.
//

import Foundation
import CoreData



class BeaconManager {
    
    static let shared : BeaconManager = BeaconManager()
    
    var beacons : [Beacon]!
    var beacon : Beacon!
    init() {
       
    }
    
    func loadBeacon(with context: NSManagedObjectContext) -> Beacon{
        let fetchRequest : NSFetchRequest<Beacon> = Beacon.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            try self.beacon = context.fetch(fetchRequest).first
        }
        catch{
            print ("Erro ao recuperar os Beacons!")
        }
        return self.beacon
    }
    
   
    func verifyIfBeaconExist(with context: NSManagedObjectContext) -> Bool{
        let fetchRequest : NSFetchRequest<Beacon> = Beacon.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            try self.beacon = context.fetch(fetchRequest).first
        }
        catch{
            print ("Erro ao recuperar os Beacons!")
        }
        return (self.beacon != nil)
    }
    
    
    
    func loadBeacons(with context: NSManagedObjectContext) -> [Beacon]{
          let fetchRequest : NSFetchRequest<Beacon> = Beacon.fetchRequest()
          fetchRequest.returnsObjectsAsFaults = false
        do {
            try self.beacons = context.fetch(fetchRequest)
        }
        catch{
            print ("Erro ao recuperar os Beacons!")
        }
        return self.beacons
    }
    
    func saveBeacon(_beacon: BeaconJson, with context: NSManagedObjectContext) -> Void{
        let beacon = Beacon()
        beacon.beaconDescription = _beacon.description
        beacon.campaignId = _beacon.campainID
        beacon.clientId = _beacon.clientID
        beacon.id = _beacon.id
        beacon.major = _beacon.major
        beacon.minor = _beacon.minor
        beacon.picture = _beacon.picture
        beacon.uuid = _beacon.uuid
        do{
            try context.save()
        } catch{
            print(error)
        }
        print("Beacon salvo com sucesso!")
    }
}
