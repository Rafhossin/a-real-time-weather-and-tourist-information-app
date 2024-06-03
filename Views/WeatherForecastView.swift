
//  WeatherForcastView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//  Edited by Khandakar Hossin w1785478


import SwiftUI

struct WeatherForecastView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Toolbar content
                    HStack {
                        Image(systemName: "sun.min.fill")
                          
                        VStack {
                            Text("Weather Forecast for \(weatherMapViewModel.city)")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                    }
                    
                    // Hourly data ScrollView
                    if let hourlyData = weatherMapViewModel.weatherDataModel?.hourly {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 6) {
                                ForEach(hourlyData) { hour in
                                    HourWeatherView(current: hour).frame(width: 200)
                                       
                                }.frame(width: 104, height: 102)
                                    .padding().background(Color.teal)
                                    .cornerRadius(5)
                                    
                            }
                            .padding(.horizontal, -10)
                        }
                        .frame(height: 180)
                    }
                }.padding(.horizontal, 16).padding(.top,40).frame( height: 340).background(Color.blue.opacity(0.3))
                    
                Divider()
                        .padding(.horizontal, 16)
                        .padding(.vertical, 2)
                    // Daily data List
                    List {
                        ForEach(weatherMapViewModel.weatherDataModel?.daily ?? []) { day in
                            DailyWeatherView(day: day)
                                .background(
                                    Image("background")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .scaledToFill()
                                        .opacity(0.2)
                                )
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .frame(height: 500)
            }// Set the background color for the ScrollView
            .ignoresSafeArea(edges: .all) // Extend the background to the safe area
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct WeatherForecastView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherForecastView().environmentObject(WeatherMapViewModel())
    }
}
