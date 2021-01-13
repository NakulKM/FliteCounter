//
//  FlightDataManager.swift
//  FliteCounter
//
//  Created by Nakul Mehta on 1/4/21.
//

import Foundation

protocol FlightManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateFlightData(_ flightManager: FlightManager, retrievedData: FlightData)
    
}

struct FlightManager {
    
    let baseURL = "http://api.aviationstack.com/v1/flights?access_key="
    let apiKey = "fbdaf32eeeaa79f12a810a86fab44ac1"
    let requestParameter = "&flight_status=active&airline_icao="
    
    var delegate: FlightManagerDelegate?
    
    
    // 2-D array of airline names and ICAO codes
    let airlineList = [
        ["American Airlines", "AAL"],
        ["United Airlines", "UAL"],
        ["Japan Airlines", "JAL"]
    ]
    
    func fetchData(for airlineICAO: String) {
        
        let urlString = "\(baseURL)\(apiKey)\(requestParameter)\(airlineICAO)"
        
        
        // Networking request
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let retrievedData = self.parseJSON(safeData) {
                        self.delegate?.didUpdateFlightData(self, retrievedData: retrievedData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> FlightData? {
        let decoder = JSONDecoder()
        
        do {
            let decodedFlightData = try decoder.decode(FlightData.self, from: data)
            return decodedFlightData
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
