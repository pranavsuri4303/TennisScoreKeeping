//
//  MatchesHistoryView.swift
//  Tennis
//
//  Created by Pranav Suri on 3/2/21.
//

import SwiftUI

struct MatchesHistoryView: View {
    @State var showAddMatch = false

    var body: some View {
        ZStack{
            GeometryReader{ geo in
                VStack{
                    ZStack{
                        HStack(alignment: .center, spacing: nil, content: {
                            Text("Matches")
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

struct MatchesHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchesHistoryView()
            MatchesHistoryView()
        }
    }
}
