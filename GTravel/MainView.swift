//
//  DemoSwitcher.swift
//  GTravel
//
//  Created by Lono on 2024/7/20.
//

import LinkPreview
import SwiftUI

enum ViewType: Hashable {
    case itineraryView
    case tripPlanner
    case linkPreview
    case knowledgeView
    case attractionView
    case mapView
    case gTravel
    case browseDemo
    case typeQuestionDemo
}

struct DemoSwitcher: View {
    @State private var size: CGFloat = 150
    @State var appState = AppState()
    @State private var navigationPath = NavigationPath()

    var mainView: some View {
        NavigationStack(path: $navigationPath) {
            List {
                NavigationLink(value: ViewType.tripPlanner) {
                    Text("ShowTripPlanner")
                }
                NavigationLink(value: ViewType.knowledgeView) {
                    Text("ShowKnowledgeView")
                }
                NavigationLink(value: ViewType.linkPreview) {
                    Text("ShowPreviewLink")
                }
                NavigationLink(value: ViewType.attractionView) {
                    Text("ShowAttractionView")
                }
                NavigationLink(value: ViewType.mapView) {
                    Text("ShowMapView")
                }

                NavigationLink(value: ViewType.gTravel) {
                    Text("GTravel")
                }

                NavigationLink(value: ViewType.browseDemo) {
                    Text("Browse")
                }

                NavigationLink(value: ViewType.typeQuestionDemo) {
                    Text("TypeQuestion")
                }
            }
            .listStyle(.plain)
            .navigationDestination(for: ViewType.self) { viewType in
                switch viewType {
                case .knowledgeView:
                    KnowledgeView(appState: $appState, navigationPath: $navigationPath)
                case .tripPlanner:
                    TaiwanTripPlannerView(appState: $appState)
                case .attractionView:
                    TaipeiAttractionView(appState: $appState, navigationPath: $navigationPath)
                case .browseDemo:
                    BrowseDemo(appState: $appState, navigationPath: $navigationPath)
                case .linkPreview:
                    LinkPreview(url: URL(string: "https://github.com/NuPlay/RichText"))
                        .backgroundColor(.blue)
                        .primaryFontColor(.white)
                        .secondaryFontColor(.white.opacity(0.6))
                        .titleLineLimit(3)
                        .frame(width: size, alignment: .center)
                case .mapView:
                    MapDemoView()
                case .gTravel:
                    GTravelPlannerView_Previews.previews
                case .typeQuestionDemo:
                    TypeQuestionDemo(appState: $appState, navigationPath: $navigationPath)
                case .itineraryView:
                    Text("not implemented")
                    
                }
            }
            .navigationTitle("")
        }
    }
    var body: some View {
        
        if googleMapApiKey.isEmpty {
            Text("provideAPIKey: requires non-empty API key")
        } else {
            mainView
        }
        
    }
}

#Preview {
    DemoSwitcher()
}
