//
//  AddMatchViewModel.swift
//  Tennis
//
//  Created by Sameer Suri on 29/1/21.
//

import SwiftUI
import LocalAuthentication
import Firebase

final class MatchVM : ObservableObject{
    // Games
    @Published var server = Player.player1
    @Published var noOfSets = 1
    @Published var deuceOrNo = Deuce.deuce
    @Published var trackingStyle = Tracking.basic
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
    // Serve
    @Published var serve = Serve.firstServe
    // For Alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    // Loading Screen...
    @Published var isLoading = false
    // Stats P1
    @Published var p1TotalPts = 0
    @Published var p2TotalPts = 0
    @Published var p1DoubleFaults = 0
    @Published var p2DoubleFaults = 0
    
    func pointWon(by: Player){
        switch by {
        case .player1:
            self.p1Pts += 1
        case .player2:
            self.p2Pts += 1
            
        }
    }
    func resetPts() {
        p1Pts = 0
        p2Pts = 0
    }
    func gameWon(by: Player) {
        if by == .player1{
            p1Games += 1
            resetPts()
        }else{
            p2Games += 1
        }
    }
    
    func checkIfGameIsOver(p1: Int, p2: Int, deuce: Deuce){
        switch deuce {
        case .noDeuce:
            if p1Pts == 4 || p2Pts == 4 {
                if p1Pts > p2Pts{
                    gameWon(by: .player1)
                }else{
                    gameWon(by: .player2)
                }
                
            }
        case .deuce:
            print(p1,p2)
        case .oneDeuce:
            print(p1,p2)
        }
    }
    
    func ptsScoreTranslator(pts: Int) -> String {
        switch pts {
        case 0:
            return "0"
        case 1:
            return "15"
        case 2:
            return "30"
        case 3:
            return "40"
        case 4:
            if self.deuceOrNo == .oneDeuce{
                return "AD"
            }else{
                return "0"
            }
        case 5:
            return "0"
        default:
            print("Going to Default!! Erroor")
            return"0"
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
enum Tracking {
    case basic
    case advanced
    case expert
}
enum Serve {
    case firstServe
    case secondServe
}
