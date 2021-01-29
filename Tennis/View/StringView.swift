//
//  SwiftUIView.swift
//  Tennis
//
//  Created by Sameer Suri on 28/1/21.
//

import SwiftUI

struct StringView: View {
    @StateObject var vm = StringsViewModel()
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
                                AddNewStringView()
                            }.padding(.all)
                        }
                    }
                    Spacer()
                }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
            }
        }
    }
}

