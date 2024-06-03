//
//  CWK2TemplateApp.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI
import FirebaseCore

@main
struct CWK2TemplateApp: App {
    
    init(){
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
    }
    
    @StateObject var weatherMapViewModel = WeatherMapViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(weatherMapViewModel)
            
        }
    }
}
