//
//  FlightCell.swift
//  ShortTrips
//
//  Created by Joshua Adams on 7/31/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

class FlightCell: UITableViewCell {
  
  @IBOutlet var airlineIcon: UIImageView!
  @IBOutlet var flightNumberLabel: UILabel!
  @IBOutlet var landingTimeLabel: UILabel!
  @IBOutlet var flightStatusLabel: UILabel!
  let dateFormatter = NSDateFormatter()
  
  func displayFlight(flight: Flight) {
    airlineIcon.image = flight.airline!.icon()
    flightNumberLabel.text = "#\(flight.flightNumber)"
    if dateFormatter.dateFormat == "" {
      dateFormatter.dateFormat = "hh:mm a"
    }
    landingTimeLabel.text = dateFormatter.stringFromDate(flight.landingTime!)
    flightStatusLabel.textColor = flight.flightStatus!.getColor()
    //flightStatusLabel.text = flight.flightStatus.rawValue
    flightStatusLabel.text = NSLocalizedString(flight.flightStatus!.rawValue, comment: "")
  }
}