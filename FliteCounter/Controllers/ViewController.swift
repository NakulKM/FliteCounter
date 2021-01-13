//
//  ViewController.swift
//  FliteCounter
//
//  Created by Nakul Mehta on 1/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    var flightManager = FlightManager()
    var flightData: FlightData?
    // String value for airline name, returned by UIPickerView delegate method, accessed when making changes to results ViewController
    var airlineName: String?
    
    
    
    @IBOutlet weak var airlinePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set view controller as delegate AND data source of UI Picker View
        airlinePicker.delegate = self
        airlinePicker.dataSource = self
        flightManager.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Modify result view controller labels
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.flightCountValue = String(self.flightData!.pagination.total)
            let airlineValueString = "\(airlineName!) has"
            destinationVC.airlineValue = airlineValueString
            destinationVC.activeFlightString = K.activeFlightsString
        }
    }
    
}

//MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // Number of columns  in UIPickerView
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return flightManager.airlineList.count
    }
    
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // Returning airline name (first string in each 2-item array in airline list formatted as the following 2-D array: [ [airline name, airline ICAO], ...] )
        airlineName = flightManager.airlineList[row][0]
        return airlineName
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // Fetching data for selected airline in UIPickerView
        let airline = flightManager.airlineList[row][1]
        flightManager.fetchData(for: airline)
        
    }
    
}

//MARK: - FlightManagerDelegate

extension ViewController: FlightManagerDelegate {
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateFlightData(_ flightManager: FlightManager, retrievedData: FlightData) {
        flightData = retrievedData
        
        // Perform segue to results once row is selected and data is updated (on main thread)
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.segueIdentifier, sender: self)
        }
        
    }
}



