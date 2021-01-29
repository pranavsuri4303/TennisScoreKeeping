//
//  StringViewModel.swift
//  Tennis
//
//  Created by Sameer Suri on 28/1/21.
//

import SwiftUI
import LocalAuthentication
import Firebase

class StringsViewModel : ObservableObject{
    @Published var stringName = ""
    @Published var mainsTension = 50
    @Published var crossTension = 50
    @Published var date = Date(timeIntervalSinceReferenceDate: 0)
    @Published var notes = ""
    // User Data....
    
    // For Alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    // Loading Screen...
    @Published var isLoading = false
    
    // Getting BioMetricType....
    

    // Create User...
    func addString() {
        let db = Firestore.firestore()
        let userDoc = (Auth.auth().currentUser?.uid)!
        let docRef  = db.collection("users").document(userDoc)
    }

}
