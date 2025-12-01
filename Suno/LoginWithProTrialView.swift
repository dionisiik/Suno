//
//  LoginWithProTrialView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct LoginWithProTrialView: View {
    @EnvironmentObject var appState: AppState
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var showPassword = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
            VStack(spacing: 0) {
                // Logo
                VStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: "music.note")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    }
                    
                    Text("Welcome to SunoSongAI")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Create stunning AI-generated music in seconds")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)
                .padding(.bottom, 40)
                
                // Login Form
                VStack(spacing: 20) {
                    Text("Sign in to continue")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Continue with Apple
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "apple.logo")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                            
                            Text("Continue with Apple")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                    }
                    
                    // Or separator
                    HStack {
                        Rectangle()
                            .fill(Color(white: 0.8))
                            .frame(height: 1)
                        
                        Text("or")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 12)
                        
                        Rectangle()
                            .fill(Color(white: 0.8))
                            .frame(height: 1)
                    }
                    .padding(.vertical, 8)
                    
                    // Email Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email Address")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                                .frame(width: 20)
                            
                            TextField("you@example.com", text: $email)
                                .textFieldStyle(PlainTextFieldStyle())
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                        }
                        .padding()
                        .background(Color(white: 0.95))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(white: 0.8), lineWidth: 1)
                        )
                    }
                    
                    // Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.gray)
                                .frame(width: 20)
                            
                            if showPassword {
                                TextField("Enter your password", text: $password)
                                    .textFieldStyle(PlainTextFieldStyle())
                            } else {
                                SecureField("Enter your password", text: $password)
                                    .textFieldStyle(PlainTextFieldStyle())
                            }
                            
                            Button(action: { showPassword.toggle() }) {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                            }
                        }
                        .padding()
                        .background(Color(white: 0.95))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(white: 0.8), lineWidth: 1)
                        )
                    }
                    
                    // Remember Me & Forgot Password
                    HStack {
                        Button(action: { rememberMe.toggle() }) {
                            HStack(spacing: 8) {
                                Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                                    .foregroundColor(rememberMe ? Color(red: 1.0, green: 0.2, blue: 0.5) : Color(white: 0.8))
                                    .font(.system(size: 18))
                                
                                Text("Remember me")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("Forgot password?")
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 1.0, green: 0.2, blue: 0.5))
                        }
                    }
                    
                    // Error Message
                    if showError {
                        Text(errorMessage)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Sign In Button
                    Button(action: {
                        handleSignIn()
                    }) {
                        Text("Sign In")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color(red: 1.0, green: 0.5, blue: 0.0), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                    }
                    .padding(.top, 8)
                    .disabled(email.isEmpty || password.isEmpty)
                    .opacity(email.isEmpty || password.isEmpty ? 0.6 : 1.0)
                    
                    // Sign Up Link
                    NavigationLink(destination: LoginView().environmentObject(appState)) {
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            Text("Sign up for free")
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 1.0, green: 0.2, blue: 0.5))
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
                
                // Pro Free Trial Section
                VStack(spacing: 20) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: "crown.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                    
                    Text("Try Pro Free for 3 Days")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Unlock all features with no commitment")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ProFeatureRow(
                            icon: "bolt.fill",
                            text: "Instant generation - skip the queue",
                            color: Color(red: 1.0, green: 0.5, blue: 0.0)
                        )
                        
                        ProFeatureRow(
                            icon: "headphones",
                            text: "Studio-quality audio output",
                            color: Color(red: 0.6, green: 0.2, blue: 1.0)
                        )
                        
                        ProFeatureRow(
                            icon: "questionmark.circle",
                            text: "No watermarks on your creations",
                            color: Color(red: 1.0, green: 0.4, blue: 0.6)
                        )
                        
                        ProFeatureRow(
                            icon: "infinity",
                            text: "Unlimited daily generations",
                            color: Color(red: 0.2, green: 0.6, blue: 1.0)
                        )
                    }
                    .padding(.top, 8)
                }
                .padding(24)
                .background(Color(red: 0.98, green: 0.95, blue: 1.0))
                .cornerRadius(20)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
                
                // Footer Links
                HStack(spacing: 8) {
                    Button(action: {}) {
                        Text("Privacy Policy")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Text("•")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Button(action: {}) {
                        Text("Terms of Service")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Text("•")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Button(action: {}) {
                        Text("Help Center")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.bottom, 40)
            }
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
    }
    
    private func handleSignIn() {
        guard !email.isEmpty && !password.isEmpty else {
            showError = true
            errorMessage = "Please enter email and password"
            return
        }
        
        if appState.login(email: email, password: password) {
            showError = false
            // Navigation will happen automatically via appState.isAuthenticated
        } else {
            showError = true
            errorMessage = "Invalid email or password"
        }
    }
}

struct ProFeatureRow: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 20))
                .frame(width: 24)
            
            Text(text)
                .font(.system(size: 15))
                .foregroundColor(.black)
            
            Spacer()
        }
    }
}

#Preview {
    LoginWithProTrialView()
}

