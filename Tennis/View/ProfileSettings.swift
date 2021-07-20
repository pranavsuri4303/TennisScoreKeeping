//
//  ProfileSettings.swift
//  Tennis
//
//  Created by Pranav Suri on 20/7/21.
//

import SwiftUI
import ImagePickerView

struct ProfileSettings: View {
    @Binding var profileSettingsPresented : Bool
    @ObservedObject var vm : ProfileVM
    
    // Image
    @State var isImagePickerViewPresented = false
    @State var pickedImage: UIImage? = nil
    
    var body: some View {
        ZStack{
            Color("bg")
                .edgesIgnoringSafeArea(.all)
            VStack{
                ZStack{
                    HStack(alignment: .center){
                        Text("Settings")
                            .font(.title2)
                    }
                    HStack(){
                        Button(action: {
                            profileSettingsPresented.toggle()
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(Color("green"))
                                .font(.title2)
                        })
                        Spacer()
                        Button(action: {
                            print("Button Pressed")
                        }, label: {
                            Image(systemName: "pencil.circle")
                                .foregroundColor(Color("green"))
                                .font(.title2)
                        })
                    }.padding(.horizontal)
                }
                HStack{
                    GeometryReader{ geo in
                        ZStack{
                            Circle()
                                .frame(width: geo.size.width*0.3 + 10 ,height: geo.size.width*0.3 + 10, alignment: .center)
                                .foregroundColor(.white.opacity(0.3))
                                .overlay(Image("Male")
                                            .resizable()
                                            .frame(width: geo.size.width*0.3 ,height: geo.size.width*0.3, alignment: .center)
                                            .aspectRatio(contentMode: .fit))
                            VStack{
                                Spacer()
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        isImagePickerViewPresented.toggle()
                                    }, label: {
                                        Image(systemName: "pencil.circle.fill")
                                            .foregroundColor(.blue)
                                            .font(.title)
                                    })
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
                                    
                                }
                            }
                        }.frame(width: geo.size.width*0.3 + 10 ,height: geo.size.width*0.3 + 10, alignment: .center)
                    }
                        
                }.padding()
                Spacer()
            }
            
            
        }
    }
}

