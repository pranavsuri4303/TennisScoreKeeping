//
//  Home.swift
//  Login_Face_ID
//
//  Created by Sameer Suri on 21/1/21.
//

import SwiftUI
import Firebase

struct Home: View {
    var body: some View {
        ViewSwitcher()
    }
}

struct HomePage : View {
    var body: some View{
        Color.red
    }
}

struct ViewSwitcher : View {
    
    // for future use...
    @State var width = UIScreen.main.bounds.width - 90
    // to hide view...
    @State var x = -UIScreen.main.bounds.width + 90
    
    @State var currentSelectedMenuView : SlideMenuView = .dashboard
    
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            switch currentSelectedMenuView {
            case .profile : ProfileView()
            case .string : StringView()
            case .dashboard : DashboardView()
            case .none: HomePage()
                
            }
            
            Group{
           
                Button(action: {
                    // opening menu,...
                    withAnimation{
                        x = 0
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 24))
                        .foregroundColor(Color("green"))
                }
            
            .padding()
            .shadow(color: Color.white.opacity(0.0), radius: 5, x: 0, y: 5)
            }
            
            SlideMenu(currentSelectedView: $currentSelectedMenuView, x: $x)
                .offset(x: x)
                .background(Color.white.opacity(x == 0 ? 0.1 : 0).ignoresSafeArea(.all, edges: .vertical).onTapGesture {
                    
                    // hiding the view when back is pressed...
                    
                    withAnimation{
                        
                        x = -width
                    }
                })
        }
        // adding gesture or drag feature...
        .gesture(DragGesture().onChanged({ (value) in
            
            withAnimation{
                
                if value.translation.width > 0{
                    
                    // disabling over drag...
                    
                    if x < 0{
                        
                        x = -width + value.translation.width
                    }
                }
                else{
                    
                    if x != -width{
                        
                        x = value.translation.width
                    }
                }
            }
            
        }).onEnded({ (value) in
            
            withAnimation{
                
                // checking if half the value of menu is dragged means setting x to 0...
                
                if -x < width / 1.9{
                    
                    x = 0
                }
                else{
                    
                    x = -width
                }
            }
        }))
        
    }
}

struct SlideMenu : View {
    @Binding var currentSelectedView : SlideMenuView
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var show = true
    @AppStorage("status") var logged = false
    @Binding var x : CGFloat

    
    var body: some View {
        
        HStack(spacing: 0){
            
            VStack(alignment: .leading){
                ZStack{
                    Circle()
                        .foregroundColor(.white).opacity(0.3)
                        .frame(width: 80, height: 80)
                    Image("logo")
                        .resizable()
                        .frame(width: 60, height: 60)
                }.frame(alignment: .center)
                
                
                
                
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("\(Auth.auth().currentUser?.displayName ?? "User")")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("SAMPLE")
                        .foregroundColor(.gray)
                    
                    
                    Divider()
                        .padding(.top,10)
                        .foregroundColor(Color.green)
                }
                Spacer(minLength: 0)
                
                
                
                // Different Views When up or down buttons pressed....
                
                VStack(alignment: .leading){
                    
                    // Menu Buttons....
                    
                    ForEach(menuButtons , id : \.self){menu in
                        
                       
                        MenuButton(x: $x, currentSelectedHome: $currentSelectedView, slideMenuItem: menu , title : menu.rawValue)
                            
                        
                    }
                    
                    Divider()
                        .padding(.top)
                    
                    Button(action: {
                        // switch your actions or work based on title....
                    }) {
                        
                        MenuButton(x: $x, currentSelectedHome: .constant(.none), slideMenuItem: .none, title: "Twitter Ads")
                    }
                    
                    Divider()
                        .frame(height: nil)
                    Spacer()
                    Button(action: {
                        try! Auth.auth().signOut()
                        withAnimation{logged = false}
                    }) {
                        Text("Log out")
                            .foregroundColor(Color("green"))
                    }
                    .padding(.top,20)
                    
                    
                    Divider()
                        .padding(.bottom)
                    
                    HStack{
                        
                        Button(action: {}) {
                            
                            Image("help")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 26, height: 26)
                                .foregroundColor(Color("green"))
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {}) {
                            
                            Image("barcode")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 26, height: 26)
                                .foregroundColor(Color("green"))
                        }
                    }
                }
                
                
            }
            .padding(.horizontal,20)
            // since vertical edges are ignored....
            .padding(.top,edges!.top == 0 ? 15 : edges?.top)
            .padding(.bottom,edges!.bottom == 0 ? 15 : edges?.bottom)
            // default width...
            .frame(width: UIScreen.main.bounds.width - 90)
            .background(Color("bg").ignoresSafeArea(.all, edges: .all))
            .ignoresSafeArea(.all, edges: .vertical)
            
            Spacer(minLength: 0)
        }
    }
}


var menuButtons : [SlideMenuView] {
    var all = SlideMenuView.allCases
    all.removeLast()
    return all
}


struct MenuButton : View {
    @Binding var x : CGFloat
    @Binding  var currentSelectedHome : SlideMenuView
    
    var slideMenuItem : SlideMenuView
    var title : String
    
    
    var body: some View{
        
        HStack(spacing: 15){
            
            // both title and image names are same....
            if title == "String"{
                Image(systemName: "number")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
            }else{
                Image(title)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
            }
            
            
            
            Text(title)
                .foregroundColor(.white)
                
            
            Spacer(minLength: 0)
        }
        .padding(.vertical,12)
        .onTapGesture {
            currentSelectedHome = slideMenuItem
            withAnimation { 
                
                x = -UIScreen.main.bounds.width
            }
           
            
        }
        
    }
}

