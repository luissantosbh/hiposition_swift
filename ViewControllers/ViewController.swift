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
    //var defaultBeacon = Beacon()
    
    
    /*@objc func loadDefaultBeacon()
    {
        if(!BeaconManager.shared.verifyIfBeaconExist(with: self.context))
        {
            HipositionApi.loadDefaultBeacon{
                (responseBeacon) in
                BeaconManager.shared.saveBeacon(_beacon: responseBeacon!, with: self.context)
            }
        }
        defaultBeacon = BeaconManager.shared.loadBeacon(with: self.context)
    } */
    
    @objc func loadDefaultUser()
    {
        if(!BeaconManager.shared.verifyIfBeaconExist(with: self.context))
        {
            HipositionApi.loadDefaultBeacon{
                (responseBeacon) in
                BeaconManager.shared.saveBeacon(_beacon: responseBeacon!, with: self.context)
            }
        }
    }
    
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //loadDefaultBeacon()
        let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!, identifier: "AirLocate")
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
                        let _user = UserJson(name: name, email: email, password: password, facebookID: "123", birthDate: "01/01/0001", lastEntry: "", picture: "", token: "", phone: "", connections: 0, status: 1, id: 0, uuid: "1", registerDate: String(Date().timeIntervalSinceNow))
                        //.shared.saveUser(_user: userReturn, with: self.context)
                        HipositionApi.postUser(user: _user, onCompletion: {(userResp: UserJson?) -> Void in
                            UserManager.shared.saveUser(_user: userResp!, with: self.context)
                        })
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

