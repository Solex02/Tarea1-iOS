//
//  PnatallaFinalController.swift
//  trabajo1ios
//
//  Created by user202258 on 10/10/2023.
//

import UIKit


class GuardarController: UIViewController {
    
    var apiurl = URL( string: "https://api.restful-api.dev/objects")
    
    
    
    
    
    @IBOutlet weak var puntuacionFinal: UILabel!
    @IBOutlet weak var NameEntry: UITextField!
    @IBAction func guardarButton(_ sender: Any) {
        guardar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        puntuacionFinal.text = String(puntuacion)
        print(ids)
    }
    
    

    
    func guardar(){
        
        print("Guardar Button")
        if(NameEntry.text != nil){
            print("Post lesson")
            let url = URL(string: "https://api.restful-api.dev/objects") //url de la api
            let playerObject: [String: Any] = [ //objeto de nombre de jugador mas puntuación
                "name": NameEntry.text!,
                "data": [
                    "puntuacion": puntuacion
                ]
            ]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: playerObject)

            var request = URLRequest(url: url!)
            request.httpMethod = "POST" //guardar imagen en la nube
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
            URLSession.shared.dataTask(with: request) { [self] (data, response, error) in let json = String(data: data!, encoding: .utf8)
                print(json ?? "Error")
                do {
                    let lessonDataJSON = try JSONDecoder().decode(User.self, from: data!)
                    mejorespuntuacionesnombre.append(lessonDataJSON.name)
                    mejorespuntuaciones.append(lessonDataJSON.data.puntuacion)
                    ids.append(lessonDataJSON.id)
                    self.GuardarLocal()
                    DispatchQueue.main.async { // ejecutar código en el hilo principal
                            self.navigationController?.popViewController(animated: true)                }
                        } catch {
                            mejorespuntuacionesnombre.append(NameEntry.text!)
                            mejorespuntuaciones.append(puntuacion)
                            self.GuardarLocal()
                            print("Error api")
                        }
                    }.resume()
            
            
            

        }
    }
    
    func GuardarLocal(){
        UserDefaults.standard.set(ids, forKey: "ids")
        UserDefaults.standard.set(mejorespuntuacionesnombre, forKey: "names")
        UserDefaults.standard.set(mejorespuntuaciones, forKey: "points")
        
        performSegue(withIdentifier: "guardadocorrecto", sender: nil)
        
        
    }

}


class User: Codable {
    var id: String = ""
    var name: String
    var data: UserData
    init(_ name: String, _ data: UserData) {
        self.name = name
        self.data = data
    }
}

class UserData: Codable {
    var puntuacion: Int
    
    
    init(_ puntuacion: Int) {
        self.puntuacion = puntuacion
    }
}


