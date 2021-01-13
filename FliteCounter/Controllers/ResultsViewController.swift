//
//  ResultsViewController.swift
//  FliteCounter
//
//  Created by Nakul Mehta on 1/8/21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var airlineValue: String?
    var flightCountValue: String?
    var activeFlightString: String?
    
    
    @IBOutlet weak var airlineLabel: UILabel!
    @IBOutlet weak var flightCountLabel: UILabel!
    @IBOutlet weak var activeFlightsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        airlineLabel.text = airlineValue
        flightCountLabel.text = flightCountValue
        activeFlightsLabel.text = activeFlightString
    }
    
    
    @IBAction func chooseAirlineButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
