//
//  SelectableTextOptions.swift
//  GTravel
//
//  Created by Lono on 2024/8/11.
//

import Foundation
import SwiftUI

struct SelectableTextOptions: View {
    let options: [String]
    var selected: [String]
    var onConfirm: ([String]) -> Void

    var body: some View {
        VStack(spacing: 10) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(options, id: \.self) { option in
                    SelectableTextView(text: option,
                                       isSelected: selected.contains(option),
                                       action: { toggleSelection(option) })
                }
            }
        }
    }

    private func toggleSelection(_: String) {}
}

struct SelectableTextView: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Text(text)
            .foregroundColor(isSelected ? .black : .gray)
            .padding()
            .frame(maxWidth: .infinity)
            .background(isSelected ? .white.opacity(0.8) : Color.black)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
            .onTapGesture(perform: action)
    }
}

struct SelectableTextOptions_Previews: PreviewProvider {
    static var previews: some View {
        SelectableTextOptions(
            options: ["Complete Planning", "Show Transport Options", "Save to Itinerary"],
            selected: [],
            onConfirm: { selectedOptions in
                print("Selected Options: \(selectedOptions.joined(separator: ", "))")
            }
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
