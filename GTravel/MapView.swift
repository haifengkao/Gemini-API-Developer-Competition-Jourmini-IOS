//
//  MapView.swift
//  GTravel
//
//  Created by Lono on 2024/8/3.
//

import Foundation

import GoogleMaps

let googleMapApiKey = ""

// Array of fake pin data
let fakePins: [FakePin] = [
    FakePin(name: "Taipei 101", coordinate: CLLocationCoordinate2D(latitude: 25.0338, longitude: 121.5645)),
    FakePin(name: "Xiangshan Hiking Trail", coordinate: CLLocationCoordinate2D(latitude: 25.0454, longitude: 121.5706)),
    FakePin(name: "Taipei City Mall", coordinate: CLLocationCoordinate2D(latitude: 25.0685, longitude: 121.5623)),
    FakePin(name: "Xinyi Anhe Boxing Walking Street", coordinate: CLLocationCoordinate2D(latitude: 25.0214, longitude: 121.5669)),
    FakePin(name: "Eslite Bookstore Xinyi", coordinate: CLLocationCoordinate2D(latitude: 25.0599, longitude: 121.5692)),
    FakePin(name: "Shilin Night Market", coordinate: CLLocationCoordinate2D(latitude: 25.0914, longitude: 121.5169)),
    FakePin(name: "Beitou Hot Spring", coordinate: CLLocationCoordinate2D(latitude: 25.1346, longitude: 121.5072)),
    FakePin(name: "Yangmingshan National Park", coordinate: CLLocationCoordinate2D(latitude: 25.1676, longitude: 121.5440)),
]

import GoogleMaps
import SwiftUI

struct MapDemoView: View {
    @State private var customPins: [FakePin] = fakePins

    var body: some View {
        GoogleMapView(pins: customPins)
            .edgesIgnoringSafeArea(.all)
    }
}

struct GoogleMapView: UIViewRepresentable {
    let pins: [FakePin]

    func makeUIView(context _: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: 25.0399, longitude: 121.5692, zoom: 14.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context _: Context) {
        for pin in pins {
            let marker = GMSMarker()
            marker.position = pin.coordinate
            marker.title = pin.name
            marker.map = uiView
        }
    }
}
