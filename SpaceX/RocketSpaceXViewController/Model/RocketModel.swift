//
//  RocketModel.swift
//  SpaceX
//
//  Created by Анна Сычева on 18.08.2022.
//

struct Rocket: Decodable {
    let name: String
    let flickrImages: [String]
    let height: MeasurementUnit
    let diameter: MeasurementUnit
    let mass: MeasurementUnitMass
    let payloadWeights: [MeasurementUnitMass]
    let firstFlight: String
    let country: String
    let costPerLaunch: Int
    let firstStage: Stage
    let secondStage: Stage
    
    enum CodingKeys: String, CodingKey {
        case name
        case flickrImages = "flickr_images"
        case height
        case diameter
        case mass
        case payloadWeights = "payload_weights"
        case firstFlight = "first_flight"
        case country
        case costPerLaunch = "cost_per_launch"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
    }
}
