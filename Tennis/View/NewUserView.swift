//
//  NewUserView.swift
//  Tennis
//
//  Created by Sameer Suri on 22/1/21.
//

import SwiftUI

struct NewUserView: View {
    @StateObject var vm = NewUserModel()
    @State var startAnimate = false

    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Image("newUser2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //Dynamic Frame...
                    .padding([.leading, .bottom, .trailing],35)
                    .padding()
                HStack{
                    
                    VStack(alignment: .leading, spacing: 12, content: {
                        
                        Text("New user details")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Please enter the following details for a more personalized experience.")
                            .foregroundColor(Color.white.opacity(0.5))
                    })
                    .padding(.bottom)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.leading,15)
                HStack{
                    Image(systemName: "person")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    TextField("Name", text: $vm.name)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(vm.name == "" ? 0.02 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                HStack{
                    Image(systemName: "calendar")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    TextField("Year of Birth", text: $vm.yob)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(vm.yob == "" ? 0.02 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                HStack{
                    Image(systemName: "flag")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    TextField("Nationality", text: $vm.nationality)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(vm.nationality == "" ? 0.02 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                HStack(spacing: 15){
                    
                    Button(action: {}, label: {
                        Text("Create account")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color("green"))
                            .clipShape(Capsule())
                    })
                    .opacity(vm.name != "" && vm.yob != "" && vm.nationality != "" ? 1 : 0.5)
                    .disabled(vm.name != "" && vm.yob != "" && vm.nationality != "" ? false : true)
                    .alert(isPresented: $vm.alert, content: {
                        Alert(title: Text("Error"), message: Text(vm.alertMsg), dismissButton: .destructive(Text("Ok")))
                    })
                    
                }
                .padding(.vertical)
                Spacer()
            }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
            .animation(startAnimate ? .easeOut : .none)
           
            if vm.isLoading{
                LoadingScreenView()
            }
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.startAnimate.toggle()
            }
        })
        
        
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView()
    }
}