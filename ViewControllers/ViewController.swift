//
//  ViewController.swift
//  hiposition_swift
//
//  Created by Luís Antônio de Oliveira Santos on 20/08/2018.
//  Copyright © 2018 Hiposition. All rights reserved.
//



import UIKit
import CoreLocation
import Alamofire
import CoreData



class ViewController:  UIViewController, CLLocationManagerDelegate  {
    
    @IBOutlet weak var TxName: UITextField!
    @IBOutlet weak var TxEmail: UITextField!
    @IBOutlet weak var TxPhone: UITextField!
    @IBOutlet weak var txPassword: UITextField!
    
    let locationManager = CLLocationManager()
    var defaultBeacon = Beacon()
    
    
    @objc func loadDefaultBeacon()
    {
        if(!BeaconManager.shared.verifyIfBeaconExist(with: self.context))
        {
                HipositionApi.loadDefaultBeacon{
                    (responseBeacon) in
                    BeaconManager.shared.saveBeacon(_beacon: responseBeacon!, with: self.context)
                }
        }
        defaultBeacon = BeaconManager.shared.loadBeacon(with: self.context)
    }
    
    @objc func loadDefaultUser()
    {
        if(!BeaconManager.shared.verifyIfBeaconExist(with: self.context))
        {
            HipositionApi.loadDefaultBeacon{
                (responseBeacon) in
                BeaconManager.shared.saveBeacon(_beacon: responseBeacon!, with: self.context)
            }
        }
        defaultBeacon = BeaconManager.shared.loadBeacon(with: self.context)
    }
    

    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        loadDefaultBeacon()
        let region = CLBeaconRegion(proximityUUID: UUID(uuidString: self.defaultBeacon.uuid!)!, identifier: self.defaultBeacon.title!)
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeacons(in: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons)
    }
    
    
    
    // Método para fazer o cadastro
    @IBAction func prepareUser(_ sender: Any) {
        if let name = self.TxName.text {
            if let email = self.TxEmail.text {
                if let phone = self.TxPhone.text {
                    if let password = self.txPassword.text {
                        
                        let user = User.init(id: 0, uuid: "0", name: name, eMail: email, password: password, phone: phone, connections: 0, status: 1)
                        
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIViewController {
    var context : NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

