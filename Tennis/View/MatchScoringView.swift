//
//  MatchScoreingView.swift
//  Tennis
//
//  Created by Sameer Suri on 29/1/21.
//

import SwiftUI

struct MatchScoringView: View {
    @StateObject var vm = NewMatchViewModel()
    var body: some View {
        VStack{
            ScoreboardOneSet()
            VStack{
                HStack{
                    Text("Player 1")
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    if vm.server == .player1 {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color("green"))
                    } else {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color("green"))
                            .hidden()
                    }
                    
                }.padding()
            }.background(Color(.white).opacity(0.1).cornerRadius(8))
            .padding(.horizontal)
            VStack{
                HStack{
                    Text("Player 2")
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    if vm.server == .player2 {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color("green"))
                    } else {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color("green"))
                            .hidden()
                    }
                    
                }.padding()
            }.background(Color(.white).opacity(0.1).cornerRadius(8))
            .padding(.horizontal)
            Spacer()
        }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
        
        
    }
}



struct MatchScoreingView_Previews: PreviewProvider {
    static var previews: some View {
        MatchScoringView()
    }
}







struct ScoreboardOneSet: View {
    @StateObject var vm = NewMatchViewModel()

    var body: some View {
        VStack{
            Text("Score")
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.top)
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Text("Pranav")
                            .font(.title3)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        if vm.server == .player1 {
                            Image(systemName: "bolt.fill")
                                .foregroundColor(Color("green"))
                        } else {
                            Image(systemName: "bolt.fill")
                                .foregroundColor(Color("green"))
                                .hidden()
                        }
                    }
                    HStack{
                        Text("Aldrin")
                            .font(.title3)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        if vm.server == .player2 {
                            Image(systemName: "bolt.fill")
                                .foregroundColor(Color("green"))
                        } else {
                            Image(systemName: "bolt.fill")
                                .foregroundColor(Color("green"))
                                .hidden()
                        }
                    }
                }.padding()
                Spacer()
                VStack(spacing: 10){
                    Text("0")
                        .font(.title3)
                        .foregroundColor(Color("green"))
                        .multilineTextAlignment(.leading)
                    Text("0")
                        .font(.title3)
                        .foregroundColor(Color("green"))
                        .multilineTextAlignment(.leading)
                }.padding()
                VStack(spacing: 10){
                    Text("0")
                        .font(.title3)
                        .foregroundColor(Color("green"))
                        .multilineTextAlignment(.leading)
                    Text("0")
                        .font(.title3)
                        .foregroundColor(Color("green"))
                        .multilineTextAlignment(.leading)
                }.padding()
            }.background(Color(.white).opacity(0.1).cornerRadius(8))
            .padding()
        }
    }
}
struct ScoreboardThreeSet: View {
    var body: some View {
        VStack{
            Text("Score")
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.top)
            HStack{
                VStack(spacing: 10){
                    Text("Pranav")
                        .font(.title3)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Text("Aldrin")
                        .font(.title3)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }.padding()
                Spacer()
                VStack(spacing: 10){
                    Text("0")
                        .font(.title3)
                        .foregroundColor(Color("green"))
                        .multilineTextAlignment(.leading)
                    Text("0")
                        .font(.title3)
                        .foregroundColor(Color("green"))
                        .multilineTextAlignment(.leading)
                }.padding()
                VStack(spacing: 10){
                    Text("0")
                        .font(.title3)
                        .foregroundColor(Color("green"))
                        .multilineTextAlignment(.leading)
                    Text("0")
                        .font(.title3)
                        .foregroundColor(Color("green"))
                        .multilineTextAlignment(.leading)
                }.padding()
                VStack(spacing: 10){
                    Text("0")
                        .font(.title3)
                        .foregroundColor(Color("green"))
                        .multilineTextAlignment(.leading)
                    Text("0")
                        .font(.title3)
                        .foregroundColor(Color("green"))
                        .multilineTextAlignment(.leading)
                }.padding()
            }.background(Color(.white).opacity(0.1).cornerRadius(8))
            .padding()
        }
    }
}
