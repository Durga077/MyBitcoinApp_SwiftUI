//
//  ImagedemoView.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 28/11/25.
//

import SwiftUI

struct City : Decodable {
    let city_id : Int
    let name : String
    let landmarks : [Landmark]
}
struct Landmark : Decodable {
    let landmark_id : Int
    let name, photo_url, description: String
}
 


struct BundleDecoder
{
    static func decodeLandmarkBundleJson() -> [City] {
        let landmarkJson = Bundle.main.path(forResource: "Landmarks", ofType: "json")
        let landmark = try! Data(contentsOf: URL(fileURLWithPath: landmarkJson!), options: .alwaysMapped)
        return try! JSONDecoder().decode([City].self, from: landmark)
    }
}

struct ImagedemoView: View {
    let cities = BundleDecoder.decodeLandmarkBundleJson()
    
    var body: some View {
        NavigationStack {
            List(cities, id: \.city_id) { city in
                Section(content: {
                    ForEach(city.landmarks, id: \.landmark_id) { landmark in
                        HStack
                        {
                            AsyncImage(url: URL(string: landmark.photo_url)) { result in
                                result
                                    .resizable()
                                    .scaledToFit()
                             } placeholder: {
                                ProgressView() // Or any other placeholder view
                                    .frame(width: 50, height: 50) // Apply the same frame to the placeholder
                            }
                            .frame(width: 50, height: 50)
                            Text(landmark.name).font(.headline)
                        }
                    }
                }, header: {
                    Text(city.name).font(.title)
                })
            }
        }.navigationTitle(Text("Location"))
    }
}
 
#Preview {
    ImagedemoView()
}
