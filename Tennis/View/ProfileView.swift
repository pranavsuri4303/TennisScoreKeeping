//
//  ProfileView().swift
//  Tennis
//
//  Created by Sameer Suri on 3/2/21.
//

import SwiftUI
import Firebase
struct ProfileView: View {
    @AppStorage("status") var logged = false
    var body: some View {
        VStack{
            HStack{
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(.white))
                    .multilineTextAlignment(.center)
                    .padding(.top, 75)
                Spacer()
            }.padding()
            .background(Color(.white).opacity(0))
            
            ScrollView(.vertical, showsIndicators: false, content: {
                GeometryReader{reader in
                    // Type 2 Parollax....
                    if reader.frame(in: .global).minY > -480 {
                        Image("Roger")
                            .resizable()
                            .padding(.top,120)
                            .aspectRatio(contentMode: .fill)
                            // moving View Up....
                            .offset(y: -reader.frame(in: .global).minY)
                            // going to add parallax effect....
                            .frame(width: UIScreen.main.bounds.width, height:  reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + 480 : 480)
            
                    }
                }
                .frame(height: 480)
                VStack(alignment: .leading,spacing: 15){
                    HStack{
                        Text("Roger Federer")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("Male")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.top,5)
                    }
                    Divider()
                        .foregroundColor(.white)
                        .frame(height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    HStack{
                        Text("Current String")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                    }
                    Divider()
                        .foregroundColor(.white)
                        .frame(height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    HStack{
                        Text("Latest Match")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                    }
                    HStack{
                        Text("Outcome")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                    }
                    
                    
                }
                .padding(.top, 25)
                .padding(.horizontal)
                .background(Color("bg"))
                .cornerRadius(20)
                .offset(y: -10)
                .edgesIgnoringSafeArea(.horizontal)
            })
            .edgesIgnoringSafeArea(.all)
            .background(Color("bg").edgesIgnoringSafeArea(.all))
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color("bg").edgesIgnoringSafeArea(.all))
    }
    
}

