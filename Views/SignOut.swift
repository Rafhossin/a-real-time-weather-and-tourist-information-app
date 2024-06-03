//
//  SignOut.swift
//  CWK2Template
//
//  Created by khandakar hossin on 25/12/2023.
//  Knowledge gathered from Lecture, Google and Youtube contents

import SwiftUI
import FirebaseAuth




struct SignOut: View {
    @AppStorage("uid") var userId: String = ""
    
    var body: some View {
        
        ZStack{
            Image("sky")
                .resizable()
                .edgesIgnoringSafeArea(.top)
                .opacity(0.5)
            
            Button("Sign Out") {
                do {
                    try Auth.auth().signOut()
                    withAnimation {
                        userId = "" // This will trigger the view switch in ContentView
                    }
                } catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                }
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal)
        }
    }
    
}
