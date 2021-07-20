//
//  ProfileVM.swift
//  Tennis
//
//  Created by Pranav Suri on 6/2/21.
//

import SwiftUI
import LocalAuthentication
import Firebase

class ProfileVM : ObservableObject{
    // Firebase Stuff
    let db = Firestore.firestore()
    let uidStr = (Auth.auth().currentUser?.uid)
    @Published var gender = ""
    @Published var latestString : StringModel?
    @Published var alert = false
    @Published var alertMsg = ""
    // Loading Screen...
    @Published var isLoading = false
    // Getting BioMetricType....
    
    init() {
        print("hmm")
        self.fetchUserData()
    }
    
    // Fetch User Data
    func fetchUserData() {
        if let uidStr = uidStr {
            isLoading = true
            Firestore.firestore().collection("users").document("\(uidStr)").addSnapshotListener { (results, err) in
                if let err = err{
                    self.alert.toggle()
                    self.alertMsg = err.localizedDescription
                }else{
                    if let data = results{
                        self.isLoading = false
                        print(data)
                    }
                }
            }
            
            
        }
    }
    
}

