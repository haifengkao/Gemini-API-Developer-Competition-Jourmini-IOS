//
//  GoogleTraffic.swift
//  GTravel
//
//  Created by Lono on 2024/8/11.
//

import Foundation

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

struct GooglePlace {
    let placeId: String
    let placeName: String
    let placeAddress: String
    let placeCoordinates: Coordinates
    let photoUrl: URL
}

struct DailyItinerary {
    let places: [GooglePlace]
}

// Creating the objects
let googleTraffic: [DailyItinerary] = [
    DailyItinerary(places: [
        
        GooglePlace(
            placeId: "ChIJCaqM84x2bjQRRqzST46i6cM",
            placeName: "Tainan Train Station",
            placeAddress: "No. 210, Qianfeng Rd, East District, Tainan City, Taiwan 701",
            placeCoordinates: Coordinates(latitude: 22.9970861, longitude: 120.21298319999998),
            photoUrl: URL(string: "https://lh3.googleusercontent.com/places/ANXAkqFs-J8w4Sh-E92GXX--lGTwPakOErXYObE3-w6gng_Gb9lA-aKM5aBmf3dSe3xW3jeClBGSki_6qbiBx80QXIgsmMJ1uTBgJIA=s4800-w1600-h1600")!
        ),
       
        GooglePlace(
            placeId: "ChIJZ-TjeHN2bjQR8a3Jat0VHps",
            placeName: "Anping Old Fort",
            placeAddress: "No. 82, Guosheng Rd, Anping District, Tainan City, Taiwan 708",
            placeCoordinates: Coordinates(latitude: 23.001509300000002, longitude: 120.1606244),
            photoUrl: URL(string: "https://lh3.googleusercontent.com/places/ANXAkqGggAO2os3mmdvN-njYyjiUjP2GTpheyV7LKh8-Q4ufbZc1T35sYpyxh5U4A8IaRbIQ6dEH3dxn8CmDgXk13HoIo4bkfVYckWI=s4800-w400-h400")!
        ),
    ]),
    DailyItinerary(places: [
        GooglePlace(
            placeId: "ChIJrZJc4GJ2bjQRa3BRyIgtRcM",
            placeName: "Hayashi Department Store",
            placeAddress: "No. 63號, Section 2, Zhongyi Rd, West Central District, Tainan City, Taiwan 700",
            placeCoordinates: Coordinates(latitude: 22.9917925, longitude: 120.2025232),
            photoUrl: URL(string: "https://lh3.googleusercontent.com/places/ANXAkqFyc8k2vEH2pmgbqu1ctnzIIHMQO0Z0ccevRjIx43rUnC10yn4hLCYQQENe7QedGr_hJsDALi2fx2wgT997hnWSX3JCvD1bGfs=s4800-w400-h400")!
        ),
        GooglePlace(
            placeId: "ChIJqctagGZ2bjQRGlAjSFrC5hE",
            placeName: "Shennong Street",
            placeAddress: "700, Taiwan, Tainan City, West Central District, 神農街58-1號",
            placeCoordinates: Coordinates(latitude: 22.9975171, longitude: 120.19649489999999),
            photoUrl: URL(string: "https://lh3.googleusercontent.com/places/ANXAkqFoYu5vqTYsQS65lRmT7BC40hTlKCT_rEhiGk_M1GAwktVcDofLz3A9c0GECiEkgw-BWgZchS_Jk507cCR2FJ48w08FiY3ajyA=s4800-w400-h400")!
        ),
    ]),
    DailyItinerary(places: [
        GooglePlace(
            placeId: "ChIJ-1mWkD1hbjQRTiDx-ua04Rk",
            placeName: "Yujing mango wholesale market",
            placeAddress: "714, Taiwan, Tainan City, Yujing District, 芒果批發市場",
            placeCoordinates: Coordinates(latitude: 23.1226675, longitude: 120.45820030000002),
            photoUrl: URL(string: "https://lh3.googleusercontent.com/places/ANXAkqEBzH3KoEJlFZw4pXT3EfT7FmoZeKYJH1FOgQs8Q4btBG3AL5UYRBR29YmXPuicu2micw0VWyqRFDJru7GNypcR78eyXSKFraA=s4800-w400-h400")!
        ),
        GooglePlace(
            placeId: "ChIJbYl7d2F2bjQRnFdvyMBuZfI",
            placeName: "Chikan Tower",
            placeAddress: "No. 212, Section 2, Minzu Rd, West Central District, Tainan City, Taiwan 700",
            placeCoordinates: Coordinates(latitude: 22.997477999999997, longitude: 120.2025433),
            photoUrl: URL(string: "https://lh3.googleusercontent.com/places/ANXAkqG86zHH3zVdP9d-m5eSaiBkWFBaPiiExjFfsQpmOz6NYDEUfinTFqBScDurVJQGokHj2DzguaPzKEMpm4q27zohUHIK-ZCEZHc=s4800-w400-h400")!
        ),
    ]),
    DailyItinerary(places: [
        GooglePlace(
            placeId: "ChIJbYl7d2F2bjQRnFdvyMBuZfI",
            placeName: "Chikan Tower",
            placeAddress: "No. 212, Section 2, Minzu Rd, West Central District, Tainan City, Taiwan 700",
            placeCoordinates: Coordinates(latitude: 22.997477999999997, longitude: 120.2025433),
            photoUrl: URL(string: "https://lh3.googleusercontent.com/places/ANXAkqG86zHH3zVdP9d-m5eSaiBkWFBaPiiExjFfsQpmOz6NYDEUfinTFqBScDurVJQGokHj2DzguaPzKEMpm4q27zohUHIK-ZCEZHc=s4800-w400-h400")!
        ),
        GooglePlace(
            placeId: "ChIJCaqM84x2bjQRRqzST46i6cM",
            placeName: "Tainan Train Station",
            placeAddress: "No. 210, Qianfeng Rd, East District, Tainan City, Taiwan 701",
            placeCoordinates: Coordinates(latitude: 22.9970861, longitude: 120.21298319999998),
            photoUrl: URL(string: "https://lh3.googleusercontent.com/places/ANXAkqFs-J8w4Sh-E92GXX--lGTwPakOErXYObE3-w6gng_Gb9lA-aKM5aBmf3dSe3xW3jeClBGSki_6qbiBx80QXIgsmMJ1uTBgJIA=s4800-w1600-h1600")!
        ),
    ]),
]
