//
//  SignupView.swift
//  CWK2Template
//
//  Created by khandakar hossin on 24/12/2023.
//  Knowledge gathered from Lecture, Google and Youtube contents

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @Binding var showingCurrentView: String
    @AppStorage("uid") var userId:String = ""
    
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Text("Create an Account!")
                        .foregroundColor(.white)
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
                              text: $userEmail)
                    
                    Spacer()
                    if(userEmail.count != 0){
                        
                        Image(systemName: userEmail.isEmailAddressValid() ?  "checkmark": "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(userEmail.isEmailAddressValid() ? .green : .red)
                    }

                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                   RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white)
                
                )
                .padding()
                
                
                
                HStack{
                    Image(systemName: "lock")
                    //using SecureField instead of TextField for password input to hide the password characters as the user types.
                    SecureField("Password", text: $userPassword)
                    
                    Spacer()
                    
                    // Password validation
                        if userPassword.count != 0 {
                            Image(systemName: userPassword.isPasswordValid() ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundColor(userPassword.isPasswordValid() ? .green : .red)
                        }
                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                   RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white)
                
                )
                .padding()
                Button(action: {
                    self.showingCurrentView = "login"
                    
                }, label: {
                    Text("Already have an account")
                        .foregroundColor(.gray.opacity(0.8))
                })
                
                Spacer()
                Spacer()
                
                Button(action: {
                    Auth.auth().createUser(withEmail: userEmail, password: userPassword){ authResult, error in
                        if let error = error {
                                    self.alertMessage = "Sign up failed: \(error.localizedDescription)"
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
                    Text("Create New Account")
                        .foregroundColor(.black)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding()
                    
                        .background(
                            RoundedRectangle(cornerRadius: 11)
                                .fill(Color.white)
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
