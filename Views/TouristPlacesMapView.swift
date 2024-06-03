//
//  TouristPlacesMapView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//  Edited by Khandakar Hossin w1785478

import Foundation
import SwiftUI
import CoreLocation
import MapKit

struct TouristPlacesMapView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State var locations: [Location] = []
    @State var  mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5216871, longitude: -0.1391574), latitudinalMeters: 600, longitudinalMeters: 600)
    
    @State private var locationSeleted: Location?
    @State private var isShowingDetails = false
  
    // Computed property to filter locations by the current city
    var filteredLocations: [Location] {
        locations.filter { $0.cityName == weatherMapViewModel.city }
    }
    
    //A custom binding, sheetBindingViewForAttraction, has been implemented to control the presentation of a sheet view.
    var sheetBindingViewForAttraction: Binding<Bool>{
        Binding(
            get: {self.isShowingDetails},
            set: {
                
                self.isShowingDetails = $0
                if !$0{
                    self.locationSeleted = nil
                }
            }
        
        )
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                if weatherMapViewModel.coordinates != nil {
                    VStack(spacing: 10){
                        //setting up a map region of a location with annotation items(tourist places)
                        Map(coordinateRegion: $mapRegion, showsUserLocation: true, annotationItems:locations){
                            location in MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude), tint: Color.red)
                        }
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 400)
                        
                        
                        Text("Tourist Attractions in \(weatherMapViewModel.city)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding()
                        
                        
                        
                    }
                }
                // List of tourist places
                List{
                    if filteredLocations.isEmpty{
                        
                        Text("List of tourist attractions has not been included yet")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .listRowSeparator(.hidden)
                            .frame(minWidth: 0,maxWidth:.infinity, alignment:.center )
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            //.padding()
                            //.listRowInsets(EdgeInsets())
                        
                    } else{
                        
                        ForEach(filteredLocations) { location in
                            HStack{
                               
                                Image(location.imageNames.first ?? "placeholder")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipped()
                                    .cornerRadius(5)
                                
                                Text(location.name)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                
                                
                            }
                            .listRowSeparator(.hidden)
                            .frame(minWidth: 0,maxWidth:.infinity, alignment:.leading )
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding()
                            .listRowInsets(EdgeInsets())
                            .onTapGesture {
                                
                                self.locationSeleted = location
                                self.isShowingDetails = true
                                
                                
                            }
                            
                        }
                       }
                    }
                        .listStyle(PlainListStyle())
                 //.padding()
            }
            .sheet(isPresented: sheetBindingViewForAttraction) {
                if let locationSeleted = locationSeleted{
                    TouristAttractionView(touristPlace: locationSeleted,isPresented: $isShowingDetails)
                }
            }
            //.frame(height:700)
           
            
        }
        .onAppear {
            // process the loading of tourist places
            
            mapRegion.center = weatherMapViewModel.coordinates ??  mapRegion.center
            
            locations =  weatherMapViewModel.annotations
            
            
        }
    }
}

struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView().environmentObject(WeatherMapViewModel())
    }
}
