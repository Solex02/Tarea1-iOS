//
//  ViewController.swift
//  trabajo1ios
//
//  Created by user202258 on 10/10/2023.
//

import UIKit

var puntuacion = 0

class ViewController: UIViewController {
		
    var imagenes = ["gato", "perro","camion","pato","rana","raton"]
    var imagenesAparecidas:[String] = []
    var randomNum = 0
    var cont = true
    var ischanging = true
    
    
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var puntuacionLabel: UILabel!
    
    @IBOutlet weak var gatobutton: UIButton!
    @IBAction func gatobuttonclick(_ sender: Any) {
        checkImage(selectedImage: "gato")
    }
    
    
    
    @IBOutlet weak var perrobutton: UIButton!
    @IBAction func perrobuttonclick(_ sender: Any) {
        checkImage(selectedImage: "perro")
    }
    
    
    @IBOutlet weak var ranabutton: UIButton!
    @IBAction func ranabuttonclick(_ sender: Any) {
        checkImage(selectedImage: "rana")
    }
    
    
    @IBOutlet weak var camionbutton: UIButton!
    @IBAction func camionbuttonclick(_ sender: Any) {
        checkImage(selectedImage: "camion")
    }
    
    	
    
    @IBAction func ratonbuttonclick(_ sender: Any) {
        checkImage(selectedImage: "raton")
    }
    
    
    
    @IBOutlet weak var patobutton: UIButton!
    @IBAction func patobuttonclick(_ sender: Any) {
        checkImage(selectedImage: "pato")
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cont = true
        timer()
    }


    var counter = 0
    var contador = 0
    
    var gameTimer : Timer? = nil
    
    var blackScreen = false
    var primeravez = true
    
    func timer(){ //Temporizador entre imagenes para que se mantengan en pantalla 2 segundos
        let updateInterval = 2.0
        gameTimer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: false) { timer in
            if(self.cont){
                self.changeImage()
                
            }
                    
                	
        }
        
    }
    func checkImage(selectedImage:String){
        
        //Comprobar si el jugador acierta la imagen
        
        if(!ischanging){

            if(selectedImage == imagenesAparecidas[contador] && contador == imagenesAparecidas.count-1){
                print("Correcto")
                contador = 0
                puntuacion += 1
                puntuacionLabel.text = "Puntuación: " + String(puntuacion)
                cont = true
                timer()
                ischanging = true
            }
            else if (selectedImage != imagenesAparecidas[contador]){
                perder()
            }
            else if (selectedImage == imagenesAparecidas[contador]){
                
                print("Correcto")
                contador += 1
                
            }
        }
        
    }
    func perder(){ // mandar a la pantalla de perder
        performSegue(withIdentifier: "perder", sender: nil)
    }
    
    
    
    
    func changeImage(){

    //cambiar imagen
    
    if(counter < imagenesAparecidas.count && !blackScreen){ //cambiar imagen si la lista tiene mas de una
        
        self.mainImage.image = UIImage(named:imagenesAparecidas[counter])
        self.counter += 1
        print(counter)
    }
    else if (blackScreen){// Quitar imagen al final
        mainImage.image = UIImage(named:"black")
        cont = false
        blackScreen = false
        ischanging = false
    }
    else{//Crear ultima imagen despues de recorrer la lista
        randomNum = Int.random(in: 0..<imagenes.count)

        
        mainImage.image = UIImage(named: imagenes[randomNum])
        imagenesAparecidas.append(imagenes[randomNum])
        blackScreen = true
        counter = 0
        
        
        
    
    }
    
    timer()
    
        
        
    

    
    
    
    			
}

}
