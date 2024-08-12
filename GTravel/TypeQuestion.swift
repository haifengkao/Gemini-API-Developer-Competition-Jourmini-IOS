//
//  TypeQuestionDemo.swift
//  GTravel
//
//  Created by Lono on 2024/8/10.
//

import Foundation

import SwiftUI

struct TypeQuestionDemo: View {
    @State private var searchText = ""
    @State private var isExplorePressed = false
    @State private var isTyping = false
    @State private var typingTimer: Timer?
    @State private var isSearchPressed = false
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
                    .minimumScaleFactor(0.4)
                    .foregroundColor(.white)
                    .onAppear {
                        startTyping()
                    }
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)

            HStack {
                Button(action: {
                    simulateSearchClick()
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(isSearchPressed ? Color.blue.opacity(0.7) : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .scaleEffect(isSearchPressed ? 0.95 : 1.0)
                }
                .animation(.easeInOut(duration: 0.1), value: isSearchPressed)

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

    private func startTyping() {
        guard !appState.interactions.isEmpty else { return }
        guard case let .input(.userInput(userInput)) = appState.interactions[0] else { return }
        let input = userInput.userInput
        isTyping = true

        typingTimer = Timer.scheduledTimer(withTimeInterval: appState.userInputSpeed, repeats: true) { timer in
            if searchText.count < input.count {
                searchText.append(input[input.index(input.startIndex, offsetBy: searchText.count)])
            } else {
                timer.invalidate()
                isTyping = false
                // Trigger search button click after typing is complete
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    simulateSearchClick()
                }
            }
        }
    }

    private func simulateSearchClick() {
        // Simulate button press
        isSearchPressed = true

        // Simulate button release after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isSearchPressed = false

            // Simulate navigation after button release
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                print("Search button clicked")
                navigationPath.append(ViewType.gTravel)
            }
        }
    }
}

#Preview {
    TypeQuestionDemo(appState: .constant(AppState()), navigationPath: .constant(NavigationPath()))
}
