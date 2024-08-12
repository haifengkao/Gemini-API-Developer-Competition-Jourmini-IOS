//
//  HybridApi.swift
//  GTravel
//
//  Created by Lono on 2024/8/5.
//

import Foundation


// MARK: - Models

struct HybridApiResponse: Codable {
    let results: [ResultItem]
}

struct ResultItem: Codable {
    let locations: [String]
    let semanticRatio: Double
    let topN: Int
    
    enum CodingKeys: String, CodingKey {
        case locations
        case semanticRatio
        case topN = "top_n"
    }
}

struct HybridApiRequest: Codable {
    let locations: [String]
    let semanticRatio: Double
    let topN: Int
    
    enum CodingKeys: String, CodingKey {
        case locations
        case semanticRatio
        case topN = "top_n"
    }
}

// MARK: - API Client

class HybridApi {
    static func fetchHybridApiData() async throws -> HybridApiResponse? {
        let url = URL(string: "https://langraphagent-production.up.railway.app/api/v1/search/hybrid/multi/?index_uid=youtube_full_context_videos")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let requestBody = HybridApiRequest(locations: ["string"], semanticRatio: 0.5, topN: 3)
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(HybridApiResponse.self, from: data)
        return response
    }
}
