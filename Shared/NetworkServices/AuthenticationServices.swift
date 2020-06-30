//
//  AuthenticationServices.swift
//  iOS
//
//  Created by James Meli on 6/30/20.
//

import Foundation
import Firebase

struct AuthenticationServices {
    
    static func createUser(withEmail email: String, andPassword password: String, completion: @escaping(_ error: Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                completion(error)
            } else {
                completion(nil)
            }
        }
        
    }
    
    static func signInUser(withEmail email: String, andPassword password: String, completion: @escaping(_ error: Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                completion(error)
            } else {
                completion(nil)
            }
        }
        
    }
    
    static func logOutUser() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Error logging out: \(error.localizedDescription)")
        }
    }
}
