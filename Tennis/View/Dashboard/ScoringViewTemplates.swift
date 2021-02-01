//
//  ScoringViewTemplates.swift
//  Tennis
//
//  Created by Sameer Suri on 1/2/21.
//

import SwiftUI

struct ServerViewAll: View {
    @StateObject var vm : MatchVM
    var body: some View {
        HStack{
            VStack(){
                Button(action: {
                    vm.pointWon(by: vm.server)
                }, label: {
                    Spacer()

                    Text("SERVE IN")
                        .font(.headline)
                        .foregroundColor(Color("blue"))
                        .multilineTextAlignment(.center)
                    Spacer()

                })
                .edgesIgnoringSafeArea(.all)
            }.frame(height: 100, alignment: .center)
            .background(Color("Orange").opacity(0.5).cornerRadius(8))
            if vm.serve == .firstServe{
                VStack(){
                        Button(action: {
                            vm.pointWon(by: vm.server)
                        }, label: {
                            Spacer()
                            Text("FIRST FAULT")
                                .font(.headline)
                                .foregroundColor(Color("blue"))
                                .multilineTextAlignment(.center)
                            Spacer()

                        })
                        .edgesIgnoringSafeArea(.all)
                    }.frame(height: 100, alignment: .center)
                    .background(Color("Orange").opacity(0.5).cornerRadius(8))
            }else if vm.serve == .secondServe{
                VStack(){
                        Button(action: {
                            vm.pointWon(by: vm.server)
                        }, label: {
                            Spacer()
                            Text("DOUBLE FAULT")
                                .font(.headline)
                                .foregroundColor(Color("blue"))
                                .multilineTextAlignment(.center)
                            Spacer()

                        })
                        .edgesIgnoringSafeArea(.all)
                    }.frame(height: 100, alignment: .center)
                    .background(Color("Orange").opacity(0.5).cornerRadius(8))
            }
            VStack(){
                    Button(action: {}, label: {
                        Spacer()

                        Text("ACE")
                            .font(.headline)
                            .foregroundColor(Color("blue"))
                            .multilineTextAlignment(.center)
                        Spacer()

                    })
                    .edgesIgnoringSafeArea(.all)
                }.frame(height: 100, alignment: .center)
                .background(Color("Orange").opacity(0.5).cornerRadius(8))
        }.padding(.horizontal)
        
    }
    
}
struct BasicNonServerView: View {
    @StateObject var vm : MatchVM
    var body: some View {
        HStack{
            VStack(){
                Button(action: {
                    vm.gameWon(by: vm.server)
                }, label: {
                    Spacer()
                    Text("POINT WON")
                        .font(.headline)
                        .foregroundColor(Color("blue"))
                        .multilineTextAlignment(.center)
                    Spacer()
                })
                .edgesIgnoringSafeArea(.all)
            }.frame(height: 100, alignment: .center)
            .background(Color("Orange").opacity(0.5).cornerRadius(8))

        }.padding(.horizontal)
    }
}
