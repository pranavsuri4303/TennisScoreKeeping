//
//  PLayersVM.swift
//  Tennis
//
//  Created by Pranav Suri on 31/1/21.
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
            .order(by: "email", descending: false)

        query.getDocuments { [weak self] (results, err) in
            guard let self = self else {return}
            
            if let err = err{
                self.alert.toggle()
                self.alertMsg = err.localizedDescription
            }else{
                self.players = []
                for document in results!.documents{
                    guard
                        let uid = document["uid"] as? String,
                        let name = document["name"] as? String,
                        let gender = document["gender"] as? String,
                        let imagePath = document["uid"] as? String,
                        let nationality = document["nationality"] as? String
                    else {return}
                    let player = PlayerModel(uid: uid, name: name ,gender: gender, imagePath: imagePath + "/profileImage.jpeg", nationality: nationality )
                    
                    
                    self.players.append(player)
                }
                print(self.players.count)
                
                
            }
        }
        
    }
    
}
