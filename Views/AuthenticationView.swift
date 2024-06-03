//
//  AuthenticationView.swift
//  CWK2Template
//
//  Created by khandakar hossin on 24/12/2023.
//  Knowledge gathered from Lecture, Google and Youtube contents

// User Credential:
//       userEmail = krhossin@yahoo.co.uk
//       userPassword = Ib1422895165@

import SwiftUI

struct AuthenticationView: View {
    @State private var showingCurrentView: String = "login" // login or signup
    var body: some View {
        if(showingCurrentView == "login"){
            LoginView(showingCurrentView: $showingCurrentView)
                .preferredColorScheme(.light)
        }else{
            SignupView(showingCurrentView: $showingCurrentView)
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .transition(.move(edge: .bottom))
        }
    }
}


