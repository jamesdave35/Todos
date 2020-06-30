//
//  CreateAccountView.swift
//  Todos
//
//  Created by James Meli on 6/29/20.
//

import SwiftUI

struct CreateAccountView: View {
    
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State private var emailAddress = ""
    @State private var password = ""
    @State private var showTaskListView = false
    @Binding var presentSignUpView: Bool
    
    var body: some View {
        VStack {
            VStack(spacing: 20.0) {
                HStack {
                    VStack(alignment: .leading, spacing: 30.0) {
                        Image(systemName: "xmark")
                            .font(.system(size: 23, weight: .regular, design: .default))
                            .foregroundColor(.primary)
                            .padding(.top, 50)
                            .onTapGesture {
                                presentSignUpView.toggle()
                            }
                        Text("Create an account")
                            .foregroundColor(.primary)
                            .font(.system(size: 30, weight: .bold, design: .default))
                        
                    }
                    
                    
                    Spacer()
                }
                .padding(.leading, 20)
                
                ScrollView {
                    VStack(spacing: 40) {
                        VStack(spacing: 18.0) {
                            SignUpTextField(textValue: $emailAddress, placeholder: "Email address")
                                .frame(height: 55)
                                .background(Color("textFieldBackground"))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                            SecureSignUpTextField(textValue: $password, placeholder: "Password")
                                .frame(height: 55)
                                .background(Color("textFieldBackground"))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                        }
                        
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                createUser()
                            }, label: {
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .regular, design: .default))
                                    .frame(width: 65, height: 65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color("todosPurple"))
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 3, y: 4)
                            })
                        }
                        .padding(.trailing, 20)
                    }
                    
 
                    


                }
                .padding(.vertical, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                
            }

        }
        .frame(maxWidth: .infinity)
        .background(Color("alternatePrimaryBackground"))
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showTaskListView) {
            TaskListView().environmentObject(TaskStore())
        }
    }
    
    func createUser() {
        AuthenticationServices.createUser(withEmail: emailAddress, andPassword: password) { (error) in
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            } else {
                isLoggedIn = true
                showTaskListView.toggle()
                
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView(presentSignUpView: .constant(true))
            .preferredColorScheme(.light)
    }
}
