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

class ViewController: UIViewController, CLLocationManagerDelegate  {
    
    @IBOutlet weak var TxName: UITextField!
    @IBOutlet weak var TxEmail: UITextField!
    @IBOutlet weak var TxPhone: UITextField!
    @IBOutlet weak var txPassword: UITextField!
    
    
    // var addCampanhas: [Campanha] = []// Variável para incrementar novas campanhas
    
    
    
    
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
    
    
    /*
     
     override func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return addCampanhas.count
     }
     
     
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     
     let campanha: Campanha = addCampanhas[indexPath.row]
     let celulaReuso = "celulaReuso"
     
     let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath) as! CampanhaCelula
     
     
     celula.nome.text = campanha.nome
     celula.descricao.text = campanha.descricao
     
     
     return celula
     
     
     
     }
     
     
     */
    
    
    // Método para fazer o cadastro
    @IBAction func prepareUser(_ sender: Any) {
        
        if let name = self.TxName.text {
            if let email = self.TxEmail.text {
                if let phone = self.TxPhone.text {
                    if let password = self.txPassword.text {
                        
                        let user = User.init(id: 0, uuid: "0", name: name, eMail: email, password: password, phone: phone, connections: 0, status: 1)
                        
                        createUserEventData(user: user)
                    }
                    
                }
                
            }
            
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    private  func createUserEventData(user: User) {
        
        let newUser: [String: Any] =
            ["name": user.name,
             "email": user.eMail,
             "password": user.password,
             "phone": user.phone,
             "connections": user.connections,
             "status": user.status
        ]
        
        let endpoint: String = "http://bitwinteligence-001-site1.htempurl.com/api/v1/User"
        
        
        Alamofire.request(endpoint, method: .post, parameters: newUser,
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print(response.result.error ?? "")
                    return
                }
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    return
                }
                // get and print the title
                guard let todoTitle = json["name"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
        }
    }
    
    
    
    
}

