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
    
    
    //1) Inserir os dados do beacon
    
    let locationManager = CLLocationManager()
    
    // let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!, identifier: "AirLocate")
    
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "699EBC80-E1F3-11E3-9A0F-0CF3EE3BC012")!, identifier: "HiPosition") //major:90, minor:13133,
 
    override func viewDidLoad(){
        super.viewDidLoad()
        
    
    
    // 2) Definir autorizações no "info.plist"
    // 3) Começar procurar os beacons na região
    
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
