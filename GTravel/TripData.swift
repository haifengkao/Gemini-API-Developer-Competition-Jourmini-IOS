//
//  TripData.swift
//  GTravel
//
//  Created by Lono on 2024/8/12.
//

import Foundation

import SwiftUI

struct TripData: Identifiable {
    let id = UUID()
    let startPoint: String
    let endPoint: String
    let distance: Double
    let carEmission: Int
    let busEmission: Int
    let motorcycleEmission: Int
    let walkEmission: Int
    let bikeEmission: Int
}

struct TripDataView: View {
    static let tripData: [TripData] = [
        TripData(startPoint: "Tainan Train Station", endPoint: "Anping Old Fort", distance: 6.1, carEmission: 1120, busEmission: 90, motorcycleEmission: 367, walkEmission: 0, bikeEmission: 0),
        TripData(startPoint: "Anping Old Fort", endPoint: "Hayashi Department Store", distance: 4.8, carEmission: 880, busEmission: 70, motorcycleEmission: 367, walkEmission: 0, bikeEmission: 0),
        TripData(startPoint: "Hayashi Department Store", endPoint: "Anping Canal", distance: 3.1, carEmission: 570, busEmission: 40, motorcycleEmission: 251, walkEmission: 0, bikeEmission: 0),
        TripData(startPoint: "Anping Canal", endPoint: "Tainan Train Station", distance: 4.5, carEmission: 830, busEmission: 60, motorcycleEmission: 135, walkEmission: 0, bikeEmission: 0)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Carbon Footprint Analysis:")
                .font(.headline)
            
            Table(TripDataView.tripData) {
                TableColumn("Start") { data in
                    Text(data.startPoint)
                    
                }
                TableColumn("End") { data in
                    Text(data.endPoint)
                       
                }
                TableColumn("Distance(km)") { data in
                    Text(String(format: "%.3f", data.distance))
                        
                }
                TableColumn("Car(g)") { data in
                    Text("\(data.carEmission)")
                }
                TableColumn("Bus(g)") { data in
                    Text("\(data.busEmission)")
                }
                TableColumn("Motorcycle(g)") { data in
                    Text("\(data.motorcycleEmission)")
                }
               
            }.font(.footnote)
            .frame(height: 300)
        }
        .preferredColorScheme(.dark)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct TripDataView_Previews: PreviewProvider {
    static var previews: some View {
        TripDataView()
            .preferredColorScheme(.dark)
            .background(Color.black)
    }
}
