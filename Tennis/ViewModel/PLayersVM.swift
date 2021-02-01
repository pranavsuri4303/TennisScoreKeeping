//
//  PLayersVM.swift
//  Tennis
//
//  Created by Sameer Suri on 31/1/21.
//

import SwiftUI
import LocalAuthentication
import Firebase

class PlayersVM : ObservableObject{
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
                for document in results!.documents{
                    let name = document["name"] as? String
                    let gender = document["gender"] as? String?
                    let player = PlayerModel(name: name! ,gender: (((gender) ?? "Neutral") ?? "Neutral") )
                    print(player)
                    self.players.append(player)
                }
                print(self.players)
                
            }
        }
        print("\(playerName)")
    }
    
}
struct PlayerModel : Hashable  {
    let id = UUID.init()
    let name : String
    let gender: String
}
