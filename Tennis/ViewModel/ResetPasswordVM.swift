//
//  ResetPasswordVM.swift
//  Tennis
//
//  Created by Pranav Suri on 27/3/21.
//

import SwiftUI
import LocalAuthentication
import Firebase

class ResetPasswordVM : ObservableObject{
    
    @Published var email = ""
    @Published var isLoading = false
    
    // For Alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    
    
    func resetPassword(){
        self.isLoading = true
        Auth.auth().sendPasswordReset(withEmail: email) { err in
            if let error = err{
                self.isLoading.toggle()
                self.alertMsg = error.localizedDescription
                self.alert.toggle()
                return
            }else{
                self.isLoading.toggle()
                self.alertMsg = "A password reset email has been sent to the email address provided."
                self.alert.toggle()
            }
        }
    }
}

