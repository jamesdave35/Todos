//
//  SignUpTextField.swift
//  Todos
//
//  Created by James Meli on 6/29/20.
//

import SwiftUI

struct SignUpTextField: View {
    
    @Binding var textValue: String
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $textValue)
                .font(.system(size: 15, weight: .regular, design: .default))
                .accentColor(Color("todosPurple"))
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 15)
    }
}

struct SecureSignUpTextField: View {
    
    @Binding var textValue: String
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            SecureField(placeholder, text: $textValue)
                .font(.system(size: 15, weight: .regular, design: .default))
                .accentColor(Color("todosPurple"))
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 15)
    }
}

struct SignUpTextField_Previews: PreviewProvider {
    static var previews: some View {
        SignUpTextField(textValue: .constant("test1@gmail.com"), placeholder: "Email Address")
    }
}
