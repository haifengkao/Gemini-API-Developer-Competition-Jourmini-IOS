//
//  GoogleMapApi.swift
//  GTravel
//
//  Created by Lono on 2024/8/11.
//

import Foundation

let placeId = "ChIJ8TfuVuSHbjQRXSF_mi_zrW8"

func getPlaceDetails(completion: @escaping (String?) -> Void) {
    let urlString = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(placeId)&fields=photos&key=\(googleMapApiKey)"

    guard let url = URL(string: urlString) else {
        completion(nil)
        return
    }

    URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else {
            completion(nil)
            return
        }

        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let result = json["result"] as? [String: Any],
               let photos = result["photos"] as? [[String: Any]],
               let firstPhoto = photos.first,
               let photoReference = firstPhoto["photo_reference"] as? String
            {
                let photoUrl = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=\(photoReference)&key=\(googleMapApiKey)"
                completion(photoUrl)
            } else {
                completion(nil)
            }
        } catch {
            completion(nil)
        }
    }.resume()
}
