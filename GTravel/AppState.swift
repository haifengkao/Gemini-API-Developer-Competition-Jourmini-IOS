//
//  AppState.swift
//  GTravel
//
//  Created by Lono on 2024/8/9.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    /// the timer interval to update the partial data
    var userInputSpeed: Double = 0.03
    var userInputs: [String] = [
        "Plan a three days trips in Taiwan especially focusing on night market tour.",
    ]
    var geminiResponse: [String] = ["""


    這些行程和景點能夠讓你在一天內充分體驗台北的魅力，無論是自然景觀、文化歷史還是美食購物，都能滿足不同的需求[2][5].
    """]
    var selectedSites: [String] = []
    var interactions: [Interaction] = []
   
}

