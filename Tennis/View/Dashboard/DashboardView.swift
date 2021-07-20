//
//  DashboardView.swift
//  Tennis
//
//  Created by Pranav Suri on 23/1/21.
//

import SwiftUI

struct DashboardView: View {
    @State var showAddMatch = false
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                VStack{
                    ZStack{
                        HStack(alignment: .center, spacing: nil, content: {
                            Text("Dashboard")
                                .fontWeight(.heavy)
                                .font(.title3)
                                .foregroundColor(.white)
                            
                        }).padding(.horizontal)
                        HStack(alignment: .center, spacing: nil, content: {
                            Spacer()
                            Button(action: {
                                self.showAddMatch.toggle()
                            }, label: {
                                Image(systemName: "plus.circle")
                                    .font(.title2)
                                    .foregroundColor(Color("green"))
                            }).sheet(isPresented: $showAddMatch) {
                                NewMatchView()
                            }
                        }).padding(.horizontal)
                    }.padding(.bottom, 10)
                    
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
