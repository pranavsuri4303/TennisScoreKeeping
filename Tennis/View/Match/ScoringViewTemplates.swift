//
//  ScoringViewTemplates.swift
//  Tennis
//
//  Created by Sameer Suri on 1/2/21.
//

import SwiftUI

struct BasicServerView: View {
    @StateObject var vm : MatchVM
    var body: some View {
        HStack{
            if vm.serveIn {
                HStack{
                    VStack(){
                        Button(action: {
                            vm.serveIn.toggle()
                            vm.pointWon(by: vm.server, deuce: vm.deuceOrNo, servingPlayer: vm.server)
                        }, label: {
                            Spacer()
                            Text("POINT WON")
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        })
                        .edgesIgnoringSafeArea(.all)
                    }.frame(height: 100, alignment: .center)
                    .background(Color(.orange).cornerRadius(8))
                    
                }.padding(.horizontal)
            }else{
                HStack{
                    VStack(){
                        Button(action: {
                            vm.serveIn.toggle()
                        }, label: {
                            Spacer()
                            
                            Text("SERVE IN")
                                .font(.headline)
                                .foregroundColor(Color(.white))
                                .multilineTextAlignment(.center)
                            Spacer()
                            
                        })
                        .edgesIgnoringSafeArea(.all)
                    }.frame(height: 100, alignment: .center)
                    .background(Color(.orange).cornerRadius(8))
                    if vm.serve == .firstServe{
                        VStack(){
                            Button(action: {
                                vm.serve = .secondServe
                            }, label: {
                                Spacer()
                                Text("FIRST FAULT")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                
                            })
                            .edgesIgnoringSafeArea(.all)
                        }.frame(height: 100, alignment: .center)
                        .background(Color(.orange).cornerRadius(8))
                    }else if vm.serve == .secondServe{
                        VStack(){
                            Button(action: {
                                vm.serve = .firstServe
                                if vm.server == .player1{
                                    vm.pointWon(by: .player2, deuce: vm.deuceOrNo, servingPlayer: vm.server)
                                }else if vm.server == .player2{
                                    vm.pointWon(by: .player1, deuce: vm.deuceOrNo, servingPlayer: vm.server)
                                }
                            }, label: {
                                Spacer()
                                Text("DOUBLE FAULT")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                
                            })
                            .edgesIgnoringSafeArea(.all)
                        }.frame(height: 100, alignment: .center)
                        .background(Color(.orange).cornerRadius(8))
                    }
                    VStack(){
                        Button(action: {
                            vm.pointWon(by: vm.server, deuce: vm.deuceOrNo, servingPlayer: vm.server)
                        }, label: {
                            Spacer()
                            
                            Text("ACE")
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                            
                        })
                        .edgesIgnoringSafeArea(.all)
                    }.frame(height: 100, alignment: .center)
                    .background(Color(.orange).cornerRadius(8))
                }.padding(.horizontal)
            }
        }
    }
}
struct BasicNonServerView: View {
    @StateObject var vm : MatchVM
    var body: some View {
        HStack{
            VStack(){
                Button(action: {
                    if vm.server == .player1{
                        vm.serveIn = false
                        vm.serve = .firstServe
                        vm.pointWon(by: .player2, deuce: vm.deuceOrNo, servingPlayer: vm.server)
                    }else{
                        vm.serveIn = false
                        vm.serve = .firstServe
                        vm.pointWon(by: .player1, deuce: vm.deuceOrNo, servingPlayer: vm.server)
                    }
                }, label: {
                    Spacer()
                    Text("POINT WON")
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Spacer()
                })
                .edgesIgnoringSafeArea(.all)
            }.frame(height: 100, alignment: .center)
            .background(Color(.orange).cornerRadius(8))
            
        }.padding(.horizontal)
    }
}

struct AdvancedServerView: View {
    @StateObject var vm : MatchVM
    var body: some View {
        HStack{
            if vm.serveIn {
                HStack{
                    VStack(){
                        Button(action: {
                            print("Winner")
                        }, label: {
                            Spacer()
                            Text("WINNER")
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        })
                        .edgesIgnoringSafeArea(.all)
                    }.frame(height: 100, alignment: .center)
                    .background(Color(.orange).cornerRadius(8))
                    VStack(){
                        Button(action: {
                            print("Forced Error")
                        }, label: {
                            Spacer()
                            Text("FORCED ERROR")
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        })
                        .edgesIgnoringSafeArea(.all)
                    }.frame(height: 100, alignment: .center)
                    .background(Color(.orange).cornerRadius(8))
                    VStack(){
                        Button(action: {
                            print("Unforced Error")
                        }, label: {
                            Spacer()
                            Text("UNFORCED ERROR")
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        })
                        .edgesIgnoringSafeArea(.all)
                    }.frame(height: 100, alignment: .center)
                    .background(Color(.orange).cornerRadius(8))
                }.padding(.horizontal)
            }else{
                HStack{
                    VStack(){
                        Button(action: {
                            vm.serveIn.toggle()
                        }, label: {
                            Spacer()
                            
                            Text("SERVE IN")
                                .font(.headline)
                                .foregroundColor(Color(.white))
                                .multilineTextAlignment(.center)
                            Spacer()
                            
                        })
                        .edgesIgnoringSafeArea(.all)
                    }.frame(height: 100, alignment: .center)
                    .background(Color(.orange).cornerRadius(8))
                    if vm.serve == .firstServe{
                        VStack(){
                            Button(action: {
                                vm.serve = .secondServe
                            }, label: {
                                Spacer()
                                Text("FIRST FAULT")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                
                            })
                            .edgesIgnoringSafeArea(.all)
                        }.frame(height: 100, alignment: .center)
                        .background(Color(.orange).cornerRadius(8))
                    }else if vm.serve == .secondServe{
                        VStack(){
                            Button(action: {
                                vm.serve = .firstServe
                                if vm.server == .player1{
                                    vm.pointWon(by: .player2, deuce: vm.deuceOrNo, servingPlayer: vm.server)
                                }else if vm.server == .player2{
                                    vm.pointWon(by: .player1, deuce: vm.deuceOrNo, servingPlayer: vm.server)
                                }
                            }, label: {
                                Spacer()
                                Text("DOUBLE FAULT")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                
                            })
                            .edgesIgnoringSafeArea(.all)
                        }.frame(height: 100, alignment: .center)
                        .background(Color(.orange).cornerRadius(8))
                    }
                    VStack(){
                        Button(action: {
                            vm.pointWon(by: vm.server, deuce: vm.deuceOrNo, servingPlayer: vm.server)
                        }, label: {
                            Spacer()
                            
                            Text("ACE")
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                            
                        })
                        .edgesIgnoringSafeArea(.all)
                    }.frame(height: 100, alignment: .center)
                    .background(Color(.orange).cornerRadius(8))
                }.padding(.horizontal)
            }
        }
    }
}
struct AdvancedNonServerView: View {
    @StateObject var vm : MatchVM
    var body: some View {
        HStack{
            if !(vm.serveIn) {
                VStack(){
                    Button(action: {
                        print("Return Winner")
                    }, label: {
                        Spacer()
                        Text("RETURN WINNER")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Spacer()
                    })
                    .edgesIgnoringSafeArea(.all)
                }.frame(height: 100, alignment: .center)
                .background(Color(.orange).cornerRadius(8))
                VStack(){
                    Button(action: {
                        print("Return Error")
                    }, label: {
                        Spacer()
                        Text("RETURN ERROR")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Spacer()
                    })
                    .edgesIgnoringSafeArea(.all)
                }.frame(height: 100, alignment: .center)
                .background(Color(.orange).cornerRadius(8))
            } else{
                VStack(){
                    Button(action: {
                        print("Winner")
                    }, label: {
                        Spacer()
                        Text("WINNER")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Spacer()
                    })
                    .edgesIgnoringSafeArea(.all)
                }.frame(height: 100, alignment: .center)
                .background(Color(.orange).cornerRadius(8))
                VStack(){
                    Button(action: {
                        print("Forced Error")
                    }, label: {
                        Spacer()
                        Text("FORCED ERROR")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Spacer()
                    })
                    .edgesIgnoringSafeArea(.all)
                }.frame(height: 100, alignment: .center)
                .background(Color(.orange).cornerRadius(8))
                VStack(){
                    Button(action: {
                        print("Unforced Error")
                    }, label: {
                        Spacer()
                        Text("UNFORCED ERROR")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Spacer()
                    })
                    .edgesIgnoringSafeArea(.all)
                }.frame(height: 100, alignment: .center)
                .background(Color(.orange).cornerRadius(8))
            }

        }.padding(.horizontal)
    }
}
