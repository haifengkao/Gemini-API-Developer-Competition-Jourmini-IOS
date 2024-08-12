//
//  GTravelApp.swift
//  GTravel
//
//  Created by Lono on 2024/7/19.
//

import GoogleMaps
import SwiftUI

@main
struct GTravelApp: App {
    init() {
        GMSServices.provideAPIKey(googleMapApiKey)
    }

    var body: some Scene {
        WindowGroup {
            
                    TabView {
                        DemoSwitcher()
                            .tabItem {
                                Image(systemName: "mappin.and.ellipse")
                                Text("Next Adventure")
                            }
                        PlanManagementView()
                            .tabItem {
                                Image(systemName: "rectangle.grid.1x2")
                                Text("Plan Management")
                            }
                        
                        UsersView()
                            .tabItem {
                                Image(systemName: "person.2")
                                Text("Users")
                            }
                    }.preferredColorScheme(.dark)
                    
                }
            

            // TaiwanTripPlannerView()
        }
    
}
