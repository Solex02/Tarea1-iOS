//
//  PnatallaFinalController.swift
//  trabajo1ios
//
//  Created by user202258 on 10/10/2023.
//

import UIKit

var ids : [String] = []

var mejorespuntuacionesnombre = ["Joselito", "Oscar"]
var mejorespuntuaciones = [7, 6]

class PantallaFinalController: UIViewController {
            
    
   
    
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet weak var puntuacionfinal: UILabel!
    
    
    @IBAction func guardarButton(_ sender: Any) {
        guardar()
    }
    
    @IBAction func volveraJugarButton(_ sender: Any) {
        volverajugar()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        puntuacionfinal.text = String(puntuacion)
    
        cargarPuntuacion() // Cargar puntuaciones
        
        tableView.delegate = self //Tabla de puntuaciones
        tableView.dataSource = self
        
    }
    
    
    func volverajugar(){
        performSegue(withIdentifier: "volverjugar", sender: nil)
        
    }
    func guardar(){
        performSegue(withIdentifier: "guardar", sender: nil)
        
    }
    
  

    func cargarPuntuacion(){
        
        
        
        ids = (UserDefaults.standard.array(forKey: "ids") as? [String])!
        mejorespuntuacionesnombre = (UserDefaults.standard.array(forKey: "names") as? [String])!
        mejorespuntuaciones = (UserDefaults.standard.array(forKey: "points") as? [Int])!
        
        print(mejorespuntuacionesnombre)
        print(mejorespuntuaciones)
    }
    

}


extension PantallaFinalController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
    }
    
}

extension PantallaFinalController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mejorespuntuacionesnombre.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = mejorespuntuacionesnombre[indexPath.row] + " puntuacion: " + String(mejorespuntuaciones[indexPath.row])
        return cell
    }
    
    
    
}
