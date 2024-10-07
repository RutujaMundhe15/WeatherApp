//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Rutuja on 2024-10-07.
//

import Foundation

struct WeatherResponse: Codable {
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }

    struct Weather: Codable {
        let description: String
        let main: String // For dynamic backgrounds
    }

    let name: String
    let main: Main
    let weather: [Weather]
}

