//
//  SelectableImageGallery.swift
//  GTravel
//
//  Created by Lono on 2024/8/7.
//

import Foundation
import SwiftUI

struct SelectableImageGallery: View {
    let places: [Place]
    let selected: [String]
    var onConfirm: ([Place]) -> Void

    var body: some View {
        VStack(spacing: 10) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(places, id: \.placeID) { place in
                    SelectableImageView(place: place,
                                        isSelected: selected.contains(place.name),
                                        action: { toggleSelection(0) })
                }
            }

            /*
             Button(action: {
                 // Action for View More
             }) {
                 Text("View More")
                     .foregroundColor(.blue)
             }*/

            /*
             if !selected.isEmpty {
                 Button(action: {
                     let selectedPlaces = places.filter { selected.contains($0.name) }
                     onConfirm(selectedPlaces)
                 }) {
                     Text("Confirm Selection (\(selected.count))")
                         .foregroundColor(.white)
                         .padding()
                         .background(Color.blue)
                         .cornerRadius(10)
                 }
             }*/
        }
    }

    private func toggleSelection(_: Int) {}
}

struct SelectableImageView: View {
    let place: Place
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        ZStack {
            AsyncImage(url: place.url) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .clipped()
            } placeholder: {
                Color.gray
            }
            .frame(width: 140, height: 140)
            .cornerRadius(10)

            VStack {
                Spacer()
                Text(place.name)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(5)
                    .padding(4)
            }

            if isSelected {
                Color.blue.opacity(0.3)
                    .frame(width: 140, height: 140)
                    .cornerRadius(10)

                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
        )
        .onTapGesture(perform: action)
    }
}

struct SelectableImageGallery_Previews: PreviewProvider {
    static var previews: some View {
        SelectableImageGallery(
            places: [
                Place(placeID: "1", name: "Taipei 101", url: URL(string: "https://picsum.photos/200/300")!),
                Place(placeID: "2", name: "Night Market", url: URL(string: "https://picsum.photos/300/300")!),
                Place(placeID: "3", name: "Taroko Gorge", url: URL(string: "https://picsum.photos/400/300")!),
                Place(placeID: "4", name: "Sun Moon Lake", url: URL(string: "https://picsum.photos/200/400")!),
            ],
            selected: [],
            onConfirm: { selectedPlaces in
                print("Selected Places: \(selectedPlaces.map { $0.name }.joined(separator: ", "))")
            }
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
