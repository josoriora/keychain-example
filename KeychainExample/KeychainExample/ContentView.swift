//
//  ContentView.swift
//  KeychainExample
//
//  Created by JULIAN OSORIO RAMIREZ on 26/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var storedUsername: String = ""
    @State private var storedPassword: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Keychain Example")
                .font(.largeTitle)
                .padding()

            // Input fields
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Save Button
            Button("Save to Keychain") {
                let saved = KeychainHelper.shared.save(key: "username", value: username)
                if saved {
                    let passwordSaved = KeychainHelper.shared.save(key: "password", value: password)
                    if passwordSaved {
                        print("Data saved to Keychain!")
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            // Retrieve Button
            Button("Retrieve from Keychain") {
                if let storedUser = KeychainHelper.shared.retrieve(key: "username"),
                   let storedPass = KeychainHelper.shared.retrieve(key: "password") {
                    storedUsername = storedUser
                    storedPassword = storedPass
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)

            // Display stored data
            VStack {
                Text("Stored Username: \(storedUsername)")
                Text("Stored Password: \(storedPassword)")
            }
            .padding()

            // Delete Button
            Button("Delete from Keychain") {
                let deletedUser = KeychainHelper.shared.delete(key: "username")
                let deletedPass = KeychainHelper.shared.delete(key: "password")
                if deletedUser && deletedPass {
                    storedUsername = ""
                    storedPassword = ""
                    print("Data deleted from Keychain!")
                }
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
