//
//  SwiftUIView.swift
//  Tennis
//
//  Created by Sameer Suri on 28/1/21.
//

import SwiftUI

struct StringView: View {
    @StateObject var vm = StringsVM()
    @StateObject var stringListViewModel = StringsListVM()
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                VStack{
                    ZStack{
                        Text("String")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        HStack{
                            Spacer()
                            Button(action: {
                                self.vm.showAddString.toggle()
                            }, label: {
                                Image(systemName: "plus")
                                    .foregroundColor(Color("green"))
                                
                            }).sheet(isPresented: $vm.showAddString) {
                                AddNewStringView(addStringIsPresented: $vm.showAddString)
                            }.padding(.all)
                        }
                    }
                    
                    
                    ScrollView{
                        
                        ForEach(stringListViewModel.strings.reversed(), id: \.self) { (id)  in
                            VStack{
                                HStack{
                                    Text("\(id.name ?? "String")")
                                    Spacer()
                                    Text("\(id.date ?? Date(), style: .date)")
                                }
                                HStack{
                                    VStack{
                                        Text("\(id.mains ?? 00)")
                                            .font(.largeTitle)
                                            .fontWeight(.heavy)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(Color("green"))
                                        Text("Mains")
                                    }
                                    Spacer()
                                    VStack{
                                        Text("\(id.cross ?? 00)")
                                            .font(.largeTitle)
                                            .fontWeight(.heavy)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(Color("green"))
                                        Text("Cross")
                                    }
                                }
                            }
                            .padding(.all)
                            .background(Color(.white).opacity(0.1))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }.padding(.horizontal)
                    .edgesIgnoringSafeArea(.bottom)
                    
                    
                    Spacer()
                }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
            }
        }
        
        
    }

}


