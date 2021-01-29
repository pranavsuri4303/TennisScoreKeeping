//
//  RegisterView.swift
//  Tennis
//
//  Created by Sameer Suri on 21/1/21.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var vm = RegisterViewModel()
    
    @Binding var registerViewPresented : Bool
    
    @State var newUserViewPresented = false
    
    
    @State var startAnimate = false
    var body: some View {

            ZStack{
                
                
                VStack{
                    Spacer(minLength: 0)
                    
                    Image("signup")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //Dynamic Frame...
                        .padding([.leading, .bottom, .trailing],35)
                        .padding()
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 12, content: {
                            
                            Text("Create Account")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("Please sign up to create account")
                                .foregroundColor(Color.white.opacity(0.5))
                        })
                        .padding(.bottom)
                        
                        Spacer(minLength: 0)
                    }
                    .padding()
                    .padding(.leading,15)
                    
                    HStack{
                        
                        Image(systemName: "envelope")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        
                        TextField("EMAIL", text: $vm.email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    }
                    .padding()
                    .background(Color.white.opacity(vm.email == "" ? 0.02 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    HStack{
                        
                        Image(systemName: "lock")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        
                        SecureField("PASSWORD", text: $vm.password)
                            .autocapitalization(.none)
                    }
                    .padding()
                    .background(Color.white.opacity(vm.password == "" ? 0.02 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top)
                    
                    HStack(spacing: 15){
                        
                        Button(action: {
                            newUserViewPresented.toggle()
                            
                        }, label: {
                            Text("SIGN UP")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color("green"))
                                .clipShape(Capsule())
                        })
                        .opacity(vm.email != "" && vm.password != "" ? 1 : 0.5)
                        .disabled(vm.email != "" && vm.password != "" ? false : true)
                        .alert(isPresented: $vm.alert, content: {
                            Alert(title: Text("Error"), message: Text(vm.alertMsg), dismissButton: .destructive(Text("Ok")))
                        })
                        
                    }
                    .padding(.top)
                    
                    Button(action: {}, label: {
                        Image("googleLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40, alignment: .center)
                        
                    })
                    .padding(.all)
                    
                    
                    // SignUp...
                    
                    
                    HStack(spacing: 5){
                        
                        Text("Already have an account? ")
                            .foregroundColor(Color.white.opacity(0.6))
                        
                        Button("Login"){
                            registerViewPresented.toggle()
                            
                        }
                        .foregroundColor(Color("green"))
                        
                    }
                    
                    .padding(.vertical)
                }
                .background(Color("bg").ignoresSafeArea(.all, edges: .all))
                .animation(startAnimate ? .easeOut : .none)
                
                if vm.isLoading{
                    LoadingScreenView()
                }
                
            }
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.startAnimate.toggle()
                }
            })
            .sheet(isPresented: $newUserViewPresented, content: {
                NewUserView(isPresented : $newUserViewPresented, vm: vm)
            })
         
            
            
        }
        
        
    }





