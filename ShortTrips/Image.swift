//
//  Image.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

enum Image: String {
  
  // auth
  case blueGrandient = "blue_gradient_bg"
  
  case sfoLogoAlpha = "sfo_logo_alpha"
  
  case greenCircle = "green_circle"
  case blueCircle = "blue_circle"
  case redCircle = "red_circle"
  
  case minus = "minus"
  case minusPressed = "minus_pressed"
  case plus = "plus"
  case plusPressed = "plus_pressed"
  
  case indicatorArrow = "indicator_arrow"
  case downArrow = "down_arrow"
  case backButton = "backButton"
    
  case unknownAirline = "unknownAirline"
  
  case splashLogo = "splashLogo"
  
  case dashboardIcon = "dashboard_icon"
  case flightsIcon = "flights_icon"
  case tripIcon = "trip_icon"
  
  case blackCircle = "black_circle"
  case whiteCircle = "white_circle"
  
  case tripAlert = "alert_icon"
  case tripCar = "car_icon"
  case tripCarInProgress = "car_in_progress_icon"
  case tripCheck = "check_icon"
  case tripGeofence = "geofence_icon"
  case tripGps = "gps_icon"
  case tripHorizontalDivider = "trip_horiz_divider"
  case tripTime = "time_icon"
  case tripThumbsUp = "thumbsup_icon"
  case tripX = "x_icon"
  
  // TODO: remove when ring is real
  case greenRing = "green_ring"
  case yellowRing = "circle_yellow"
  case redRing = "circle_red"
  
  case genericBackground = "generic_background"
  func image() -> UIImage {
    return UIImage(named: self.rawValue)!
  }
  
  static func from(color: UIColor) -> UIImage {
    let rect = CGRectMake(0, 0, 1, 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}
