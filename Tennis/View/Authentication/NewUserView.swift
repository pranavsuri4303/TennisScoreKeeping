//
//  NewUserView.swift
//  Tennis
//
//  Created by Sameer Suri on 22/1/21.
//

import SwiftUI

struct NewUserView: View {
    @Binding var isPresented : Bool
    @StateObject var vm : RegisterVM
    @State var startAnimate = false
    @State var isPickerPresented : Bool  = false
    @State var pickedUIImage : UIImage? = nil
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Group{
                if let pickedUIImage = pickedUIImage {
               
                    Image(uiImage: pickedUIImage)
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                    
                        
        
                        
                }
                else {
                   
                    if vm.gender == "Male"{
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .overlay(Image("Male")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        //Dynamic Frame...
                                        .padding([.leading, .bottom, .trailing],35)
                                        .padding())
                
                    }else{
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .overlay(Image("Female")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        //Dynamic Frame...
                                        .padding([.leading, .bottom, .trailing],35)
                                        .padding())
                    }
                        
                    
    
                }
                }
                .onTapGesture {
                    isPickerPresented.toggle()
                }
                .sheet(isPresented: $isPickerPresented, content: {
                    ImagePicker(selectedImage: $pickedUIImage)
                })
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
                        .keyboardType(.numberPad)
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
                Picker(selection: $vm.gender, label: Text(""), content: {
                        Text("Male").tag("Male")
                            .foregroundColor(Color.white)
                        Text("Female").foregroundColor(Color.white).tag("Female")
                })
                    .pickerStyle(SegmentedPickerStyle())
                .padding(.all)
                
                HStack(spacing: 15){
                    
                    Button(action: {
                        
                        isPresented.toggle()
                        DispatchQueue.main.async {
                            
                            vm.configProfileImageDataFrom(UIImage: pickedUIImage)
                            vm.createUser()
                        }
                        
                    }, label: {
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

struct Register_Preview : PreviewProvider {
    static var previews: some View {
        NewUserView(isPresented: .constant(false), vm: RegisterVM.init())
    }
    
    
}

