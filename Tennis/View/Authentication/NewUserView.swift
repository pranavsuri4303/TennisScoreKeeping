//
//  NewUserView.swift
//  Tennis
//
//  Created by Sameer Suri on 22/1/21.
//

import SwiftUI
import ImagePickerView

struct NewUserView: View {
    @Binding var isPresented : Bool
    @StateObject var vm : RegisterVM
    @State var startAnimate = false

    @State var selectionIndex = 0
    @State var nations = Nationalities().list
    
    // Image
    @State var isImagePickerViewPresented = false
    @State var pickedImage: UIImage? = nil
    
    // Creating an array of YOBs with range 100 yrs
    @State var years = Array(Calendar.current.component(.year, from: Date())-100...Calendar.current.component(.year, from: Date())).map { String($0) }
    
    var body: some View {
        ZStack{
            VStack{
                Button{
                    isImagePickerViewPresented = true
                }label: {
                    VStack {
                        if pickedImage == nil {
                            Circle()
                                .accentColor(.blue)
                                .frame(width: 210, height: 210, alignment: .center)
                                .overlay(Image("\(vm.gender)")
                                            .resizable()
                                            .frame(width: 200, height: 200)
                                            .cornerRadius(100)
                                            .padding())
                            
                        } else {
                            Circle()
                                .accentColor(.blue)
                                .frame(width: 210, height: 210, alignment: .center)
                                .overlay(Image(uiImage: pickedImage!)
                                            .resizable()
                                            .frame(width: 200, height: 200)
                                            .cornerRadius(100)
                                            .padding())
                            
                        }
                    }
                }
                .sheet(isPresented: $isImagePickerViewPresented) {
                    UIImagePickerView(allowsEditing: true, delegate: UIImagePickerView.Delegate(isPresented: $isImagePickerViewPresented, didCancel: { (uiImagePickerController) in
                        print("Did Cancel: \(uiImagePickerController)")
                    }, didSelect: { (result) in
                        let uiImagePickerController = result.picker
                        let image = result.image
                        print("Did Select image: \(image) from \(uiImagePickerController)")
                        pickedImage = image
                    }))
                }
                HStack{
                    
                    VStack(alignment: .leading, spacing: 10, content: {
                        
                        Text("New user details")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Please enter the following details for a more personalized experience.")
                            .foregroundColor(Color.white.opacity(0.5))
                    })
                    .padding(.bottom)
                    
                }
                .padding()
                HStack{
                    Image(systemName: "person")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    TextField("Name", text: $vm.name)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color(.white).opacity(vm.name == "" ? 0.02 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                HStack{
                    Image(systemName: "calendar")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextFieldWithInputView(data: $years, placeholder: "Year of Birth", selectionIndex: self.$selectionIndex, selectedText: $vm.yob)
                        .frame(height: 0)
                }
                .padding()
                .background(Color(.white).opacity(vm.yob == "" ? 0.02 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                HStack{
                    Image(systemName: "flag")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextFieldWithInputView(data: $nations, placeholder: "Select your country", selectionIndex: self.$selectionIndex, selectedText: $vm.nationality)
                        .frame(height: 0)
                }
                .padding()
                .background(Color(.white).opacity(vm.nationality == "" ? 0.02 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                Picker(selection: $vm.gender, label: Text(""), content: {
                    Text("Male").tag("Male")
                        .foregroundColor(Color.white)
                    Text("Female").foregroundColor(Color(.white)).tag("Female")
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding(.all)
                Spacer()
                HStack(spacing: 15){
                    
                    Button(action: {
                        
                        isPresented.toggle()
                        DispatchQueue.main.async {
                            
                            vm.configProfileImageDataFrom(UIImage: pickedImage)
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



