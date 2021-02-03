//
//  PLayersVM.swift
//  Tennis
//
//  Created by Sameer Suri on 31/1/21.
//


import SwiftUI
import LocalAuthentication
import Firebase
import Combine
class PlayersVM : ObservableObject{
    var subscriptions : Set<AnyCancellable> = []
    @Published var playerName = ""
    // For Alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    @Published var players: [PlayerModel] = []
    // Firebase Stuff
    
  
    func searchPlayer(){
       
        players = []
        let usersRef = Firestore.firestore().collection("users")
        let query = usersRef.whereField("email", isGreaterThanOrEqualTo: "\(playerName)")
            .whereField("email", isLessThanOrEqualTo: "\(playerName)z")
        
        query.getDocuments { (results, err) in
            if let err = err{
                self.alert.toggle()
                self.alertMsg = err.localizedDescription
            }else{
                self.players = []

                for document in results!.documents{
                   guard
                    let name = document["name"] as? String,
                    let gender = document["gender"] as? String,
                    let imagePath = document["uid"] as? String
                    
                   else {return}
                    let player = PlayerModel(name: name ,gender: gender, imagePath: imagePath + "/profileImage.jpeg" )
                    
                    
                    self.players.append(player)
                }
               
                
            }
        }
        
    }
    
}
struct PlayerModel : Hashable  {
    let id = UUID.init()
    let name : String
    let gender: String
    let imagePath : String
    var downloadedImage : UIImage? = nil 
}
