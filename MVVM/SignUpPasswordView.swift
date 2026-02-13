//
//  MainView.swift
//  MVVM
//
//

import SwiftUI

struct SignUpPasswordView: View {
    
    @ObservedObject var viewModel: SignUpUsernameEmailViewModel
    

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            Text("Username")
                .font(.system(size: 15, weight: .semibold))
            Text(viewModel.username)
                .font(.system(size: 15, weight: .regular))
                .padding(.bottom)
            Text("Email")
                .font(.system(size: 15, weight: .semibold))
            Text(viewModel.email)
                .font(.system(size: 15, weight: .regular))
                .padding(.bottom)
            Text("Password")
                .font(.system(size: 15, weight: .semibold))
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            Text("Confirm Password")
                .font(.system(size: 15, weight: .semibold))
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            Button {
                
                viewModel.validatePassword()

            } label: {
                Text("Complete")
                    .foregroundStyle(.white)
                    .font(.system(size: 15, weight: .semibold))
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
            }
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(.top)
        }
        .navigationDestination(isPresented: $viewModel.showWelcomePage, destination: {
            WelcomePage()
        })
        .padding()
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button("OK", action: {
                if viewModel.password == viewModel.confirmPassword {
                    viewModel.showAlert = false
                    viewModel.showWelcomePage = true
                } else {
                    viewModel.showAlert = false
                }
            })
        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
}

#Preview {
    SignUpPasswordView(viewModel: SignUpUsernameEmailViewModel())
}
