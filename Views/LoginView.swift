//
//  LoginView.swift
//  CWK2Template
//
//  Created by khandakar hossin on 24/12/2023.

//  Knowledge gathered from Lecture, Google and Youtube contents

// User Credential:
//       userEmail = krhossin@yahoo.co.uk
//       userPassword = Ib1422895165@

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var showingCurrentView: String
    @AppStorage("uid") var userId:String = ""
    
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Text("Welcome Back!")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                //validation
                
                HStack{
                    Image(systemName: "mail")
                    TextField("Email",
                              text: $userEmail) // userEmail = krhossin@yahoo.co.uk
                    
                    Spacer()
                    // Email validation
                    if(userEmail.count != 0){
                        
                        Image(systemName: userEmail.isEmailAddressValid() ?  "checkmark": "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(userEmail.isEmailAddressValid() ? .green : .red)
                    }

                }
                .padding()
                .overlay(
                   RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                
                )
                .padding()
                
                
                
                HStack{
                    Image(systemName: "lock")
                    //using SecureField instead of TextField for password input to hide the password characters as the user types.
                    SecureField("Password", text: $userPassword) // userPassword = Ib1422895165@
                    
                    Spacer()
                    
                    // Password validation
                        if userPassword.count != 0 {
                            Image(systemName: userPassword.isPasswordValid() ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundColor(userPassword.isPasswordValid() ? .green : .red)
                        }
                }
                .padding()
                .overlay(
                   RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                
                )
                .padding()
                Button(action: {
                    withAnimation{
                        self.showingCurrentView = "signup"
                    }
                    
                }, label: {
                    Text("Don't have an account")
                        .foregroundColor(.black.opacity(0.8))
                })
                
                Spacer()
                Spacer()
                
                Button(action: {
                    //When an user signs in to the app, passing the user's email address and password to signIn
                    Auth.auth().signIn(withEmail: userEmail, password: userPassword) {authResult, error in
                      
                        if let error = error {
                                    self.alertMessage = "Sign in failed: \(error.localizedDescription)"
                                    self.showingAlert = true
                                    print(error)
                                    return
                                }
                                if let authResult = authResult {
                                    print(authResult.user.uid)
                                    withAnimation {
                                        userId = authResult.user.uid
                                    }
                                } else {
                                    // Handle the case where authResult is nil but there's no error
                                    self.alertMessage = "Unknown error occurred"
                                    self.showingAlert = true
                                }
                    }
                   
                    
                }, label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding()
                    
                        .background(
                            RoundedRectangle(cornerRadius: 11)
                                .fill(Color.black)
                        )
                        .padding(.horizontal)
                })
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

