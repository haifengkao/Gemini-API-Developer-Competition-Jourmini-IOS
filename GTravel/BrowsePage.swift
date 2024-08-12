//
//  BrowseDemo.swift
//  GTravel
//
//  Created by Lono on 2024/8/8.
//

import Foundation

import SwiftUI

struct BrowseDemo: View {
    @State private var searchText = ""

    @State private var isExplorePressed = false
    @Binding var appState: AppState
    @Binding var navigationPath: NavigationPath

    var mainView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Plan Your Next Adventure")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)

            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.gray)
                TextField("", text: $searchText, prompt: Text("Enter destination...").foregroundColor(Color(white: 0.7)))
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)

            HStack {
                Button(action: {
                    // Action for Search button
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }

                Button(action: {
                    simulateExploreClick()
                }) {
                    HStack {
                        Image(systemName: "map")
                        Text("Explore")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(isExplorePressed ? Color.green.opacity(0.7) : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .scaleEffect(isExplorePressed ? 0.95 : 1.0)
                }
                .animation(.easeInOut(duration: 0.1), value: isExplorePressed)

                Spacer()
            }

            // Add more trip planning options here
            // ...
        }
        .padding()
        .background(Color.black)
    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            mainView
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                simulateExploreClick()
            }
        }
    }

    private func simulateExploreClick() {
        // Simulate button press
        isExplorePressed = true

        // Simulate button release after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isExplorePressed = false

            // Simulate navigation after button release
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                print("Explore button clicked")
                navigationPath.append(ViewType.attractionView)
            }
        }
    }
}

#Preview {
    BrowseDemo(appState: .constant(AppState()), navigationPath: .constant(NavigationPath()))
}
