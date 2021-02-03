//
//  Home.swift
//  Login_Face_ID
//
//  Created by Sameer Suri on 21/1/21.
//

import SwiftUI
import Firebase

class DownloadedProfileImage : ObservableObject {
    @Published  var image  : UIImage? = nil
    static let shared = DownloadedProfileImage()
}

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
    
    // to hide view...
   
    
    @State var currentSelectedMenuView : SlideMenuView = .dashboard
    @GestureState var gestureState : CGFloat = 0
    @StateObject var isSliderMenuPresented = SliderMenuPresentationManager.shared
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            switch currentSelectedMenuView {
            case .profile : ProfileView()
            case .string : StringView()
            case .dashboard : DashboardView()
            case .players : PlayersSearchView()
            case .matches : MatchesHistoryView()
            case .none: HomePage()
            }
            
            
            
            Button(action: {
                // opening menu,...
               
                isSliderMenuPresented.isPresented.toggle()
                
            }) {
                Image(systemName: "line.horizontal.3")
                    .font(.system(size: 24))
                    .foregroundColor(Color("green"))
            }
            .clipped()
            
            .padding()
            .shadow(color: Color.white.opacity(0.0), radius: 5, x: 0, y: 5)
            
            
            if isSliderMenuPresented.isPresented {
                SlideMenu(currentSelectedView: $currentSelectedMenuView)
                    .transition(AnyTransition.sliderMenueTransition.animation(.easeIn))
                    .animation(.easeIn)
                    .zIndex(1)
                    .offset(x: gestureState)
                    .gesture(
                    DragGesture()
                        .updating($gestureState, body: { (value, state, _) in
                            print(value.translation.width)
                            if value.translation.width < 1 {
                                state = value.translation.width
                            }
                        })
                        .onEnded({ (value) in
                            if value.translation.width < -100 {
                                isSliderMenuPresented.isPresented.toggle()
                            }
                        })
                    )
                    
                    }
                    
                
            }
            
        
    }
}

struct SlideMenu : View {
    @Binding var currentSelectedView : SlideMenuView
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @ObservedObject var sliderMenueVM = DownloadedProfileImage.shared
    let _x = SliderMenueVM()
    @AppStorage("status") var logged = false
    
    
    
    var body: some View {
        
        ZStack{
          
        HStack(spacing: 0){
            
            VStack(alignment: .leading){
                VStack(alignment: .center){
                    ZStack{
                        Circle()
                            .foregroundColor(.white).opacity(0.3)
                            .frame(width: 80, height: 80, alignment: .center)
                        
                        if let profileImage = sliderMenueVM.image {
                            Image(uiImage: profileImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 70, height: 70, alignment: .center)
                        }else {
                            Image("logo")
                                .resizable()
                                .frame(width: 60, height: 60, alignment: .center)
                        }
                    }.frame(alignment: .center)
                }
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("\(Auth.auth().currentUser?.displayName ?? "User")")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Divider()
                        .padding(.top,10)
                        .foregroundColor(Color.green)
                }
                Spacer(minLength: 0)
                
                
                
                // Different Views When up or down buttons pressed....
                
                VStack(alignment: .leading){
                    
                    // Menu Buttons....
                    
                    ForEach(menuButtons , id : \.self){menu in
                        
                        
                        MenuButton( currentSelectedHome: $currentSelectedView, slideMenuItem: menu , title : menu.rawValue)
                        
                        
                    }
                    
                    Divider()
                        .padding(.top)
                    
                    Button(action: {
                        // switch your actions or work based on title....
                    }) {
                        
                        MenuButton( currentSelectedHome: .constant(.none), slideMenuItem: .none, title: "Twitter Ads")
                    }
                    
                    Divider()
                        .frame(height: nil)
                    Spacer()
                    Button(action: {
                        SliderMenuPresentationManager.shared.isPresented.toggle()
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
}


var menuButtons : [SlideMenuView] {
    var all = SlideMenuView.allCases
    all.removeLast()
    return all
}


struct MenuButton : View {
   
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
            }else if title == "Players"{
                Image(systemName: "person.2")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fill)
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
           
            SliderMenuPresentationManager.shared.isPresented.toggle()
            
        }
        
    }
}

struct SliderMenuTransition : AnimatableModifier {
    var xOffset : CGFloat
    var backgroundAlpha : Double
    
    var animatableData: AnimatablePair<CGFloat , Double> {
        get {
            return .init(xOffset, backgroundAlpha)
        }
        set {
            xOffset = newValue.first
            backgroundAlpha = newValue.second
           
        }
    }
    
    
    func body(content: Content) -> some View {
        ZStack{
            if backgroundAlpha > 0.04 {
                Color.gray.opacity(backgroundAlpha)
                    .ignoresSafeArea()
                    .onTapGesture {
                        SliderMenuPresentationManager.shared.isPresented.toggle()
                    }
            }
        content.offset(x: xOffset)
        }
           
            
        
    }
}

extension AnyTransition{
    static let sliderMenueTransition : AnyTransition = AnyTransition.modifier(active: SliderMenuTransition.init(xOffset: -UIScreen.main.bounds.width * 4, backgroundAlpha: 0), identity: SliderMenuTransition.init(xOffset: 0, backgroundAlpha: 0.2))
}

class SliderMenuPresentationManager : ObservableObject {
    static let shared = SliderMenuPresentationManager()
    @Published var isPresented = false
    @Published var backgroundOpacity = false
}
