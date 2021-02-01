//
//  DashboardView.swift
//  Tennis
//
//  Created by Sameer Suri on 23/1/21.
//

import SwiftUI

struct DashboardView: View {
    @State var showAddMatch = false
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                VStack{
                    ZStack{
                        Text("Dashboard")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        HStack{
                            Spacer()
                            Button(action: {
                                self.showAddMatch.toggle()
                            }, label: {
                                Image(systemName: "plus")
                                    .foregroundColor(Color("green"))

                            }).sheet(isPresented: $showAddMatch) {
                                NewMatchView()
                            }.padding(.all)
                        }
                    }
                    Spacer()
                }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
            }
        }
    }
}

