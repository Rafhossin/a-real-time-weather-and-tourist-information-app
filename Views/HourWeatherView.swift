//
//  HourWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct HourWeatherView: View {
    
    var current: Current
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel


    var body: some View {
        let formattedDate = DateFormatterUtils.formattedDateWithDay(from: TimeInterval(current.dt))
       
            VStack(alignment: .center, spacing: 5) {
                Text(formattedDate)
                    .font(.system(size: 13, weight: .medium))
                
                    .padding(.horizontal)
                //.background(Color.white)
                    .foregroundColor(.black)
                
                
                // Weather Icon
                if let iconCode = current.weather.first?.icon {
                    let urlString = weatherMapViewModel.iconURLString(for: iconCode)
                    if let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                    }
                }
                
                // Weather Temperature Value
                let forecast = current.temp
                Text("\(String(Int(forecast.rounded())))ºC ")
                    .font(.system(size: 13, weight: .medium))
                    .padding(.horizontal)
                
                
                
                
                
                
                //weather description value
                var descriptionOfWeather: String{
                    current.weather.first?.weatherDescription.rawValue ?? "N/A"
                    
                }
                
                
                Text(descriptionOfWeather.capitalized(with: Locale.current))
                    .font(.system(size: 13, weight: .medium))
                    .padding(.horizontal)
            }
            
    

    }
}




