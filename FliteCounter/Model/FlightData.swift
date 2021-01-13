//
//  FlightData.swift
//  FliteCounter
//
//  Created by Nakul Mehta on 1/4/21.
//

import Foundation

// See JSON structure here: http://api.aviationstack.com/v1/flights?access_key=fbdaf32eeeaa79f12a810a86fab44ac1&airline_icao=aal&flight_status=active#

struct FlightData: Codable {
    let data: [Flight]
    let pagination: Pagination
}

struct Pagination: Codable {
    let total: Int
}

struct Flight: Codable {
    let live: Live?
    let airline: Airline
}

struct Live: Codable {
    let is_ground: Bool
}

struct Airline: Codable {
    let name: String
}
