//
//  ContentView.swift
//  UserLocation
//
//  Created by Samet Çağrı Aktepe on 8.03.2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var vm = ContentViewModel()
    
    @State var selectedCoordinate: CLLocationCoordinate2D?
    
    var body: some View {
        MapReader { reader in
            Map(position: $vm.mapRegion) {
                UserAnnotation()
                
                Annotation("", coordinate: vm.selectedCoordinate ?? MapDetails.startingLocation) {
                        Circle()
                            .fill(.red)
                            .frame(width: 10, height: 10)
                    }
                
            
            }
            .tint(.red)
            .onAppear {
                vm.checkIfLocationServicesIsEnabled()
            }
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            vm.selectedCoordinate = selectedCoordinate
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                        }
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 10)
                        .padding()

                        Spacer()
                        Button {
                            vm.setUserLocation()
                        } label: {
                            Image(systemName: "location")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                        }
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 10)
                        .padding()
                    }
                    
                }
            }
            .overlay {
                // a square for getting coordinate of the center of the screen
                Image(systemName: "scope")
                    .resizable()
                    .foregroundStyle(.red)
                    .frame(width: 30, height: 30)
            }
            .onMapCameraChange { context in
                // get center coordinate of the map
                selectedCoordinate = context.camera.centerCoordinate
               
            }
        }
        
    }
}

#Preview {
    ContentView()
}
