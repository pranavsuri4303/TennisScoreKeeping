//
//  AddMatchViewModel.swift
//  Tennis
//
//  Created by Sameer Suri on 29/1/21.
//

import SwiftUI
import LocalAuthentication
import Firebase

class NewMatchViewModel : ObservableObject{
    
    @Published var server = Player.player1
    @Published var playerOneName = "\((Auth.auth().currentUser?.displayName)!)"
    @Published var playerTwoName = ""
    @Published var noOfSet = 1
    @Published var deuceOrNo = ""
    

    // For Alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    // Loading Screen...
    @Published var isLoading = false
    
    func createMatch() {
        print("Match Created")
    }
    

}
enum Player {
    case player1
    case player2
}
