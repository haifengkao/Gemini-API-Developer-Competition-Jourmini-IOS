//
//  ApiClient.swift
//  GTravel
//
//  Created by Lono on 2024/8/2.
//

import Foundation

struct S1enItem: Codable {
    // Define the properties of S1enItem here
}

struct LocationInfoBasic: Codable {
    // Define the properties of LocationInfoBasic here
}

struct ChatContinueRequest: Codable {
    let threadId: String
    let locationBasicInfo: [LocationInfoBasic]?
    let userInteraction: String?
    
    enum CodingKeys: String, CodingKey {
        case threadId = "threadId"
        case locationBasicInfo = "locationBasicInfo"
        case userInteraction = "userInteraction"
    }
}

class APIClient {
    static let shared = APIClient()
    private let baseURL = "https://langraphagent-production.up.railway.app/api/v1/llm/chat/continue"
    
    private func post<T: Codable>(_ request: ChatContinueRequest) async throws -> T {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        urlRequest.httpBody = try encoder.encode(request)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    func morePlace(threadId: String, list: [LocationInfoBasic]) async throws -> S1enItem {
        let request = ChatContinueRequest(threadId: threadId, locationBasicInfo: list, userInteraction: nil)
        print("planning: request\n\(request)")
        
        do {
            let response: S1enItem = try await post(request)
            print("planning: responseBody\n\(response)")
            return response
        } catch {
            print("Error occurred: \(error.localizedDescription)")
            return S1enItem()
        }
    }
    
    func userInput(threadId: String, userInteraction: String) async throws -> S1enItem {
        let request = ChatContinueRequest(threadId: threadId, locationBasicInfo: nil, userInteraction: userInteraction)
        print("planning: request\n\(request)")
        
        do {
            let response: S1enItem = try await post(request)
            print("planning: responseBody\n\(response)")
            return response
        } catch {
            print("Error occurred: \(error.localizedDescription)")
            return S1enItem()
        }
    }
    
    func done(threadId: String) async throws -> S1enItem {
        let request = ChatContinueRequest(threadId: threadId, locationBasicInfo: nil, userInteraction: "幫我規劃")
        print("planning: request\n\(request)")
        
        do {
            let response: S1enItem = try await post(request)
            print("planning: responseBody\n\(response)")
            return response
        } catch {
            print("Error occurred: \(error.localizedDescription)")
            return S1enItem()
        }
    }
}

