//
//  TaiwanTripPlannerView.swift
//  GTravel
//
//  Created by Lono on 2024/7/19.
//

import SwiftUI

import MapKit

struct FakePin: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct TaiwanTripPlannerView: View {
    @Binding var appState: AppState
    @State private var displayedResponse = ""
    @State private var isTyping = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.0330, longitude: 121.5654),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

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

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            mainView
        }
        .onAppear {
            startDisplayingResponse()
        }
    }

    private func startDisplayingResponse() {
        guard !appState.geminiResponse.isEmpty else { return }
        let response = appState.geminiResponse[0]
        isTyping = true

        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if displayedResponse.count < response.count {
                displayedResponse.append(response[response.index(response.startIndex, offsetBy: displayedResponse.count)])
            } else {
                timer.invalidate()
                isTyping = false
            }
        }
    }

    var mainView: some View {
        HStack(spacing: 20) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(appState.userInputs[0])
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top)

                    // ProSearchSection()

                    SourcesSection()
                    YoutubeGallery()

                    AnswerSection(displayedResponse: displayedResponse)

                    Spacer()

                    AskFollowUpButton()
                }
                .padding()
            }

            VStack {
                MapDemoView()
                Map(coordinateRegion: $region, annotationItems: fakePins) { pin in
                    MapAnnotation(coordinate: pin.coordinate) {
                        VStack {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 30, height: 30)
                            Text(pin.name)
                                .foregroundColor(.white)
                                .font(.caption)
                        }
                    }
                }

                .frame(height: 300)
                .cornerRadius(10)

                ImageGallery()
            }
            .frame(width: 300)
        }
    }
}

struct ProSearchSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "magnifyingglass")
                Text("Pro Search")
            }
            .foregroundColor(.white)
            .font(.headline)

            ForEach(0 ..< 3) { _ in
                HStack {
                    Text("• Search for information...")
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            }
        }
    }
}

struct SourcesSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Sources")
                .foregroundColor(.white)
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(0 ..< 3) { _ in
                        SourceCard()
                    }
                    Text("View 3 more")
                        .foregroundColor(.blue)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
    }
}

struct SourceCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("The 20 Best Night Markets in Taiwan, from...")
                .foregroundColor(.white)
                .font(.caption)
            HStack {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 20, height: 20)
                Text("taiwanobsessed • 1")
                    .foregroundColor(.gray)
                    .font(.caption2)
            }
        }
        .padding()
        .frame(width: 200)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

struct AnswerSection: View {
    let displayedResponse: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Answer")
                .foregroundColor(.white)
                .font(.headline)

            Text(LocalizedStringKey(displayedResponse))
                .foregroundColor(.white)
        }
    }
}

struct AskFollowUpButton: View {
    var body: some View {
        Button(action: {
            // Action for ask follow-up
        }) {
            HStack {
                Image(systemName: "plus.circle")
                Text("Ask follow-up")
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(20)
        }
    }
}

import LinkPreview

extension String: Identifiable {
    public var id: Self {
        return self
    }
}

struct YoutubeGallery: View {
    let videos = ["https://www.youtube.com/watch?v=C3SNF5UCXPo", "https://www.youtube.com/watch?v=3OzipAmNG2s", "https://www.youtube.com/watch?v=-VJK0KXewM0"]
    var body: some View {
        HStack(spacing: 10) {
            ForEach(videos) { urlStr in

                LinkPreview(url: URL(string: urlStr)!)
                    .backgroundColor(.blue)
                    .primaryFontColor(.white)
                    .secondaryFontColor(.white.opacity(0.6))
                    .titleLineLimit(3)
                    .frame(width: 140, height: 140)
                    .cornerRadius(10)
            }

            Button(action: {
                // Action for View More
            }) {
                Text("View More")
                    .foregroundColor(.blue)
            }
        }
    }
}

let unsplashImageURLs: [String] = [
    "https://images.unsplash.com/photo-1504164996022-09080787b6b3?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1712371963079-6d3a77f70e50?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1712222229438-e6270c1878bf?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    // Add more URLs as needed
]
struct ImageGallery: View {
    let urls = ["https://picsum.photos/200/300", "https://picsum.photos/300/300", "https://picsum.photos/400/300", "https://picsum.photos/200/400"]

    var body: some View {
        VStack(spacing: 10) {
            ForEach(0 ..< 2) { row in
                HStack(spacing: 10) {
                    ForEach(0 ..< 2) { col in
                        AsyncImage(url: URL(string: urls[row * 2 + col])!) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipped()
                                .cornerRadius(10)
                        } placeholder: {
                            Color.gray
                        }
                    }
                }
            }

            Button(action: {
                // Action for View More
            }) {
                Text("View More")
                    .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    TaiwanTripPlannerView(appState: .constant(AppState()))
}

extension AttributedString {
    init(styledMarkdown markdownString: String) throws {
        var output = try AttributedString(
            markdown: markdownString,
            options: .init(
                allowsExtendedAttributes: true,
                interpretedSyntax: .full,
                failurePolicy: .returnPartiallyParsedIfPossible
            ),
            baseURL: nil
        )

        for (intentBlock, intentRange) in output.runs[AttributeScopes.FoundationAttributes.PresentationIntentAttribute.self].reversed() {
            guard let intentBlock = intentBlock else { continue }
            for intent in intentBlock.components {
                switch intent.kind {
                case let .header(level: level):
                    switch level {
                    case 1:
                        output[intentRange].font = .system(.title).bold()
                    case 2:
                        output[intentRange].font = .system(.title2).bold()
                    case 3:
                        output[intentRange].font = .system(.title3).bold()
                    default:
                        break
                    }
                default:
                    break
                }
            }

            if intentRange.lowerBound != output.startIndex {
                output.characters.insert(contentsOf: "\n", at: intentRange.lowerBound)
            }
        }

        self = output
    }
}
