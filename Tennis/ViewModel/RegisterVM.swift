//
//  RegisterViewModel.swift
//  Tennis
//
//  Created by Sameer Suri on 21/1/21.
//

import SwiftUI
import LocalAuthentication
import Firebase

class RegisterVM : ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var yob = ""
    @Published var nationality = ""
    @Published var gender = "Male"
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
        Auth.auth().createUser(withEmail: email, password: password) { [self] (res,err) in
            self.isLoading = false
            
            if let error = err{
                self.alertMsg = error.localizedDescription
                self.alert.toggle()
                return
            }else{
                let change = res?.user.createProfileChangeRequest()
                change?.displayName = self.name
                change?.commitChanges(){ erro in
                    if let error = erro{
                        self.alertMsg = error.localizedDescription
                        self.alert.toggle()
                        return
                    }
                }
                let db = Firestore.firestore()
                let uidStr = (res?.user.uid)!
                let docData: [String: Any] = [
                    "name": "\(self.name)",
                    "email": "\(self.email)",
                    "uid": "\(String(describing: uidStr))",
                    "yob": "\(self.yob)",
                    "nationality": "\(self.nationality)",
                    "gender": "\(self.gender)"
                ]
                db.collection("users").document(uidStr).setData(docData) { err in
                    if let err = err {
                        self.alertMsg = err.localizedDescription
                        self.alert.toggle()
                        return
                        
                    } else {
                        withAnimation{
                            self.logged.toggle()
                        }
                    }
                }

            }
        }
    }

}
