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
    
    var body: some View {
        MapReader { reader in
            Map(position: $vm.mapRegion) {
                UserAnnotation()
            }
            .tint(.red)
            .onAppear {
                vm.checkIfLocationServicesIsEnabled()
            }
            .overlay {
                VStack {
                    Spacer()
                    HStack {
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
            .onMapCameraChange { context in
                // get center coordinate of the map
                print(context.camera)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
