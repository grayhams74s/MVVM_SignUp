//
//  ContentView.swift
//  MVVM
//
//

import SwiftUI

struct SignUpUsernameEmailView: View {
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var showNextPage = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading,spacing: 10) {
                Text("Username")
                    .font(.system(size: 15, weight: .semibold))
                TextField("Username", text: $username)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                Text("Email")
                    .font(.system(size: 15, weight: .semibold))
                TextField("Email", text: $email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                Button {
                    guard !username.isEmpty else {
                        alertTitle = "Username Required"
                        alertMessage = "Please provide a username"
                        showAlert = true
                        return
                    }
                    guard !email.isEmpty else {
                        alertTitle = "Email Required"
                        alertMessage = "Please provide a email"
                        showAlert = true
                        return
                    }
                    showNextPage = true
                } label: {
                    Text("Next")
                        .foregroundStyle(.white)
                        .font(.system(size: 15, weight: .semibold))
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                }
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.top)
            }
            .navigationDestination(isPresented: $showNextPage, destination: {
                
            })
            .padding()
        }
    }
}

#Preview {
    SignUpUsernameEmailView()
}
