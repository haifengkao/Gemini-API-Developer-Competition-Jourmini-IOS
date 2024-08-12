//
//  DailyItineraryView.swift
//  GTravel
//
//  Created by Lono on 2024/8/12.
//

import Foundation
import GoogleMaps
import SwiftUI

struct DailyItineraryView: View {
    let itinerary: DailyItinerary
    @State private var coordinates: [CLLocationCoordinate2D] = []
    @State private var routes: [Routes] = []

    var body: some View {
        VStack {
            RouteMapView(coordinates: $coordinates, routes: $routes)

        }
        .onAppear {
            updateMapCoordinates()
        }
    }

    private func updateMapCoordinates() {
        coordinates = itinerary.places.map { place in
            CLLocationCoordinate2D(latitude: place.placeCoordinates.latitude,
                                   longitude: place.placeCoordinates.longitude)
        }

        // If there are at least two places, request a route
        if coordinates.count >= 2 {
            let direction = Direction(from: coordinates[0], to: coordinates[1], alternative: true, mode: .driving)
            direction.detectRoute { route in
                if let newRoutes = route.routes as? [Routes] {
                    self.routes = newRoutes
                }
            } failure: { error in
                print("Error fetching route: \(error)")
            }
        }
    }
}

struct DailyItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        DailyItineraryView(itinerary: googleTraffic[0])
    }
}
