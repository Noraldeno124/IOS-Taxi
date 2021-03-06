//
//  Color.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

struct Color {
  
  struct Auth {
    static let buttonBlue = UIColor(red: 92.0/255.0, green: 120/255.0, blue: 143/255.0, alpha: 1.0)
    static let fadedWhite = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.15)
    static let offWhite = UIColor(red: 224.0/255.0, green: 226.0/255.0, blue: 223.0/255.0, alpha: 0.8)
  }
  
  struct Debug {
    static let green = StatusColor.green
    static let red = StatusColor.red
  }
  
  struct NavBar {
    static let backgroundBlue = UIColor(red: 10.0/255.0, green: 46.0/255.0, blue: 63.0/255.0, alpha: 1.0)
    static let subtitleBlue = UIColor(red: 0.0/255.0, green: 132.0/255.0, blue: 187.0/255.0, alpha: 1.0)
    static let subtitleBluePressed = UIColor(red: 7.0/255.0, green: 95.0/255.0, blue: 133.0/255.0, alpha: 1.0)
  }
  
  struct Dashboard {
    static let gray = UIColor(red: 240/255.0, green: 245/255.0, blue: 249/255.0, alpha: 1.0)
    static let lightBlue = UIColor(red: 242.0/255.0, green: 246.0/255.0, blue: 248.0/255.0, alpha: 1.0)
    static let darkBlue = UIColor(red: 22.0/255.0, green: 103.0/255.0, blue: 131/255.0, alpha: 1.0)
    static let darkBlueHexString = "166783"
    static let black = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let orange = UIColor(red: 246/255.0, green: 93/255.0, blue: 9/255.0, alpha: 1.0)
    static let darkGray = UIColor(red: 86/255.0, green: 86/255.0, blue: 90/255.0, alpha: 1.0)
  }
  
  struct StatusColor {
    static let green = UIColor(red: 21/255.0, green: 155/255.0, blue: 32/255.0, alpha: 1.0)
    static let yellow = UIColor(red: 233/255.0, green: 181/255.0, blue: 46/255.0, alpha: 1.0)
    static let red = UIColor(red: 242/255.0, green: 40/255.0, blue: 41/255.0, alpha: 1.0)
  }
  
  struct Sfo {
    static let blue = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1.0)
    static let blueHexString = "4A90E2"
    static let blueWithAlpha = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 0.5)
    static let gray = UIColor(red: 115.0/255.0, green: 115.0/255.0, blue: 115.0/255.0, alpha: 1.0)
    static let turquoise = UIColor(red: 26.0/255.0, green: 120.0/255.0, blue: 167.0/255.0, alpha: 1.0)
    static let lightBlue = UIColor(red: 150.0/255.0, green: 184.0/255.0, blue: 241.0/255.0, alpha: 1.0)
  }
  
  struct TerminalSummary {
    static let offWhite = UIColor(red: 244.0/255.0, green: 246.0/255.0, blue: 243.0/255.0, alpha: 1.0)
    static let titleBlue = UIColor(red: 66/255.0, green: 117/255.0, blue: 164/255.0, alpha: 1.0)
    static let onTimeContent = Sfo.blue
    static let onTimeTitle = titleBlue
    static let delayedContent = UIColor(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0)
    static let delayedTitle = FlightStatus.delayed
    static let darkBackground = UIColor(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 0.15)
    static let separator = UIColor(red: 29/255.0, green: 29/255.0, blue: 38/255.0, alpha: 0.1)
  }
  
  struct FlightStatus {
    static let standard = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0)
    static let onTime = UIColor(red: 7.0/255.0, green: 104.0/255.0, blue: 147.0/255.0, alpha: 1.0)
    static let delayed = UIColor(red: 195.0/255.0, green: 32.0/255.0, blue: 38.0/255.0, alpha: 1.0)
    static let landing = UIColor(red: 126.0/255.0, green: 211.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    static let landed = standard
    static let separator = UIColor(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha: 1.0)
    static let tableHeader = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
  }

  struct FlightCell {
    static let darkBackground = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
    static let lightBackground = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
  }
  
  struct TabBar {
    static let background = UIColor(red: 63.0/255.0, green: 64.0/255.0, blue: 67.0/255.0, alpha: 1.0)
  }
  
  struct Trip {
    static let title = UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 90.0/255.0, alpha: 1.0)
    static let subtitle = UIColor(red: 44.0/255.0, green: 124.0/255.0, blue: 149.0/255.0, alpha: 1.0)
    static let divider = title
    
    struct Notification {
      static let red = UIColor(red: 248/255.0, green: 217/255.0, blue: 221/255.0, alpha: 1.0)
      static let green = UIColor(red: 242/255.0, green: 248/255.0, blue: 245/255.0, alpha: 1.0)
    }
    
    struct Time {
      static let title = UIColor(red: 0/255.0, green: 89.0/255.0, blue: 120.0/255.0, alpha: 1.0)
      static let subtitle = UIColor(red: 72.0/255.0, green: 136.0/255.0, blue: 158.0/255.0, alpha: 1.0)
      static let background = UIColor(red: 243.0/255.0, green: 246.0/255.0, blue: 248.0/255.0, alpha: 1.0)
    }
  }
}
