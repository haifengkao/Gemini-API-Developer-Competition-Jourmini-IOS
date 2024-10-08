//
//  Route.swift
//  Direction
//
//  Created by Shichimitoucarashi on 2017/12/17.
//  Copyright © 2017年 keisuke yamagishi. All rights reserved.
//

import Foundation

class Route {
    static let directionApi = "https://maps.googleapis.com/maps/api/directions/json?"

    let query: String

    init(_ query: [String: String]) {
        self.query = query.encode(using: .utf8)
    }

    static func request(_ query: [String: String]) -> URLRequest? {
        Route(query).request
    }

    var url: URL? {
        URL(string: Route.directionApi + query)
    }

    var request: URLRequest? {
        guard url != nil else { return nil }
        var request = URLRequest(url: url!)
        if let url = url {
            print("Google Direction API URL: \(String(describing: url))")
        }
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        return request
    }
}
