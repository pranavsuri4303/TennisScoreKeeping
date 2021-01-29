//
//  MatchScoringViewModel.swift
//  Tennis
//
//  Created by Sameer Suri on 29/1/21.
//

import SwiftUI
import LocalAuthentication
import Firebase

final class MatchScoringViewModel : ObservableObject{
    @Published var server = NewMatchViewModel().server
    // Player 1
    @Published var p1Pts = 0
    @Published var p1Games = 0
    @Published var p1Sets = 0
    // Player 2
    @Published var p2Pts = 0
    @Published var p2Games = 0
    @Published var p2Sets = 0
    // Score

    @Published var p1GamesScore = "0"
    @Published var p2GamesScore = "0"
    @Published var p1SetScore = "0"
    @Published var pwSetScore = "0"
    // For Alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    // Loading Screen...
    @Published var isLoading = false
    
    func pointWon(by: Player){
        switch by {
        case .player1:
            self.p1Pts += 1
        case .player2:
            self.p2Pts += 1

        }
    }


    
    func ptsScore(of: Int, against: Int) -> String {
        if of >= 4 && against >= 4 && of - against == 1 {
            
            return "AD"
        }
        
        if of < 4 && against >= 4 {
            resetGame()
            return "0"
            
        }
        switch of {
        case 0:
            return "0"
        case 1:
            return "15"
        case 2:
            return "30"
        case 3:
            return "40"
        default:
            return "--"
        }
        
    }
    
    func resetGame() {
        self.p1Pts = 0
        self.p2Pts = 0
        if server == .player1{
            server = .player2
        }else{
            server = .player1
        }
    }
    

}
enum Player {
    case player1
    case player2
}
enum Deuce {
    case deuce
    case noDeuce
    case oneDeuce
}
