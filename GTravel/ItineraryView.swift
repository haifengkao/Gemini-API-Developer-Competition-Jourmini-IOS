//
//  ItineraryView.swift
//  GTravel
//
//  Created by Lono on 2024/8/12.
//

import SwiftUI

struct ItineraryView: View {
    let itinerary = [
        Day(number: 1, activities: [
            Activity(time: "Arrival", description: "Arrive at Tainan Airport (TNN) or Tainan Railway Station."),
            Activity(time: "Hotel Check-in", description: "Check into your hotel near Anping Old Fort or in the city center."),
            Activity(time: "Afternoon", description: "Take a taxi or bus to Anping Old Fort. Explore its historical structures and learn about its past."),
            Activity(time: "Evening", description: "Take a taxi to Guo-Hua Beef Soup for dinner. Savor the renowned beef soup and traditional Taiwanese dishes.")
        ]),
        Day(number: 2, activities: [
            Activity(time: "Morning", description: "Take a taxi or bus to Hayashi Department Store. Explore its unique architecture and indulge in their famous beef soup dish."),
            Activity(time: "Afternoon", description: "Take a short walk from Hayashi Department Store to Shennong Street. Sample various local snacks and delicacies, and experience the vibrant atmosphere."),
            Activity(time: "Evening", description: "Enjoy a relaxing evening at your hotel or explore the local nightlife.")
        ]),
        Day(number: 3, activities: [
            Activity(time: "Morning", description: "Take a taxi or bus to the Yujing mango wholesale market. Taste the famous Yujing mangoes and learn about their cultivation."),
            Activity(time: "Afternoon", description: "Take a taxi or bus to Chihkan Tower. Explore its history and enjoy panoramic views of the city."),
            Activity(time: "Evening", description: "Take a taxi to a local restaurant of your choice for a farewell dinner.")
        ]),
        Day(number: 4, activities: [
            Activity(time: "Departure", description: "Take a taxi or bus to Tainan Airport (TNN) or Tainan Railway Station for your departure.")
        ])
    ]
    
    var body: some View {
        
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(itinerary) { day in
                        DayItinerary(day: day)
                    }
                    TransportationTips()
                }
                .padding()
            }
            .background(Color.black)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("4-day Tainan itinerary")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Edit action
                    }) {
                        Text("Edit")
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.green)
                            .cornerRadius(20)
                    }
                }
            }
        
        .accentColor(.white)
    }
}

struct Day: Identifiable {
    let id = UUID()
    let number: Int
    let activities: [Activity]
}

struct Activity: Identifiable {
    let id = UUID()
    let time: String
    let description: String
}

struct DayItinerary: View {
    let day: Day
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Day \(day.number):")
                .font(.headline)
                .foregroundColor(.white)
            
            ForEach(day.activities) { activity in
                ActivityRow(time: activity.time, description: activity.description)
            }
        }
    }
}

struct ActivityRow: View {
    let time: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("•")
                .foregroundColor(.white)
            VStack(alignment: .leading, spacing: 5) {
                Text(time + ":")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct TransportationTips: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Transportation Tips:")
                .font(.headline)
                .foregroundColor(.white)
            
            ForEach(tips, id: \.self) { tip in
                Text("• " + tip)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
    
    let tips = [
        "Taxis are readily available in Tainan and are a convenient way to get around.",
        "Tainan has a comprehensive bus network, and you can find bus stops near most attractions.",
        "Use Google Maps to plan your routes and get directions.",
        "Tainan TRA Station can be used to travel to other parts of Taiwan.",
        "Remember to factor in travel time when planning your itinerary."
    ]
}

struct ItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        ItineraryView()
            .preferredColorScheme(.dark)
    }
}
