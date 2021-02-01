//
//  ResetPasswordView.swift
//  Tennis
//
//  Created by Sameer Suri on 21/1/21.
//

import SwiftUI

struct ResetPasswordView: View {
    @StateObject var vm = LoginViewModel()
    @AppStorage("status") var logged = false

    var body: some View{
        ZStack{
            GeometryReader{ geo in
                VStack{
                    Image("resetPassword")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //Dynamic Frame...
                        .padding(.all,50.0)
                        .padding()
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 12, content: {
                            
                            Text("Reset password")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("Enter email to reset password")
                                .foregroundColor(Color.white.opacity(0.5))
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
                        
                        TextField("EMAIL", text: $vm.resetEmail)
                            .autocapitalization(.none)
                    }
                    .padding(.all)
                    .background(Color.white.opacity(vm.resetEmail == "" ? 0.02 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    Spacer()

                    Button(action: vm.resetPassword, label: {
                        Text("Reset Password")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color("green"))
                            .clipShape(Capsule())
                    })
                    .opacity(vm.resetEmail != "" ? 1 : 0.5)
                    .disabled(vm.resetEmail != "" ? false : true)
                    .alert(isPresented: $vm.alert, content: {
                        Alert(title: Text(""), message: Text(vm.alertMsg), dismissButton: .destructive(Text("Ok")))
                    })
                }
                .background(Color("bg").ignoresSafeArea(.all, edges: .all))

            }
            
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
