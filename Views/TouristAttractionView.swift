//
//  TouristAttractionView.swift
//  CWK2Template
//
//  Created by khandakar hossin on 05/12/2023.
//



import SwiftUI
import CoreLocation
import MapKit


struct TouristAttractionView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    
    @State var  mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5216871, longitude: -0.1391574), latitudinalMeters: 600, longitudinalMeters: 600)
    
    var  touristPlace : Location
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    ScrollView(.horizontal){
                    
                        HStack{
                            ForEach(touristPlace.imageNames, id: \.self) { image in
                                // if let imageName = location.imageNames.first {
                                Image(image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 300, height: 250)
                                    .clipped()
                                    .cornerRadius(5)
                            }
                        }
                        .padding()
                        
                       
                        
                        
                        Spacer()
                        
                       
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    
                    
                    Text(touristPlace.name)
                              .font(.headline)
                              .padding()
                    
                    Text(touristPlace.description)
                              .font(.subheadline)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("Dismiss") {
                                        // Dismiss the sheet when the dismiss button is tapped
                                        isPresented = false
                                    }
                                }
                            }
                .onAppear{
                    mapRegion.center = touristPlace.coordinates
                }
                
                .navigationTitle(touristPlace.cityName)
                .padding()
                
                //link to the wikipedia.com for further information about a tourist place
                Link(destination: URL(string: touristPlace.link) ?? URL(string: "https://www.wikipedia.com")!){
                    Text("Link to Wikipedia")
                        
                }
                
                //setting up a map region with annotaion of tourist location
                Map(coordinateRegion: $mapRegion, showsUserLocation: true, annotationItems:[touristPlace]){
                    location in MapMarker(coordinate: CLLocationCoordinate2D(latitude: touristPlace.coordinates.latitude, longitude: touristPlace.coordinates.longitude), tint: Color.red)
                }
                .edgesIgnoringSafeArea(.all)
                .frame(height: 300)
                .padding(.top)
               
                
             
                
                    
                
            }
        }
    }
}
