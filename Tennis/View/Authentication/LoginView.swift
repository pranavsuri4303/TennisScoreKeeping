//
//  LoginView.swift
//  Tennis
//
//  Created by Sameer Suri on 21/1/21.
//

import SwiftUI
import LocalAuthentication

struct LoginView : View {
    
    @StateObject var vm = LoginViewModel()
    // when first time user logged in via email store this for future biometric login....
    @AppStorage("stored_User") var Stored_User = ""
    @AppStorage("stored_Password") var Stored_Password = ""
    
    @AppStorage("status") var logged = false
    @State private var goToSignup = false
    
    @State var startAnimate = false
    @State var showingDetail = false
    var body: some View{
        
        ZStack{
            
            VStack{
                
                Spacer(minLength: 0)
                
                Image("homeLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //Dynamic Frame...
                    .padding(.horizontal,35)
                    .padding(.vertical)
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 12, content: {
                        
                        Text("Login")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Please sign in to continue")
                            .foregroundColor(Color(.white).opacity(0.5))
                    })
                    
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
                }
                .padding()
                .background(Color(.white).opacity(vm.email == "" ? 0.02 : 0.12))
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
                .background(Color(.white).opacity(vm.password == "" ? 0.02 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                HStack(spacing: 15){
                    
                    Button(action: vm.verifyUser, label: {
                        Text("LOGIN")
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
                    
                    if vm.getBioMetricStatus(){
                        
                        Button(action: vm.authenticateUser, label: {
                            
                            // getting biometrictype...
                            Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color("green"))
                                .clipShape(Circle())
                        })
                    }
                }
                .padding(.top)
                
                // Forget Button...
                
                Button(action: {
                    self.showingDetail.toggle()
                }, label: {
                    Text("Forget password?")
                        .foregroundColor(Color("green"))
                }).sheet(isPresented: $showingDetail) {
                    ResetPasswordView()
                }
                .padding(.top,8)
                .alert(isPresented: $vm.store_Info, content: {
                    Alert(title: Text("Message"), message: Text("Store Information For Future Login Using BioMetric Authentication ???"), primaryButton: .default(Text("Accept"), action: {
                        
                        // storing Info For BioMetric...
                        Stored_User = vm.email
                        Stored_Password = vm.password
                        
                        withAnimation{self.logged = true}
                        
                    }), secondaryButton: .cancel({
                        // redirecting to Home
                        withAnimation{self.logged = true}
                    }))
                })
                Button(action: {}, label: {
                    Image("googleLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40, alignment: .center)
                    
                })
                .padding(.all)
                
                // SignUp...
                
                
                HStack(spacing: 5){
                    
                    Text("Don't have an account? ")
                        .foregroundColor(Color(.white).opacity(0.6))
                    Button("Signup"){
                        goToSignup.toggle()
                    }
                    .foregroundColor(Color("green"))
                    .fullScreenCover(isPresented: $goToSignup) {
                        RegisterView( registerViewPresented: $goToSignup)
                    }
                    
                    
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
    }
}


