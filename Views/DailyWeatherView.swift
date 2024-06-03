//
//  DailyWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//  Edited by Khandakar Hossin w1785478

import SwiftUI

struct DailyWeatherView: View {
    
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    var day: Daily
    
    // Computed property to format the temperature values
       var formattedTemperatures: String {
           let formatter = NumberFormatter()
           formatter.maximumFractionDigits = 0 // this will round to the nearest whole number
           let maxTempString = formatter.string(from: NSNumber(value: day.temp.max)) ?? ""
           let minTempString = formatter.string(from: NSNumber(value: day.temp.min)) ?? ""
           return "\(maxTempString)ºC/\(minTempString)ºC"
       }
    
    var body: some View {
        
        HStack{
            // Weather Icon
            if let iconCode = day.weather.first?.icon {
                let urlString = weatherMapViewModel.iconURLString(for: iconCode)
                if let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    
                }
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 5){
                
                //weather description value
                var descriptionOfWeather: String{
                    day.weather.first?.weatherDescription.rawValue ?? "N/A"
                    
                }
                //Spacer().frame(width: 20)
                
                Text(descriptionOfWeather.capitalized(with: Locale.current))
                    .font(.system(size: 14, weight: .medium))
                
                
                
                let formattedDate = DateFormatterUtils.formattedDateWithWeekdayAndDay(from: TimeInterval(day.dt))
                Text(formattedDate)
                    .font(.system(size: 14, weight: .medium))
                   
            }.frame(minWidth: 0,maxWidth: .infinity,alignment: .center)
            
            Spacer()
            
            let forecastMax = day.temp.max
            let forecastMin = day.temp.min
            
            Text("\(String(Int(forecastMax.rounded())))ºC/\(String(Int(forecastMin.rounded()))) ºC ")
        
                .font(.system(size: 14, weight:.medium))
                .padding(.horizontal)
                
            
        }
    }
}


struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        if let day = WeatherMapViewModel().weatherDataModel?.daily.first {
            DailyWeatherView(day: day)
        } else {
            Text("Preview data not available")
        }
    }
}

