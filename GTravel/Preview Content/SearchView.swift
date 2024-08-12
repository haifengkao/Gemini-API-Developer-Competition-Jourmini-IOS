//
//  SearchApi.swift
//  GTravel
//
//  Created by Lono on 2024/8/4.
//

import Foundation

import SwiftUI
import Combine

struct SearchPage: View {
    @State private var text = ""
    @State private var showBottomSheet = false
    @State private var isWaiting = false
    
    @State private var selectedList: [Int] = []
    
  
    
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            
            Text("Plan Next Adventure")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        searchByText()
                    }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(8)
            
            HStack(spacing: 8) {
                Button(action: searchByText) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button(action: { showBottomSheet = true }) {
                    HStack {
                        Image(systemName: "paperclip")
                        Text("Explore")
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            
            Spacer()
        }
        .padding()
        
        .onAppear {
           
        }
        .overlay(Group {
            if isWaiting {
                Waiting()
            }
        })
    }
    
    private func searchByText() {
        isWaiting = true
        let id = UUID().uuidString
        _ = S1Request(threadId: id, userInteraction: text)
        
        // Implement API call here
        // After API call:
        // navigateToTrip(Route.Trip(id: id, items: [responseBody]))
        // isWaiting = false
    }
    
    private func planTrip() {
        isWaiting = true
        let id = UUID().uuidString
        _ = S1Request(
            locations: selectedList.map { "\(selectedList[$0])"  },
            threadId: id
        )
        
        // Implement API call here
        // After API call:
        // navigateToTrip(Route.Trip(id: id, items: [responseBody]))
        // isWaiting = false
    }
}



struct Waiting: View {
    var body: some View {
        ProgressView()
            .scaleEffect(2)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.3))
    }
}


struct S1Request {
    let locations: [String]?
    let threadId: String?
    let userInteraction: String?
    
    init(locations: [String]? = nil, threadId: String? = nil, userInteraction: String? = nil) {
        self.locations = locations
        self.threadId = threadId
        self.userInteraction = userInteraction
    }
}

