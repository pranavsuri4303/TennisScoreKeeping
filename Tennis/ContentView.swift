//
//  ContentView.swift
//  Tennis
//
//  Created by Sameer Suri on 21/1/21.
//

import SwiftUI
import LocalAuthentication
struct ContentView: View {
    @AppStorage("status") var logged = false
    var body: some View {
        NavigationView{
            
            if logged{
                
                Home()
                    .preferredColorScheme(.light)
                    .navigationBarHidden(true)
            }
            else{
                LoginView()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
