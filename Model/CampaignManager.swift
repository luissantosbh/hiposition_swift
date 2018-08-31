//
//  CampaignManager.swift
//  hiposition_swift
//
//  Created by Luís Antônio de Oliveira Santos on 30/08/2018.
//  Copyright © 2018 Hiposition. All rights reserved.
//

import Foundation
import CoreData

class CampaignManager {
    
    static let shared : CampaignManager = CampaignManager()
    
    var campaigns : [Campaign]!
    var campaign : Campaign!
    init() {
        
    }
    
    func loadCampaign(with context: NSManagedObjectContext) -> [Campaign]{
        let fetchRequest : NSFetchRequest<Campaign> = Campaign.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            try self.campaigns = context.fetch(fetchRequest)
        }
        catch{
            print ("Erro ao recuperar os Beacons!")
        }
        return self.campaigns
    }
    
    func saveCampaign(_beacon: BeaconJson, with context: NSManagedObjectContext) -> Void{
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
