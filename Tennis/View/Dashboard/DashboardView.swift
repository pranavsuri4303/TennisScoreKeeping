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
struct Stats : Identifiable {
    
    var id = UUID().uuidString
    var title : String
    var value : String
    var color : Color
}
var salesData = [

    Stats(title: "Matches Played", value: "18,789", color: Color.orange),
    Stats(title: "Matches won", value: "1,089", color: Color.red),
    Stats(title: "Matches lost", value: "8,500", color: Color.blue),
    Stats(title: "Win %", value: "2,000", color: Color.pink),
    Stats(title: "Cancelled", value: "1,700", color: Color.purple),
]
