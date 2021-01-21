//
//  NewUserViewModel.swift
//  Tennis
//
//  Created by Sameer Suri on 22/1/21.
//

import SwiftUI
import LocalAuthentication
import Firebase

class NewUserModel : ObservableObject{
    
    @Published var name = ""
    @Published var yob = ""
    @Published var nationality = ""


    
    // User Data....
    
    @AppStorage("status") var logged = false
    
    // For Alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    // Loading Screen...
    @Published var isLoading = false
    
    // Getting BioMetricType....
}
