//
//  WelcomeView.swift
//  iOS
//
//  Created by James Meli on 6/29/20.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var showSignUpView = false
    @State private var showLoginView = false
    
    var body: some View {
        VStack {
            VStack(spacing: 40.0) {
                VStack(alignment: .leading) {
                    Text("todos")
                        .font(.custom("Cookie-Regular", size: 90))
                        .foregroundColor(Color("todosPurple"))
                    Text("To help you manage and organize tasks")
                        .foregroundColor(.primary)
                        .font(.title2)
                        
                }
                .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                VStack {
                    VStack {
                        Image("welcomeImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 20, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text("Create your todos and set reminders")
                            .foregroundColor(.secondary)
                            .font(.body)
                    }
                    Spacer()
                    HStack(spacing: 30.0) {
                        Button(action: {
                            self.showSignUpView.toggle()
                        }, label: {
                            Text("SIGN UP")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .frame(width: 120, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color("todosPurple"))
                                .clipShape(RoundedRectangle(cornerRadius: 30, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                        })
                        .fullScreenCover(isPresented: $showSignUpView) {
                            CreateAccountView(presentSignUpView: $showSignUpView)
                        }
                        
                        Button(action: {
                            self.showLoginView.toggle()
                        }, label: {
                            Text("LOG IN")
                                .foregroundColor(.primary)
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .frame(width: 120, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color("secondaryBackground"))
                                .clipShape(RoundedRectangle(cornerRadius: 30, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                        })
                        .fullScreenCover(isPresented: $showLoginView) {
                            LoginView(presentLoginView: $showLoginView)
                        }
                    }
                }
                .padding(.bottom, 70)
            }

            
            Spacer()
            

        }
        .padding(.top, 60)
        .edgesIgnoringSafeArea(.all)
        .background(Color("alternatePrimaryBackground"))



        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .preferredColorScheme(.light)
            .previewLayout(.device)
    }
}
