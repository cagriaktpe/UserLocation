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
        Map(position: $vm.mapRegion) {
            UserAnnotation()
        }
        .tint(.red)
        .onAppear {
            vm.checkIfLocationServicesIsEnabled()
        }
    }
}

#Preview {
    ContentView()
}
