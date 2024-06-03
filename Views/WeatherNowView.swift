//
//  WeatherNowView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//  Edited by Khandakar Hossin w1785478

import SwiftUI
import CoreLocation
import MapKit


struct WeatherNowView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State private var isLoading = false
    @State private var temporaryCity = ""
    @State private var  alertText = ""
    @State private var showAlertText: Bool = false
    
    var body: some View {
        
        ZStack{
            Image("sky")
                .resizable()
                .edgesIgnoringSafeArea(.top)
                .opacity(0.5)
            VStack{
                HStack{
                    Text("Change Location")
                    
                    TextField("Enter New Location", text: $temporaryCity)
                        .onSubmit {
                            
                            let geoCoder = CLGeocoder()
                            geoCoder.geocodeAddressString(temporaryCity){placemarks, error in
                                if let _ = error{
                                    alertText = "Not a valid city name. Please enter a valid city name"
                                    showAlertText = true
                                    temporaryCity = ""
                                    return
                                }else if let placemarks = placemarks, !placemarks.isEmpty{
                                    weatherMapViewModel.city = temporaryCity.capitalized(with: Locale.current)
                                    
                                    
                                    
                                    
                                   
                                    Task {
                                        do {
                                            // write code to process user change of location
                                            
                                            try await weatherMapViewModel.getCoordinatesForCity()
                                            if let coordinates = weatherMapViewModel.coordinates {
                                                let weatherData = try await weatherMapViewModel.loadData(lat: coordinates.latitude, lon: coordinates.longitude)
                                                weatherMapViewModel.weatherDataModel = weatherData
                                                
                                                
                                            }
                                            isLoading = true
                                            temporaryCity = ""
                                            
                                        }catch {
                                            print("Error: \(error)")
                                            isLoading = false
                                        }
                                        
                                    }
                                }
                            }
                            
                        }
                   
                }
                .bold()
                .font(.system(size: 20))
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Arial", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)
                VStack{
                    HStack{
                        Text("Current Location: \(weatherMapViewModel.city)")
                    }
                    .bold()
                    .font(.system(size: 20))
                    .padding(10)
                    .shadow(color: .blue, radius: 10)
                    .cornerRadius(10)
                    .fixedSize()
                    .font(.custom("Arial", size: 26))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(15)
                    let timestamp = TimeInterval(weatherMapViewModel.weatherDataModel?.current.dt ?? 0)
                    let formattedDate = DateFormatterUtils.formattedDateTime(from: timestamp, timeOffset: weatherMapViewModel.weatherDataModel?.timezoneOffset ?? 0)
                    
                    Text(formattedDate)
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 1)
                    
                    Spacer().frame(height: 40)

                    
        
                        
                    
                    HStack{
                       
                        // Weather Icon
                        if let iconCode = weatherMapViewModel.weatherDataModel?.current.weather.first?.icon {
                            let urlString = weatherMapViewModel.iconURLString(for: iconCode)
                            if let url = URL(string: urlString) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .padding(.leading, 40)
                            }
                        }
                        
                        
                        //weather description value
                        var descriptionOfWeather: String{
                            weatherMapViewModel.weatherDataModel?.current.weather.first?.weatherDescription.rawValue ?? "N/A"
                            
                        }
                        //Spacer().frame(width: 20)
                        
                        Text(descriptionOfWeather.capitalized(with: Locale.current))
                            .font(.system(size: 25, weight: .medium))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //.padding([.leading, .top, .bottom])
                    .padding(10)
                    
                    HStack{
                        
                        //temparature icon
                        Image( "temperature")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32,height: 32)
                                .padding(.leading, 45)
                        
                        Spacer().frame(width: 20)
                        
                        // Weather Temperature Value
                        if let forecast = weatherMapViewModel.weatherDataModel {
                            Text("Temp: \((Double)(forecast.current.temp), specifier: "%.2f") ºC")
                                .font(.system(size: 25, weight: .medium))
                        } else {
                            Text("Temp: N/A")
                                .font(.system(size: 25, weight: .medium))
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //.padding([.leading, .top, .bottom])
                    .padding(10)
                    
                    HStack{
                        
                        //humidity icon
                        Image( "humidity")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32,height: 32)
                                .padding(.leading, 45)
                        
                        Spacer().frame(width: 20)
                       
                        // Weather humidity value
                        Text("Humidity: " +
                             String(weatherMapViewModel.weatherDataModel?.current.humidity ?? 0) + "%")
                        .font(.system(size: 25, weight: .medium))
                        
                       
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //.padding([.leading, .top, .bottom])
                    .padding(10)
                    
                    HStack{
                        
                        //pressure icon
                        Image( "pressure")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32,height: 32)
                                .padding(.leading, 45)
                       
                        Spacer().frame(width: 20)
                        
                        // Weather pressure value
                        Text("Pressure: " +
                             String(weatherMapViewModel.weatherDataModel?.current.pressure ?? 0) + " hPa")
                        .font(.system(size: 25, weight: .medium))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //.padding([.leading, .top, .bottom])
                    .padding(10)
                    
                    HStack{
                        
                        //windspeed icon
                        Image( "windSpeed")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32,height: 32)
                                .padding(.leading, 45)
                               
                       
                        Spacer().frame(width: 20)
                        
                        // Weather windspeed value
                        Text("Windspeed: " +
                             String(weatherMapViewModel.weatherDataModel?.current.windSpeed ?? 0) + " mph")
                        .font(.system(size: 25, weight: .medium))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //.padding([.leading, .top, .bottom])
                    .padding(10)
                    
                   // Spacer().frame(height: 80)
                    
                }//VS2
            }// VS1
            .alert(isPresented: $showAlertText) {
                Alert(
                    title: Text("Invalid Input"),
                    message: Text("\(alertText)"),
                    dismissButton: .default(Text("Try Again"))
                )
            }
        }
    }
}
struct WeatherNowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherNowView().environmentObject(WeatherMapViewModel())
    }
}
