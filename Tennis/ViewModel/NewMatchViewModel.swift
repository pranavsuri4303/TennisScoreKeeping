//
//  AddMatchViewModel.swift
//  Tennis
//
//  Created by Sameer Suri on 29/1/21.
//

import SwiftUI
import LocalAuthentication
import Firebase

final class NewMatchViewModel : ObservableObject{
    // Games
    @Published var server = Player.player1
    @Published var noOfSets = 1
    @Published var deuceOrNo = Deuce.deuce
    @Published var tiebreak = false
    // Player 1
    @Published var p1Name = "\((Auth.auth().currentUser?.displayName)!)"
    @Published var p1Pts = 0
    @Published var p1Games = 0
    @Published var p1Sets = 0
    // Player 2
    @Published var p2Name: String = ""
    @Published var p2Pts = 0
    @Published var p2Games = 0
    @Published var p2Sets = 0
    // Score
    @Published var p1PtsScore = ""
    @Published var p2PtsScore = ""
    @Published var p1GamesScore = ""
    @Published var p2GamesScore = ""
    @Published var p1SetScore = ""
    @Published var pwSetScore = ""
    // For Alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    // Loading Screen...
    @Published var isLoading = false
    

}
