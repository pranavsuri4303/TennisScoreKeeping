//
//  RegisterViewModel.swift
//  Tennis
//
//  Created by Sameer Suri on 21/1/21.
//

import SwiftUI
import LocalAuthentication
import Firebase

class RegisterViewModel : ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    // User Data....
    
    @AppStorage("status") var logged = false
    
    // For Alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    // Loading Screen...
    @Published var isLoading = false
    
    // Getting BioMetricType....
    

    // Create User...
    func createUser() {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { (res,err) in
            self.isLoading = false
            
            if let error = err{
                self.alertMsg = error.localizedDescription
                self.alert.toggle()
                return
            }else{
                withAnimation{self.logged = true}
            }
          
        }
    }
}
