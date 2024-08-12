//
//  RouteMapView.swift
//  GTravel
//
//  Created by Lono on 2024/8/11.
//

import GoogleMaps
import SwiftUI

struct RouteMapView: UIViewRepresentable {
    @Binding var coordinates: [CLLocationCoordinate2D]
    @Binding var routes: [Routes]

    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: 37.384224917595063,
                                              longitude: -122.03266438096762,
                                              zoom: 13.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context _: Context) {
        uiView.clear()

        // Add markers for coordinates
        for coordinate in coordinates {
            let marker = GMSMarker(position: coordinate)
            marker.map = uiView
        }

        // Add route overlay
        for route in routes {
            if let points = route.overviewPolyline?.points {
                uiView.addOverlay(path: points)
            }
        }

        // Fit map to show all markers and route
        if !coordinates.isEmpty {
            let bounds = GMSCoordinateBounds(coordinate: coordinates[0], coordinate: coordinates[1])
            for coordinate in coordinates {
                bounds.includingCoordinate(coordinate)
            }
            uiView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: RouteMapView

        init(_ parent: RouteMapView) {
            self.parent = parent
        }

        func mapView(_: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            if parent.coordinates.count >= 2 {
                parent.coordinates.removeAll()
                parent.routes.removeAll()
            }
            parent.coordinates.append(coordinate)

            if parent.coordinates.count == 2 {
                let direction = Direction(from: parent.coordinates[0], to: parent.coordinates[1], alternative: true, mode: .driving)
                direction.detectRoute { route in
                    if let newRoutes = route.routes as? [Routes] {
                        self.parent.routes = newRoutes
                    }
                } failure: { error in
                    print("Error fetching route: \(error)")
                }
            }
        }
    }
}

extension GMSMapView {
    func addOverlay(path: String, color: UIColor = .blue) {
        if let gmsPath = GMSPath(fromEncodedPath: path) {
            let line = GMSPolyline(path: gmsPath)
            line.strokeColor = color
            line.strokeWidth = 6.0
            line.map = self
        }
    }
}

struct RouteMapContentView: View {
    @State var coordinates: [CLLocationCoordinate2D] = []
    @State var routes: [Routes] = []

    var body: some View {
        RouteMapView(coordinates: $coordinates, routes: $routes)
            .edgesIgnoringSafeArea(.all)
    }
}
