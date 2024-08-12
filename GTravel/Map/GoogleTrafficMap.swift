//
//  GoogleTrafficMap.swift
//  GTravel
//
//  Created by Lono on 2024/8/11.
//

import Foundation
import GoogleMaps
import SwiftUI

struct GoogleTrafficView: View {
    let googleTraffic: [DailyItinerary]

    var body: some View {
        TabView {
            ForEach(Array(googleTraffic.enumerated()), id: \.offset) { index, itinerary in
                DailyItineraryView(itinerary: itinerary)
                    .tabItem {
                        Text("Day \(index + 1)")
                    }
            }
        }
        .preferredColorScheme(.dark)
        // .tabViewStyle(PageTabViewStyle())
        // .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct GoogleTrafficView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleTrafficView(googleTraffic: googleTraffic)
    }
}
