//
//  KnowledgeView.swift
//  GTravel
//
//  Created by Lono on 2024/7/20.
//

import SwiftUI

struct KnowledgeView: View {
    @State private var searchText = ""
    @State private var isPro = false
    @State private var isTyping = false
    @State private var typingTimer: Timer?
    @Binding var appState: AppState
    @Binding var navigationPath: NavigationPath

    var mainView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Where knowledge begins")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Ask anything...", text: $searchText)
                    .foregroundColor(.white)
                    .onAppear {
                        startTyping()
                    }
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)

            HStack {
                NavigationLink(value: ViewType.tripPlanner) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Focus")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                }

                Button(action: {
                    // Action for Attach button
                }) {
                    HStack {
                        Image(systemName: "paperclip")
                        Text("Attach")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                }

                Spacer()

                Toggle("", isOn: $isPro)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))

                Text("Pro")
                    .foregroundColor(.gray)
            }
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

    private func startTyping() {
        guard !appState.userInputs.isEmpty else { return }
        let input = appState.userInputs[0]
        isTyping = true

        typingTimer = Timer.scheduledTimer(withTimeInterval: appState.userInputSpeed, repeats: true) { timer in
            if searchText.count < input.count {
                searchText.append(input[input.index(input.startIndex, offsetBy: searchText.count)])
            } else {
                timer.invalidate()
                isTyping = false
                // Trigger navigation after typing is complete
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    navigationPath.append(ViewType.tripPlanner)
                }
            }
        }
    }
}

#Preview {
    KnowledgeView(appState: .constant(AppState()), navigationPath: .constant(NavigationPath()))
}
