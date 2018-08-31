//
//  CampanhaTableViewController.swift
//  Hipostion_Swfit_v1.0
//
//  Created by Luís Antônio de Oliveira Santos on 14/08/2018.
//  Copyright © 2018 Luís Antônio de Oliveira Santos. All rights reserved.
//

import UIKit
import CoreData

class CampanhaTableViewController: UITableViewController {
    
   // var campanhas =
    var campaignOb: NSManagedObject!
    var addCampanhas: [Campaign] = [] // variável que irá incrementar novos campanhas
    var gerenciadorObjetos: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        //inicializa gerenciador de objetos
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        gerenciadorObjetos = appDelagate.persistentContainer.viewContext
        saveCampaign()
        loadItems()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addCampanhas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let campanha: Campaign = addCampanhas[indexPath.row]
        let celulaReuso = "celulaReuso"
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath) as! CampanhaCelula
        celula.nome.text = campanha.name
        return celula
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Campaign")
         request.returnsObjectsAsFaults = false
        do {
            let result = try  context.fetch(request)
            if(result.count > 0) {
                for item in result as! [NSManagedObject] {
                    print(item.value(forKey: "name") as! String)
                }
            }
        }
    
         catch{
            print ("Erro ao recuperar as campanhas!")
        }
    }
    
    
    
    func loadItems() {
        
        //configurações iniciais para utilizar o Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // gerenciador de objetos do contexto
        let context = appDelegate.persistentContainer.viewContext
        // Recuperar os produtos incluídos
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Campaign")
        
        //Ordenação crescente
        let ordenacaoAZ = NSSortDescriptor(key: "name", ascending: true)

        
        //aplica os filtros a requisicao
        requisicao.sortDescriptors = [ordenacaoAZ]
        
        // requisicao.predicate = predicate
        
        do {
            let campanhas = try context.fetch(requisicao)
            if campanhas.count > 0 {
                for campanha in campanhas  as! [Campaign]{
                     addCampanhas.append ( campanha )
                }
            }else {
                print ("Nenhuma campanha encontrada!")
            }
            print ("Sucesso ao recuperar as campanhas!")
        }catch{
            print ("Erro ao recuperar as campanhas!")
        }
    }

 
    
    func saveCampaign(){
        
        let newCampaign = NSEntityDescription.insertNewObject(forEntityName: "Campaign", into: gerenciadorObjetos )
        //configura campanha
        newCampaign.setValue( "CampanhaMichael" , forKey: "name")
        do{
            try gerenciadorObjetos.save()
        }catch let erro as NSError {
            print("Erro ao adicionar campanha: erro \(erro.description) ")
        }
    }
}

    
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


