//
//  SignUpUsernameEmailView.swift
//  MVVM
//
//  Redesigned for improved UI while keeping logic intact.
//

import SwiftUI

struct SignUpUsernameEmailView: View {
    @StateObject private var viewModel = SignUpUsernameEmailViewModel()
    @FocusState private var focusedField: Field?

    enum Field { case username, email }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        header
                        formCard
                        primaryButton
                        termsText
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 24)
                }
            }
            .navigationTitle("Create account")
            .navigationBarTitleDisplayMode(.inline)
            .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.alertMessage)
            }
            .navigationDestination(isPresented: $viewModel.showNextPage) {
                SignUpPasswordStepView(viewModel: viewModel)
            }
        }
    }

    private var header: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.crop.circle.badge.plus")
                .font(.system(size: 56))
                .foregroundStyle(.tint)
            Text("Let’s get you set up")
                .font(.title2).bold()
                .multilineTextAlignment(.center)
            Text("Create your username and enter your email to continue.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 8)
    }

    private var formCard: some View {
        VStack(spacing: 16) {
            LabeledContent("Username") {
                HStack(spacing: 10) {
                    Image(systemName: "at")
                        .foregroundStyle(.secondary)
                    TextField("Your username", text: $viewModel.username)
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($focusedField, equals: .username)
                }
                .padding(12)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            }

            LabeledContent("Email") {
                HStack(spacing: 10) {
                    Image(systemName: "envelope.fill")
                        .foregroundStyle(.secondary)
                    TextField("name@example.com", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($focusedField, equals: .email)
                }
                .padding(12)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
        .padding(16)
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.black.opacity(0.06), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 6)
    }

    private var primaryButton: some View {
        Button(action: {
            viewModel.validate()
        }) {
            HStack {
                Spacer()
                Text("Next")
                    .font(.headline)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color.accentColor)
            )
            .shadow(color: Color.accentColor.opacity(0.25), radius: 8, x: 0, y: 6)
        }
        .buttonStyle(.plain)
        .padding(.top, 4)
    }

    private var termsText: some View {
        Text("By continuing, you agree to our Terms and Privacy Policy.")
            .font(.footnote)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 8)
    }
}

struct SignUpPasswordStepView: View {
    @ObservedObject var viewModel: SignUpUsernameEmailViewModel
    @FocusState private var focused: Bool

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "lock.circle.fill")
                .font(.system(size: 48))
                .foregroundStyle(.tint)

            SecureField("Password", text: $viewModel.password)
                .textContentType(.newPassword)
                .focused($focused)
                .padding(12)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))

            SecureField("Confirm password", text: $viewModel.confirmPassword)
                .textContentType(.newPassword)
                .padding(12)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))

            Button("Finish") {
                
                viewModel.validatePassword()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationDestination(isPresented: $viewModel.showWelcomePage, destination: {
            WelcomePage()
        })
        .padding()
        .navigationTitle("Create password")
        .navigationBarTitleDisplayMode(.inline)
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button("OK", action: {
                if viewModel.password == viewModel.confirmPassword {
                    if !viewModel.password.isEmpty && !viewModel.confirmPassword.isEmpty {
                        viewModel.showAlert = false
                        viewModel.showWelcomePage = true
                    }
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
    SignUpUsernameEmailView()
}
