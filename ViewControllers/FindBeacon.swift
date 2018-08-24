//
//  FindBeacon.swift
//  hiposition_swift
//
//  Created by Luís Antônio de Oliveira Santos on 21/08/2018.
//  Copyright © 2018 Hiposition. All rights reserved.
//

import UIKit
import CoreLocation

class FindBeacon: UIViewController, CLLocationManagerDelegate {
    
    
    var beaconDefault = Beacon()
    //1) Inserir os dados do beacon
    
    /*
        { (parameters) -> returnType in
            statements to execute
    }
     
     
     
     exemplo 2
     
     let f = { (x: int) -> Int
     in
     return x + 42}
     
     
     f(9)
     f(50)
    */
    
    
    
    @objc func loadDefaultBeacon()
    {
      
        let existeBeacon =
            (BeaconManager.shared.loadBeacon(with: self.context).uuid != nil);
        
            if(!existeBeacon)
            {
                HipositionApi.loadDefaultBeacon{(b: BeaconJson?) -> Void
                    in
                
                BeaconManager.shared.saveBeacon(_beacon: b!, with: self.context)
            }
        }
    }
    
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!, identifier: "AirLocate")
    
    override func viewDidLoad(){
        super.viewDidLoad()
 
    
    locationManager.delegate = self
    if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
    locationManager.requestWhenInUseAuthorization()
    }
    locationManager.startRangingBeacons(in: region)
}

    // 4) Mostrar os beacons
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons)
    }
    
}
