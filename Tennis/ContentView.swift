//
//  ContentView.swift
//  Tennis
//
//  Created by Pranav Suri on 21/1/21.
//

import SwiftUI
import LocalAuthentication
struct ContentView: View {
    @AppStorage("status") var logged = false
    @ObservedObject var sliderMenueVM = DownloadedProfileImage.shared
    let sliderVM = SliderMenuVM()
    var body: some View {
        NavigationView{
            
            if logged{
                
                Home()
                    .preferredColorScheme(.light)
                    .navigationBarHidden(true)
                    .onAppear(perform: {
                        print("Shown")
                        SliderMenuVM.init().loadImageFromStorage()
                        
                    })
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
