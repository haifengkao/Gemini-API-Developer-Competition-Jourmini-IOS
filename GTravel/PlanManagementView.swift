//
//  PlanManagementView.swift
//  GTravel
//
//  Created by Lono on 2024/8/12.
//

import SwiftUI

struct PlanManagementView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // Search bar
                TextField("Search", text: $searchText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 15)
                        }
                    )
                
                // List of plans
                List {
                    
                
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("", displayMode: .inline)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationDestination(for: ViewType.self) { viewType in
                switch viewType {
                    
                case .itineraryView:
                    ItineraryView()
                default:
                    Text("not implemented")
                }
        }
    }
}

struct PlanRow: View {
    let title: String
    let description: String
    
    var body: some View {
        NavigationLink(value: ViewType.itineraryView) {
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            .padding(.vertical, 5)
        }
    }
    }
}
struct PlanManagementView_Previews: PreviewProvider {
    static var previews: some View {
        PlanManagementView()
            .preferredColorScheme(.dark)
    }
}
